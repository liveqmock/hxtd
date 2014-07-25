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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.customer.entity.Contact;
import com.baihui.hxtd.soa.customer.service.ContactService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
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
@SessionAttributes(value = { Constant.VS_USER, Constant.VS_USER_ID, Constant.VS_DATASHIFT })
public class ContactController extends CommonController<Contact> {

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
	public String toAddPage(ModelMap model) {
		initPageDic(model);
		Contact contact = new Contact();
		User user = (User) model.get(Constant.VS_USER);
		contact.setOwner(user);
		
		model.addAttribute("contact", contact);// 初始化联系人

		return "/customer/contact/edit";
	}

	/**
	  * add(新增联系人)
	  * @Description: 新增一条联系人记录
	  * @param contact 联系人实体
	  * @param userId 操作用户id
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String add(Contact contact, 
			String contactType,
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		User user = new User(userId);
		contact.setCreator(user);
		contact.setModifier(user);
		contact.setCreatedTime(new Date());
		if(contactType.equals("customer")){
			contact.setSupplier(null);
		} else {
			contact.setCustomer(null);
		}
		
		/************ 新增 *****************************/
		AuditLog auditLog = new AuditLog(EnumModule.CONTACT.getModuleName(), 
				contact.getId(), contact.getName(), EnumOperationType.ADD.getOperationType(), user);
		contactService.add(contact, user, auditLog);
		
		return JsonDto.add(contact.getId()).toString();
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
	public String toModifyPage(Long id, ModelMap model) {
		initPageDic(model);
		model.addAttribute("contact", contactService.get(id));
		
		return "/customer/contact/edit";
	}

	/**
	  * modify(修改联系人)
	  * @Description: 保存修改后的联系人信息
	  * @param contact 联系人实体
	  * @param userId 操作用户ID
	 */
	@ResponseBody
	@RequestMapping(value = "/modify.do")
	public String modify(Contact contact, 
			String contactType, 
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		User user = new User(userId);
		contact.setModifier(user);
		if(contactType.equals("customer")){
			contact.setSupplier(null);
		} else {
			contact.setCustomer(null);
		}
		
		AuditLog auditLog = new AuditLog(EnumModule.CONTACT.getModuleName(), 
				contact.getId(), contact.getName(), EnumOperationType.MODIFY.getOperationType(), user);
		contactService.modify(contact, user, auditLog);
		
		return JsonDto.modify(contact.getId()).toString();
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
	public String delete(ModelMap modelMap, Long[] id) {
		User user = (User)modelMap.get(Constant.VS_USER);
		
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.CONTACT.getModuleName(), 
					id[i], contactService.getNameById(id[i]), EnumOperationType.DELETE.getOperationType(), user);
		}
		contactService.delete(user, id, auditLogArr);
		
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
	private void initPageDic(ModelMap model){
		List<Dictionary> dict = dictionaryService.findChildren("040101");//线索来源
		if(null == dict){
			dict = new ArrayList<Dictionary>();
		}
		model.addAttribute("dict", dict);
	}
}
