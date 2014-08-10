package com.baihui.hxtd.soa.common.controller;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.common.imports.excel.ExcelParse;
import com.baihui.hxtd.soa.common.service.ImportService;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.util.JsonDto;
import com.baihui.hxtd.soa.util.PropertyManager;

/**
 * 功能描述：导入控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.ImportController.java
 * @version (版本) 1
 * @date 2014-7-6 上午10:17:53
 *
 */
@Controller
@SessionAttributes(value={Constant.VS_USER})
public class ImportController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private ImportService importService;
	
	
	/**
	 * 跳转到import页面
	 * /{module}/imports/toImportPage.do  表示,拦截符合这种规则的请求
	 * @param modelMap
	 * @return
	 * @throws NoSuchFieldException
	 */
	@RequestMapping(value = "/{module}/imports/toImportPage.do",produces = "text/text;charset=UTF-8")
	public String toImportPage(@PathVariable String module, Model model) throws NoSuchFieldException{
		model.addAttribute("userTemplement", "user.xls");
		//枚举获取导入文件的类型
		EnumModule[] enumModule = EnumModule.values();
		model.addAttribute("moduleName",module);
		model.addAttribute("enumModules",enumModule);
		//导入的模板
		model.addAttribute("templateLead", "lead.xlsx");
		model.addAttribute("templateContact", "contact.xlsx");
		model.addAttribute("templateCustomer", "customer.xlsx");
		model.addAttribute("templateSupplier", "supplier.xlsx");
		model.addAttribute("templateRecycleBin", "recyclebin.xlsx");
		return "/common/imports/import";
	}
	
	/**
	 * 单击导入按钮,执行导入功能
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/{module}/imports/import.do", produces = "text/text;charset=UTF-8", method=RequestMethod.POST)
	public String imports(MultipartFile file, HttpSession session,
            @RequestParam(required=false) String duplicateType,
            @RequestParam(required=false) List<String> checkWay,
            @RequestParam(required=false) String moduleName,
            @ModelAttribute(Constant.VS_USER) User sessionUser,
            @ModelAttribute(Constant.VS_ORG) Organization organization,
            ModelMap modelMap,
            RedirectAttributes model) throws IOException, InvalidFormatException, InstantiationException, IllegalAccessException, ClassNotFoundException, ParseException {
		
		logger.info("导入excel文件");
		
		//记录开始导入时间
		Date beginTime = importService.getDBNow();
		
		/**
		 * 初始化静态变量,每次导入都清空集合
		 */
		/*ImportMessage.totalCount = 0;
		ImportMessage.workbookRepeatRowNums = new TreeSet<Integer>();
		ImportMessage.workbookRepeats = new HashMap<String,Set<Integer>>();
		ImportMessage.invalidFormatRowNumMap = new HashMap<Integer, String>();
		ImportMessage.databaseRepeatRowNums = new TreeSet<Integer>();
		ImportMessage.databaseNewRowNums = new ArrayList<Integer>();
		ImportMessage.message = "";*/

		logger.info("检查文件是否为空");
		String msg = "";
		
        logger.info("校验文件基本信息");
        JsonDto json = null;
		
        msg = checkFileItem(file,modelMap);
        
        if(!"".equals(msg)){
        	logger.info("文件导入失败:" + ImportMessage.message);
        	//导入失败的原因
        	json = new JsonDto(ImportMessage.message);
     		json.setSuccessFlag(false);
        	return json.toString();
        }

        logger.info("根据excel文件解析出对象集合");
        //获取模块的首字母大写
        StringBuffer moduleValue = new StringBuffer(moduleName.substring(0, 1).toUpperCase()+moduleName.substring(1));
        moduleValue.insert(0, "ExcelParse4");
        moduleValue.insert(0, "com.baihui.hxtd.soa.common.imports.excel.");
        ExcelParse excelParse = (ExcelParse) Class.forName(moduleValue.toString()).newInstance();
        List entityList = excelParse.parse(file, checkWay);
        
        //显示导入结果
        String importResult = "导入结果：";
        if(entityList == null || entityList.size()==0){
        	if(ImportMessage.invalidFormatMessage() != null && !"".equals(ImportMessage.invalidFormatMessage())){
        		importResult += ImportMessage.importResult() +";";
        		importResult +=ImportMessage.invalidFormatMessage();
        	}else{
        		logger.info("导入失败：解析文件内容为空");
        		importResult +="导入失败：解析文件内容为空!";
        	}
        	json = new JsonDto(importResult);
     		json.setSuccessFlag(false);
        	return json.toString();
        }
        
        
        
        
        logger.info("导入数据到DB");
        try {
			importService.import2DB(entityList, checkWay, duplicateType, moduleName,sessionUser);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		//记录导入结束时间
		Date endTime = importService.getDBNow();
		//导入记录时间
		//int spendTime = (int) ((endTime.getTime() - beginTime.getTime()) /(1000*60));
		int spendTime2 = (int) ((endTime.getTime() - beginTime.getTime()) %(1000*60));

        logger.info("导入完成");
        //model.addFlashAttribute(ImportMessage.message, "导入成功");
        //获取导入的整体结果
        importResult += ImportMessage.importResult() +";";
        //获取excel内部数据重复的列表
        importResult += ImportMessage.workbookRepeatMessage() + ";";
        //因数据格式不正确忽略的记录
        importResult += ImportMessage.invalidFormatMessage() + ";";
        //修改数据的记录数
        importResult += ImportMessage.databaseRepeatMessage("merge".equals(duplicateType) ? "合并":("jump".equals(duplicateType)?"跳过":("cover".equals(duplicateType)?"覆盖":"合并"))) + ";";
        //新增数据的记录数
        importResult += ImportMessage.databaseNewMessage()+";";
        importResult += String.valueOf(spendTime2);
        
        /**
		 * 初始化静态变量,导入完成后清空集合
		 */
		ImportMessage.totalCount = 0;
		ImportMessage.workbookRepeatRowNums = new TreeSet<Integer>();
		ImportMessage.workbookRepeats = new HashMap<String,Set<Integer>>();
		ImportMessage.invalidFormatRowNumMap = new HashMap<Integer, String>();
		ImportMessage.databaseRepeatRowNums = new TreeSet<Integer>();
		ImportMessage.databaseNewRowNums = new ArrayList<Integer>();
		ImportMessage.message = "";
       
		
        json = new JsonDto(importResult);
 		json.setSuccessFlag(true);
 		return json.toString();
	}
	
	
	/**
	 * 校验excel文件是否符合规则
	 * @param fileItem
	 * @return
	 */
	public String checkFileItem(MultipartFile fileItem, ModelMap modelMap){
		String msg = null;
		
		logger.info("检查文件是否为空");
		if ( fileItem == null ){
			msg = "导入失败：未选择导入文件";
			modelMap.addAttribute(ImportMessage.message, msg);
            return msg;
		}
		
		logger.info("校验文件名");
		String fileName = fileItem.getName();
		if(fileName == null || "".equals(fileName.trim()) ){
			msg = "导入失败：文件名为空!";
			modelMap.addAttribute(ImportMessage.message,msg );
			return msg;
		}
		
		logger.info("校验文件扩展名");
        String extension = FilenameUtils.getExtension(fileItem.getOriginalFilename());
		//允许上传的文件类型
		String excelExtension = PropertyManager.getProperty("FILENAME_EXTENSION");
		if (!excelExtension.contains(extension)) {
			msg =  "导入失败：不支持的文件类型";
            modelMap.addAttribute(ImportMessage.message,msg);
            return msg;
        }
		
		logger.info("校验文件上传容量");
		long fileMaxSize = Long.valueOf(PropertyManager.getProperty("FILE_MAX_SIZE"));
		if(fileItem.getSize() >  fileMaxSize){
			msg="导入失败：文件大小不能超过"+(fileMaxSize/1024/1024)+"MB";
			modelMap.addAttribute(ImportMessage.message, msg);
			return msg;
		}
		
		
		logger.info("校验文件内容是否为空");
		InputStream fStream = null;
		try {
			fStream = fileItem.getInputStream();
		} catch (IOException e) {
			ImportMessage.message= "导入失败：文件流读取异常";
			return msg;
		}
		if (fStream == null) {
			msg = "导入失败：导入文件内容不能为空";
			modelMap.addAttribute(ImportMessage.message, msg);
			return msg;
		}
		
		return "";
	}
	
	
	public static void main(String[] args) {
		
		Date beginTime = new Date();
		
		String moduleName = "marketActiviey";
		StringBuffer  moduleValue = new StringBuffer( moduleName.substring(0, 1).toUpperCase()+moduleName.substring(1));
		moduleValue.insert(0, "ExcelParse4");
		 moduleValue.insert(0, "com.baihui.hxtd.soa.common.imports.excel.");
		System.out.println(moduleValue.toString());
		Date endTime = new Date();
		int iDay = (int) ((beginTime.getTime() - endTime.getTime()) / 86400000);	
		System.out.println(iDay);
	}

}
