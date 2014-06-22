package com.baihui.hxtd.soa.customer.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.customer.entity.Contact;
import com.baihui.hxtd.soa.customer.service.ContactService;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 
 * 功能描述：联系人控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.customer.controller.ContactController.java
 * @version (版本) 1
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@RequestMapping(value = "/customer/contact")
@SessionAttributes(value = { Constant.VS_USER_ID, Constant.VS_DATASHIFT })
public class ContactController {

	//private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/**
	 * IOC注入 Service
	 */
	@Resource
	private ContactService contactService;
	@Resource
	private DictionaryService dictionaryService;

	/**
	  * toQueryPage(跳转列表页)
	  * @Description: 请求查看联系人列表页
	  * @param page 分页
	  * @param model Model
	  * @return String 联系人列表页视图地址
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(HibernatePage<Contact> page, Model model) {
		model.addAttribute("page", page);
		
		return "/customer/contact/list";
	}

	/**
	  * query(异步分页查询)
	  * @Description: 异步查询联系人数据
	  * @param page 分页查询结果集
	  * @param model ModelMap
	  * @param out PrintWriter
	  * @throws NoSuchFieldException,IOException
	 */
	@RequestMapping(value = "/query.do")
	public void query(HttpServletRequest request,
			HibernatePage<Contact> page,
			ModelMap model,
            PrintWriter out) throws NoSuchFieldException, IOException {
		/************获取查询条件**************/
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        
        /************分页查询*****************/
        contactService.findPage(searchParams, dataShift, page);
        
        /************json转换****************/
        JsonDto json = new JsonDto();
		json.setResult(page);
        
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}

	/**
	  * toAddPage(跳转至新增联系人页)
	  * @Description: 请求新增联系人
	  * @param model Model
	  * @return String 新增联系人视图地址
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage(Model model) {
		initPageDic(model);
		model.addAttribute("contact", new Contact());// 初始化联系人

		return "/customer/contact/edit";
	}

	/**
	  * add(新增联系人)
	  * @Description: 新增一条联系人记录
	  * @param contact 联系人实体
	  * @param redirectUri url地址
	  * @param userId 操作用户id
	  * @return String 返回修改页视图地址
	 */
	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String add(Contact contact, 
			@RequestParam(defaultValue = "/customer/contact/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		User user = new User(userId);
		contact.setCreator(user);
		contact.setModifier(user);
		contact.setCreatedTime(new Date());
		if(contact.getCustomer().getId() == null){
			contact.setCustomer(null);
		}
		if(contact.getSupplier().getId() == null){
			contact.setSupplier(null);
		}
		if(contact.getOwner().getId() == null){
			contact.setOwner(null);
		}
		if(contact.getSource().getId() == null){
			contact.setSource(null);
		}
		if(contact.getProvince().getId() == -1){
			contact.setProvince(null);
		}
		if(contact.getCity().getId() == -1){
			contact.setCity(null);
		}
		if(contact.getCounty().getId() == -1){
			contact.setCounty(null);
		}
		
		contactService.save(contact);
		
		return "redirect:" + String.format(redirectUri, contact.getId());
	}

	/**
	  * toModifyPage(跳转至修改页面)
	  * @Description: 请求修改联系人
	  * @param id 联系人主键ID
	  * @param model Model
	  * @return String 返回编辑视图地址
	  * @throws
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(Long id, Model model) {
		initPageDic(model);
		model.addAttribute("contact", contactService.get(id));
		
		return "/customer/contact/edit";
	}

	/**
	  * modify(修改联系人)
	  * @Description: 保存修改后的联系人信息
	  * @param contact 联系人实体
	  * @param redirectUri url地址
	  * @param userId 操作用户ID
	  * @param request HttpServletRequest
	  * @return String 返回编辑视图地址
	 */
	@RequestMapping(value = "/modify.do")
	public String modify(Contact contact, @RequestParam(defaultValue = "/customer/contact/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId,
			HttpServletRequest request) {
		contact.setModifier(new User(userId));
		if(contact.getCustomer().getId() == null){
			contact.setCustomer(null);
		}
		if(contact.getSupplier().getId() == null){
			contact.setSupplier(null);
		}
		if(contact.getOwner().getId() == null){
			contact.setOwner(null);
		}
		if(contact.getSource().getId() == null){
			contact.setSource(null);
		}
		if(contact.getProvince().getId() == -1){
			contact.setProvince(null);
		}
		if(contact.getCity().getId() == -1){
			contact.setCity(null);
		}
		if(contact.getCounty().getId() == -1){
			contact.setCounty(null);
		}
		
		contactService.save(contact);
		
		return String.format("redirect:" + redirectUri, contact.getId());
	}

	/**
	  * toViewPage(查看联系人信息)
	  * @Description: 请求查看联系人
	  * @param id 联系人主键ID
	  * @param model Model
	  * @return String 返回联系人视图地址
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String toViewPage(Long id, Model model) {
		model.addAttribute("contact", contactService.get(id));//获取联系人
		
		return "/customer/contact/view";
	}

	/**
	  * delete(删除联系人)
	  * @Description: 请求删除联系人，支持批量删除
	  * @param id 联系人主键IDS
	  * @return String 返回json串
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do")
	public String delete(long[] id) {
		contactService.delete(id);
		
		JsonDto json = new JsonDto("删除成功");
		json.setSuccessFlag(true);
		
		return json.toString();
	}
	
	/**
	  * exportPagination(列表页导出数据)
	  * @Description: 导出3000条联系人记录
	  * @param request HttpServletRequest
	  * @param response HttpServletResponse
	  * @param modelMap ModelMap
	  * @throws NoSuchFieldException,IOException
	 */
	@RequestMapping(value = "/export.do", params = "TYPE=pagination")
	public void exportPagination(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap modelMap) throws NoSuchFieldException, IOException{
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);
       
		DataShift dataShift = (DataShift) modelMap.get(Constant.VS_DATASHIFT);
		List<Contact> contactLst = contactService.export(searchParams, dataShift);
       
		ServletContext servletContext = request.getSession().getServletContext();
		ImportExport.exportExcel(response, servletContext, "contact", contactLst).write(response.getOutputStream());
	}

	/**
	  * initPageDic(初始化页面字典)
	  * @Description: 获取视图字典数据
	  * @param model Model
	 */
	private void initPageDic(Model model){
		List<Dictionary> dict = dictionaryService.findChildren("040101");//线索来源
		if(null == dict){
			dict = new ArrayList<Dictionary>();
		}
		model.addAttribute("dict", dict);
	}
}
