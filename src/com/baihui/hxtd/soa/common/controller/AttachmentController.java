package com.baihui.hxtd.soa.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.common.controller.model.ListModel;
import com.baihui.hxtd.soa.common.entity.Attachment;
import com.baihui.hxtd.soa.common.service.AttachmentService;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;
/**
 * 
 * 功能描述：附件控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.AttachmentController.java
 * @version (版本) 1
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@SessionAttributes(value = {Constant.VS_USER_ID})
public class AttachmentController {
	
	private static Map<String,String> moduleMap;
	
	private static final String FOLDER = "/res/";
	
	static{
		moduleMap = new HashMap<String,String>();
		moduleMap.put("supplier", "11010101");
		moduleMap.put("lead", "11010103");
		moduleMap.put("contact", "11010104");
		moduleMap.put("customer", "11010102");
	}
	@Resource
	private AttachmentService attachmentService; 
	@Resource
	private DictionaryService dictionaryService;
	
	@ResponseBody
	@RequestMapping(value="/{module}/attachment/query.do",produces = "text/text;charset=UTF-8")
	public String query(@PathVariable String module,Long id){
		Dictionary dict = dictionaryService.getByValue(moduleMap.get(module));
		List<Attachment> list = attachmentService.query(id, dict.getId());
		ListModel<Attachment> model = new ListModel<Attachment>();
		model.setList(list);
		JsonDto json = new JsonDto();
		json.setResult(model);
		return json.toString();
	}
	
	@RequestMapping(value="/{module}/attachment/view.comp")
	public String view(Model model,Long id){
		Attachment att = attachmentService.view(id);
		String[] urls =att.getAddress().split("/");
		String url = FOLDER+urls[urls.length-1];
		model.addAttribute("url",url);
		return "/common/attachment/view";
	}
	
	@RequestMapping(value="/{module}/attachment/upload.comp")
	public String view(Model model){
		List<Dictionary> list = dictionaryService.findChildren("110102");
		model.addAttribute("dict",list);
		return "/common/attachment/upload";
	}
	
	@ResponseBody
	@RequestMapping(value="/{module}/attachment/upload.do",produces = "text/text;charset=UTF-8")
	public String upload(@PathVariable String module,@ModelAttribute(Constant.VS_USER_ID) Long userId,
								String data,MultipartHttpServletRequest request) throws IOException{
		Dictionary type = dictionaryService.getByValue(moduleMap.get(module));
		String[] datas = data.split(",");
		Dictionary dict = null;
		if(datas.length==2){
			dict = new Dictionary();
			dict.setId(Long.valueOf(datas[1]));
		}
		List<MultipartFile> files=request.getFiles("file");//取得from里面的参数
        String uploadpath=request.getSession().getServletContext().getRealPath("/")+FOLDER;
        String[] names = null;
        String fName = null;
        FileOutputStream fileOS = null;
        Attachment att = null;
        for (MultipartFile file : files) {
            if (file.isEmpty()) {
            	continue;
            }
            att = new Attachment();
    		att.setType(type);
    		att.setModuleId(Long.valueOf(datas[0]));
    		att.setDict(dict);
    		att.setName(file.getOriginalFilename());
            names = file.getOriginalFilename().split("\\.");
            fName = uploadpath+randomFilename()+"."+names[names.length-1];
            att.setAddress(fName);
            att.setCreator(new User(userId));
            att.setModifier(new User(userId));
            att.setCreatedTime(new Date());
            att.setModifiedTime(new Date());
            fileOS =new FileOutputStream(fName);
            fileOS.write(file.getBytes());
            fileOS.close();
            attachmentService.save2DB(att);
        }
        JsonDto json = new JsonDto(); 
        json.setMessage("上传成功");
        json.setSuccessFlag(true);
        return json.toString();
	}
	
	private static String randomFilename(){  
        Random rand = new Random();//生成随机数  
        int random = rand.nextInt(1000);  
          
        SimpleDateFormat dateformat1=new SimpleDateFormat("yyyyMMddHHmmss");
        String fName=dateformat1.format(new Date())+random;
          
        return fName;
    }  
	
	
	@RequestMapping(value = "/{module}/attachment/download.do")
	public void download(HttpServletRequest request, 
								   HttpServletResponse response,
								   Long id)
									throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		Attachment att = attachmentService.view(id);
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		String downLoadPath = att.getAddress();
		//String downLoadPath = ctxPath + att.getAddress();
		String fileName =URLEncoder.encode(att.getName(), "UTF-8"); 
		if (fileName.length() > 150) {  
            fileName = new String(att.getName().getBytes("utf-8"), "ISO8859-1");   
        } 
		try {
			long fileLength = new File(downLoadPath).length();
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition", "attachment; filename="+fileName);
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(downLoadPath));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
	}

	public AttachmentService getAttachmentService() {
		return attachmentService;
	}



	public void setAttachmentService(AttachmentService attachmentService) {
		this.attachmentService = attachmentService;
	}



	public DictionaryService getDictionaryService() {
		return dictionaryService;
	}



	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}
	
}
