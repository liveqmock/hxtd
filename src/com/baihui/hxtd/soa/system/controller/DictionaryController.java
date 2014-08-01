package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.BusinessResult;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;

@Controller
@RequestMapping(value = "/system/dictionary")
@SessionAttributes(value = { Constant.VS_USER_ID, Constant.VS_USER })
public class DictionaryController {
	@Resource
	private DictionaryService dicService;
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
	/**
	  * toQueryPage(请求查看字典列表)
	  * @Title: toQueryPage
	  * @Description: 请求查看字典列表
	  * @param page 分页
	  * @param model Model
	  * @return String 字典列表页地址
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(HibernatePage<Dictionary> page, Model model) {
		model.addAttribute("types", dicService.getDicTypes()); //字典分类

		/*****************分页设置******************/
		page.setHibernateOrderBy("modifiedTime"); //修改时间倒序
		page.setHibernateOrder(HibernatePage.DESC);
		model.addAttribute("page", page);

		return "/system/dictionary/list";
	}
	/**
	  * anscyQuery(异步加载数据列表)
	  * @Title: anscyQuery
	  * @Description: 分页异步加载数据
	  * @param request HTTP请求
	  * @param page 分页
	  * @param out PrintWriter
	  * @throws NoSuchFieldException,IOException
	 */
	@RequestMapping(value = "/query.do")
	public void anscyQuery(HttpServletRequest request, HibernatePage<Dictionary> page, PrintWriter out) throws NoSuchFieldException, IOException {
		/*************获取查询条件 **************/
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);

		/*************分页查询 *****************/
		dicService.findPage(searchParams, page);

		/*************JSON转换 ****************/
		JsonDto json = new JsonDto();
		json.setResult(page);

		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	/**
	  * anscyQuery(异步加载子类字典数据列表)
	  * @Title: anscyQuery
	  * @Description: 加载子类字典数据
	  * @param request HTTP请求
	  * @param parentId 父ID
	  * @param out PrintWriter
	  * @throws IOException
	 */
	@RequestMapping(value = "/query.do", params = { "TYPE=childlst" })
	public void anscyQuery(HttpServletRequest request, Long parentId, PrintWriter out) throws IOException {
		/************JSON转换 ****************/
		JsonDto json = new JsonDto();
		json.setResult(new BusinessResult<List<Dictionary>>(dicService.findChildDicLst(parentId)));

		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	/**
	  * toAddPage(请求跳转至新增字典页)
	  * @Title: toAddPage
	  * @Description: 请求跳转至新增字典页
	  * @param model Model
	  * @return String 字典视图页
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage(Model model) {
		Dictionary dic = new Dictionary();
		dic.setOrder(Long.parseLong("1"));
		model.addAttribute("dictionary", dic); //初始化字典
		model.addAttribute("types", dicService.getDicTypes()); //字典分类

		return "/system/dictionary/edit";
	}
	/**
	  * add(新增字典)
	  * @Title: add
	  * @Description: 异步请求新增字典
	  * @param dictionary 字典实体
	  * @param userId 当前操作用户
	  * @return String 新增消息
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String add(Dictionary dictionary, @ModelAttribute(Constant.VS_USER_ID) Long userId) {
		User user = new User(userId);
		dictionary.setCreator(user);
		dictionary.setModifier(user);
		dictionary.setCreatedTime(new Date());
		
		/****************审计日志**********************/
		AuditLog auditLog = new AuditLog(EnumModule.DICTIONARY.getModuleName(),
				dictionary.getId(), dictionary.getKey(), EnumOperationType.ADD.getOperationType(), user, "字典增加");
		dicService.add(dictionary, auditLog);

		return JsonDto.add(dictionary.getId()).toString();
	}
	/**
	  * toModifyPage(请求跳转至修改页面)
	  * @Title: toModifyPage
	  * @Description: 请求跳转至修改页面
	  * @param id 字典主键ID
	  * @param model Model
	  * @return String 返回编辑视图地址
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(Long id, Model model) {
		model.addAttribute("dictionary", dicService.get(id));
		model.addAttribute("types", dicService.getDicTypes());// 字典类型

		return "/system/dictionary/edit";
	}
	/**
	  * modify(修改字典信息)
	  * @Title: modify
	  * @Description: 异步请求修改字典信息
	  * @param dict 字典实体
	  * @param userId 当前操作用户
	  * @return String 修改信息
	 */
	@ResponseBody
	@RequestMapping(value = "/modify.do")
	public String modify(Dictionary dictionary, @ModelAttribute(Constant.VS_USER_ID) Long userId) {
		User user = new User(userId);
		dictionary.setModifier(user);

		/****************审计日志**********************/
		AuditLog auditLog = new AuditLog(EnumModule.DICTIONARY.getModuleName(),
				dictionary.getId(), dictionary.getKey(), EnumOperationType.MODIFY.getOperationType(), user, "字典修改");
		dicService.modify(dictionary, auditLog);

		return JsonDto.modify(dictionary.getId()).toString();
	}
	/**
	  * toViewPage(请求查看字典信息)
	  * @Title: toViewPage
	  * @Description: 请求查看字典信息
	  * @param id 字典主键ID
	  * @param model Model
	  * @return String 返回字典视图地址
	  * @throws
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String toViewPage(Long id, Model model) {
		model.addAttribute("dictionary", dicService.get(id));// 获取字典

		return "/system/dictionary/view";
	}
	/**
	  * delete(删除字典信息)
	  * @Title: delete
	  * @Description: 删除字典信息
	  * @param modelMap ModelMap
	  * @param id 字典主键IDS
	  * @return String 删除信息
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do")
	public String delete(ModelMap modelMap, Long[] id) {
		User user = (User) modelMap.get(Constant.VS_USER);
		
		AuditLog[] auditLogArr = new AuditLog[id.length];
		for (int i = 0; i < id.length; i++) {
			auditLogArr[i] = new AuditLog(EnumModule.DICTIONARY.getModuleName(), 
				id[i], 
				dicService.getNameById(id[i]), 
				EnumOperationType.DELETE.getOperationType(), 
				user, 
				"字典删除"
			);
		}
		dicService.delete(id, auditLogArr);

		return JsonDto.delete(id).toString();
	}
}
