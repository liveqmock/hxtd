package com.baihui.hxtd.soa.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
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
import org.springframework.ui.ModelMap;
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
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;
import com.baihui.hxtd.soa.util.Tools;
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
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_USER_ID})
public class AttachmentController {
	
	private static Map<String,String> moduleMap;
	
	/**
	 * 保存附件的目录
	 */
	private static final String FOLDER = "res";
	
	/**
	 * 添加到常量里,写到枚举里
	 */
	static{
		moduleMap = new HashMap<String,String>();
		moduleMap.put("supplier", DictionaryConstant.RELATIVE_MODULE_SUPPLIER);
		moduleMap.put("customer", DictionaryConstant.RELATIVE_MODULE_CUSTOMER);
		moduleMap.put("lead", DictionaryConstant.RELATIVE_MODULE_LEAD);
		moduleMap.put("contact", DictionaryConstant.RELATIVE_MODULE_CONTACT);
		moduleMap.put("project", DictionaryConstant.RELATIVE_MODULE_PROJECT);
		moduleMap.put("contract", DictionaryConstant.RELATIVE_MODULE_CONTRACT);
	}
	@Resource
	private AttachmentService attachmentService; 
	@Resource
	private DictionaryService dictionaryService;
	
	/**
	 * 跳转到附件上传页面
	 * 拦截符合/{module}/attachment/query.do规则的所有请求
	 * @param module  :  @PathVariable String module 获取路径中的参数变量
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/{module}/attachment/query.do",produces = "text/text;charset=UTF-8")
	public String query(@PathVariable String module,Long id){
		Dictionary dict = dictionaryService.getByValue(moduleMap.get(module));
		/*
		 * 当前模块,当前记录的所有附件,无分页
		 */
		List<Attachment> list = attachmentService.query(dict.getId(),id);
		ListModel<Attachment> model = new ListModel<Attachment>();
		model.setList(list);
		JsonDto json = new JsonDto();
		json.setResult(model);
		return json.toString();
	}
	/**
	 * view.comp拦截的是一个组件.什么是组件呢?正常的页面有header和footer部分,
	 * 如果一个页面你不想让他有header和footer,我们就将其看做一个组件
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/{module}/attachment/view.comp")
	public String view(Model model,Long id){
		Attachment att = attachmentService.view(id);
		/**
		 * 识别当前系统,返回不同的分隔符,"/"或者"\"
		 */
		String separator = File.separator;
		/**
		 * 获得文件名.(随机生成的文件名,不是源文件名)
		 */
		String[] urls =att.getAddress().split("\\"+separator);
		String url = "/"+FOLDER+"/"+urls[urls.length-1];
		model.addAttribute("url",url);
		return "/common/attachment/view";
	}
	
	/**
	 * 打开上传的组件
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/{module}/attachment/upload.comp")
	public String view(Model model){
		List<Dictionary> list = dictionaryService.findChildren(DictionaryConstant.VC_ATTACHMENT_TYPE, true);
		model.addAttribute("dict",list);
		return "/common/attachment/upload";
	}
	
	@ResponseBody
	@RequestMapping(value="/{module}/attachment/upload.do",produces = "text/text;charset=UTF-8")
	public String upload(@PathVariable String module,@ModelAttribute(Constant.VS_USER_ID) Long userId,
								String data,MultipartHttpServletRequest request) throws IOException{
		Dictionary moduleD = dictionaryService.getByValue(moduleMap.get(module));
		String[] datas = data.split(",");
		Dictionary dict = null;
		if(datas.length==2){
			dict = new Dictionary();
			dict.setId(Long.valueOf(datas[1]));
		}
		List<MultipartFile> files=request.getFiles("file");//取得from里面的参数
		String separator = File.separator;
        String uploadpath=request.getSession().getServletContext().getRealPath("/")+FOLDER+separator;
        String[] names = null;
        String fName = null;
        FileOutputStream fileOS = null;
        Attachment att = null;
        for (MultipartFile file : files) {
            if (file.isEmpty()) {
            	continue;
            }
            att = new Attachment();
    		att.setModule(moduleD);
    		att.setRecordId(Long.valueOf(datas[0]));
    		att.setType(dict);
    		att.setName(file.getOriginalFilename());
            names = file.getOriginalFilename().split("\\.");
            fName = uploadpath+randomFilename()+"."+names[names.length-1];
            att.setAddress(fName);
            User user = new User(userId);
            att.setCreator(user);
            att.setModifier(user);
            /**
             * 改成获取数据库时间
             */
            att.setCreatedTime(new Date());
            att.setModifiedTime(new Date());
            fileOS =new FileOutputStream(fName);
            fileOS.write(file.getBytes());
            fileOS.close();
            attachmentService.add(att, user);
        }
        JsonDto json = new JsonDto(); 
        json.setMessage("上传成功");
        json.setSuccessFlag(true);
        return json.toString();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/{module}/attachment/delete.do",produces = "text/text;charset=UTF-8")
	public String query(ModelMap modelMap, Long[] id){
		User user = (User)modelMap.get(Constant.VS_USER); 
		attachmentService.delete(user, id);
		JsonDto json = JsonDto.delete(id);
		return json.toString();
	}
	/**
	 * 随机生成文件名
	 * @return
	 */
	private static String randomFilename(){  
        Random rand = new Random();//生成随机数  
        int random = rand.nextInt(1000);  
          
        String fName=Tools.fomatDate("yyyyMMddHHmmss")+random;
          
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
		/**
		 * 
		 */
		String downLoadPath = att.getAddress();
		//String downLoadPath = ctxPath + att.getAddress();
		
		String fileName =URLEncoder.encode(att.getName(), "UTF-8");
		/**
		 * 当名称过长的时候,解决ie无法下载的问题
		 */
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
			/**
			 * 规定每次写数据的大小.读2048,写2048
			 */
			byte[] buff = new byte[2048];
			//每次读取的字节数
			int bytesRead;
			/**
			 * 向客户端写数据
			 */
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
