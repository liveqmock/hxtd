package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

@Controller
@RequestMapping(value = "/system/dictionary")
@SessionAttributes(value = { Constant.VS_USER_ID, Constant.VS_USER})
public class DictionaryController {
	// private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	private DictionaryService dicService;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

	/**
	 * toQueryPage(跳转字典列表页)
	 * @Description: 请求查看字典列表
	 * @param page 分页
	 * @param model Model
	 * @return String 字典列表页地址
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(HibernatePage<Dictionary> page, Model model) {
		model.addAttribute("types", dicService.getDicTypes());//字典类型
		model.addAttribute("page", page);

		return "/system/dictionary/list";
	}

	/**
	 * anscyQuery(异步加载数据列表)
	 * @Description: 分页异步加载数据
	 * @param request HttpServletRequest
	 * @param page 分页
	 * @throws NoSuchFieldException, IOException
	 */
	@RequestMapping(value = "/query.do")
	public void anscyQuery(HttpServletRequest request,
			HibernatePage<Dictionary> page, PrintWriter out)
			throws NoSuchFieldException, IOException {
		/************ 获取查询条件 **************/
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);

		/************ 分页查询 *****************/
		dicService.findPage(searchParams, page);

		/************ json转换 ****************/
		JsonDto json = new JsonDto();
		json.setResult(page);

		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}

	/**
	  * toAddPage(跳转至新增字典页)
	  * @Description: 请求新增字典
	  * @param model Model
	  * @return String 字典视图页
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage(Model model) {
		model.addAttribute("dictionary", new Dictionary());// 初始化字典
		model.addAttribute("types", dicService.getDicTypes());//字典类型
		model.addAttribute("dict", dicService.getDictJsonData());//字典层级树形(不包含字典类型)
		
		return "/system/dictionary/edit";
	}
	
	/**
	  * add(新增字典)
	  * @Description: 新增一条字典数据
	  * @param dict 字典实体
	  * @param typename 分类
	  * @param redirectUri 重定向视图
	  * @param userId 操作用户id
	 */
	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String add(Dictionary dict, 
			String typename,
			@RequestParam(defaultValue = "/system/dictionary/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		if(dict.getParent().getId() == null){
			dict.setParent(null);
		}
		if(!dict.getType().equals("0")){//非字典类型
			dict.setType(typename);
		}else{
			dict.setType(null);
		}
		User user = new User(userId);
		dict.setCreator(user);
		dict.setModifier(user);
		dict.setCreatedTime(new Date());
		
		dicService.save(dict);
		
		return "redirect:" + String.format(redirectUri, dict.getId());
	}
	
	/**
	  * toModifyPage(跳转至修改页面)
	  * @Description: 请求修改字典
	  * @param id 字典主键ID
	  * @param model Model
	  * @return String 返回编辑视图地址
	  * @throws
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(Long id, Model model) {
		model.addAttribute("dictionary", dicService.get(id));
		model.addAttribute("types", dicService.getDicTypes());//字典类型
		model.addAttribute("dict", dicService.getDictJsonData());//字典层级树形(不包含字典类型)
		
		return "/system/dictionary/edit";
	}

	/**
	  * modify(修改字典)
	  * @Description: 保存修改后的字典信息
	  * @param dict 字典实体
	  * @param typename 分类
	  * @param redirectUri 重定向视图
	  * @param userId 操作用户id
	 */
	@RequestMapping(value = "/modify.do")
	public String modify(Dictionary dict, 
			String typename,
			@RequestParam(defaultValue = "/system/dictionary/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		if(dict.getParent().getId() == null){
			dict.setParent(null);
		}
		if(!dict.getType().equals("0")){//非字典类型
			dict.setType(typename);
		}else{
			dict.setType(null);
		}
		dict.setModifier(new User(userId));
		
		dicService.save(dict);
		
		return "redirect:" + String.format(redirectUri, dict.getId());
	}
	
	/**
	  * toViewPage(查看字典信息)
	  * @Description: 请求查看字典
	  * @param id 字典主键ID
	  * @param model Model
	  * @return String 返回字典视图地址
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String toViewPage(Long id, Model model) {
		model.addAttribute("dictionary", dicService.get(id));//获取字典
		
		return "/system/dictionary/view";
	}

	/**
	  * delete(删除字典)
	  * @Description: 请求删除字典，支持批量删除
	  * @param id 字典主键IDS
	  * @return String 返回json串
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do")
	public String delete(Long[] id) {
		dicService.delete(id);
		
		JsonDto json = new JsonDto("删除成功");
		json.setSuccessFlag(true);
		
		return json.toString();
	}
}
