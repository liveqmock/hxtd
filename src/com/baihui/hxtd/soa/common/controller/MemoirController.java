package com.baihui.hxtd.soa.common.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.entity.Memoir;
import com.baihui.hxtd.soa.common.service.MemoirService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
/**
 * 
 * 功能描述：联系纪要控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.MemoirController.java
 * @version (版本) 1
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_USER_ID, Constant.VS_ORG})
public class MemoirController {

	@Resource
	private MemoirService memoirService;
	@Resource
	private DictionaryService dictionaryService;
	//模块字典类型
	private static Map<String,String> moduleMap;
	static{
		moduleMap = new HashMap<String,String>();
		moduleMap.put("supplier", "11010101");
		moduleMap.put("lead", "11010103");
		moduleMap.put("contact", "11010104");
		moduleMap.put("customer", "11010102");
	}
	
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }

	/**
	  * findPage(查询模块相关联系纪要)
	  * @Description: 查询模块相关联系纪要
	  * @param request HttpServletRequest
	  * @param page 分页
	  * @param moduleId 模块主键id
	  * @param moduleType 模块类型
	  * @param out PrintWriter
	  * @throws IOException 
	 */
	@RequestMapping(value = "/{moduleType}/memoir/query.do")
	public void query(HttpServletRequest request,
			HibernatePage<Memoir> page,
			@RequestParam(value = "moduleId") Long moduleId,
			@RequestParam(value = "moduleType") String moduleType,
			PrintWriter out) throws IOException {
        /************分页查询*****************/
		Dictionary dic = dictionaryService.getByValue(moduleMap.get(moduleType));
		memoirService.findPage(moduleId, dic.getId(), page);
		
		/************json转换****************/
		JsonDto json = new JsonDto();
		json.setResult(page);
		
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	
	/**
	  * toAddPage(跳转至新增纪要页)
	  * @Description: 请求联系纪要页
	  * @param model ModelMap
	  * @return String 新增联系纪要地址页
	 */
	@RequestMapping(value = "/{moduleType}/memoir/toAddPage.doself")
	public String toAddPage(ModelMap model){
		model.addAttribute("memoir", new Memoir());
		
		return "/common/memoir/edit";
	}
	
	/**
	  * add(新增联系纪要)
	  * @Description: 新增一条联系纪要
	  * @param memoir 联系纪要实体
	  * @param moduleId 模块主键id
	  * @param moduleType 模块类型
	  * @param userId 操作用户id
	  * @return String 返回修改页视图地址
	 */
	@ResponseBody
	@RequestMapping(value = "/{moduleType}/memoir/add.do", method = RequestMethod.POST)
	public String add(Memoir memoir,
			@RequestParam(value = "moduleId") Long moduleId,
			@RequestParam(value = "moduleType") String moduleType,
			@ModelAttribute(Constant.VS_USER_ID) Long userId,
			ModelMap map) {
		Dictionary dic = dictionaryService.getByValue(moduleMap.get(moduleType));
		memoir.setType(dic);//模块类型
		memoir.setModuleId(moduleId);//模块主键ID
		
		Organization org = (Organization) map.get(Constant.VS_ORG);
		memoir.setOrg(org);
		
		User user = new User(userId);
		memoir.setCreator(user);
		memoir.setModifier(user);
		memoir.setCreatedTime(new Date());
		memoir.setModifiedTime(new Date());
		memoir.setEmployee(user);
		
		AuditLog auditLog = new AuditLog(EnumModule.MEMOIR.getModuleName(), 
				memoir.getId(), memoir.getSummary(), EnumOperationType.ADD.getOperationType(), user);
		memoirService.add(memoir, user, auditLog);
		
		return JsonDto.add(memoir.getId()).toString();
	}
	
	/**
	  * toModifyPage(跳转至修改页面)
	  * @Description: 请求修改联系纪要页
	  * @param id 联系纪要主键ID
	  * @param model Model
	  * @return String 编辑页地址信息
	 */
	@RequestMapping(value = "/{moduleType}/memoir/toModifyPage.doself")
	public String toModifyPage(Long id, ModelMap model) {
		model.addAttribute("memoir", memoirService.get(id));
		
		return "/common/memoir/edit";
	}
	
	/**
	  * modify(修改联系纪要)
	  * @Description: 保存修改后的联系纪要信息
	  * @param memoir 联系纪要实体
	  * @param moduleId 模块主键ID
	  * @param moduleType 模块类型
	  * @param userId 操作用户ID
	  * @param map ModelMap
	  * @return String 编辑页地址信息
	 */
	@ResponseBody
	@RequestMapping(value = "/{moduleType}/memoir/modify.do")
	public String modify(Memoir memoir,
			@RequestParam(value = "moduleId") Long moduleId,
			@RequestParam(value = "moduleType") String moduleType,
			@ModelAttribute(Constant.VS_USER_ID) Long userId,
			ModelMap map) {
		Dictionary dic = dictionaryService.getByValue(moduleMap.get(moduleType));
		memoir.setType(dic);//模块类型
		memoir.setModuleId(moduleId);//模块主键ID
		
		Organization org = (Organization) map.get(Constant.VS_ORG);
		memoir.setOrg(org);
		
		User user = new User(userId);
		memoir.setModifier(user);
		memoir.setEmployee(user);
		
		AuditLog auditLog = new AuditLog(EnumModule.MEMOIR.getModuleName(), 
				memoir.getId(), memoir.getSummary(), EnumOperationType.MODIFY.getOperationType(), user);
		memoirService.modify(memoir, user, auditLog);
		
		return JsonDto.modify(memoir.getId()).toString();
	}
	
	/**
	  * toViewPage(查看联系纪要)
	  * @Description: 查看联系纪要
	  * @param id 联系纪要主键ID
	  * @param model Model
	  * @return String 查看页地址
	 */
	@RequestMapping(value = "/{moduleType}/memoir/toViewPage.doself")
	public String toViewPage(Long id, Model model) {
		model.addAttribute("memoir", memoirService.get(id));
		
		return "/common/memoir/view";
	}

	/**
	  * delete(删除联系纪要)
	  * @Description: 删除联系纪要
	  * @param id 联系纪要主键ID
	  * @return String Json串
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/{moduleType}/memoir/delete.do")
	public String delete(ModelMap modelMap, Long[] id) {
		User user = (User)modelMap.get(Constant.VS_USER);
		
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.MEMOIR.getModuleName(), 
					id[i], memoirService.getSummaryById(id[i]), EnumOperationType.DELETE.getOperationType(), user);
		}
		memoirService.delete(user, id);
		
		return JsonDto.delete(id).toString();
	}	
}
