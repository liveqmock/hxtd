
package com.baihui.hxtd.soa.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
import com.baihui.hxtd.soa.project.entity.Project;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.project.service.ProjectService;
import com.baihui.hxtd.soa.project.service.SupplierService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

@Controller
@RequestMapping(value = "/project/supplier")
@SessionAttributes(value = {Constant.VS_DATASHIFT, Constant.VS_USER})
public class SupplierController extends CommonController<Supplier> {
	
	 private Logger logger = LoggerFactory.getLogger(this.getClass());
	 /**
	  * 注入service
	  */
	 @Resource
	 private SupplierService supplierService;
	 
	 @Resource
	 private DictionaryService dictionaryService;
	 
	 @Resource
	 private ContactService contectService;
	 
	 @Resource
	 private ProjectService projectService;
	 /**
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 * @throws NoSuchFieldException 
	   * query(分页查询)
	   * @Title: query
	   * @param @param page
	   * @param @return    参数类型
	   * @return ModelAndView    返回类型
	   * @throws
	  */
	@RequestMapping(value = "/query.do",produces = "text/text;charset=UTF-8")
	public void query(HibernatePage<Supplier> page,
								HttpServletRequest request,ModelMap model,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException{
		logger.info("SupplierController.query查询组件列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);		
		page = supplierService.findPage(searchParams,dataShift, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	
	 /**
	   * toQueryPage(跳转列表页)
	   * @Title: toQueryPage
	   * @param @param 
	   * @param @return    参数类型
	   * @return ModelAndView    返回类型
	   * @throws
	  */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(ModelMap model) throws NoSuchFieldException {
        logger.info("转至查询页面");

        logger.info("存储表单初始化数据");

        logger.info("存储表单默认值");
        HibernatePage<Supplier> page = new HibernatePage<Supplier>();
        model.addAttribute("page", page);
		List<Dictionary> dict = dictionaryService.findChildren("050101");
		model.addAttribute("dict",dict);
		return "/project/supplier/list";
	}
	/**
	  * view(查询单个组件信息)
	  * @Title: view
	  * @param @param type
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required=false)Long id,
							  Model model){
		logger.info("SupplierController.view查询组件");
		Supplier com = supplierService.get(id);
		List<Contact> contacts = contectService.findContactBySupplier(com);
		List<Project> projects = projectService.findProjectBySupplier(com);
		model.addAttribute("com",com);
		model.addAttribute("contacts",contacts);
		model.addAttribute("projects",projects);
		return "/project/supplier/view";
	}
	/**
	 * 
	  * viewCom(查询简单的供应商信息)
	  * @Title: viewCom
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toViewPage.comp")
	public String viewCom(@RequestParam(required=false)Long id,
							  Model model){
		logger.info("SupplierController.view查询组件");
		Supplier com = supplierService.get(id);
		model.addAttribute("com",com);
		return "/project/supplier/viewcomp";
	}
	
	/**
	  * toAddPage(跳转新增页面)
	  * @Title: view
	  * @param @param type
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage(ModelMap model){
		logger.info("SupplierController.view查询组件");
		String funcUrl="/project/supplier/add.do";
		model.addAttribute("type",dictionaryService.findChildren("050101"));
		model.addAttribute("cardType",dictionaryService.findChildren("040303"));
		model.addAttribute("funcUrl", funcUrl);
		Supplier com = new Supplier();
		com.setOwner((User)model.get(Constant.VS_USER));
		model.addAttribute("com",com);
		return "/project/supplier/edit";
	}
	/**
	 * 
	  * toModifyPage(跳转修改页面)
	  * @Title: toModifyPage
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(@RequestParam(required=false)Long id,
							  Model model){
		logger.info("SupplierController.toModifyPage查询组件");
		String funcUrl="/project/supplier/modify.do";
		Supplier com  = supplierService.get(id);
		setDefaultDict(model);
		model.addAttribute("com",com);
		model.addAttribute("funcUrl", funcUrl);
		return "/project/supplier/edit";
	}
	
	
	
	
	private void setDefaultDict(Model model){
		model.addAttribute("type",dictionaryService.findChildren("050101"));
		model.addAttribute("cardType",dictionaryService.findChildren("040303"));
	}
	/**
	  * modify(保存：修改)
	  * @Title: modify
	  * @param  Supplier组件实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
	public String modify(Supplier supplier,String type,HttpServletRequest request){
		logger.info("SupplierController.modify修改组件信息");
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		supplier.setModifier(u);
		AuditLog auditLog = new AuditLog(EnumModule.SUPPLIER.getModuleName(), 
				supplier.getId(), supplier.getName(), EnumOperationType.MODIFY.getOperationType(), u);
		supplierService.modify(supplier, auditLog);
		JsonDto json = new JsonDto(supplier.getId(),"保存成功!");
		return json.toString();
	}
	/**
	 * 
	  * add(保存：新建)
	  * @Title: add
	  * @param  Supplier组件实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
	public String add(Supplier supplier,String type,HttpServletRequest request){
		logger.info("SupplierController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("SupplierController.query 获得当前操作的用户{}",u.getName());
		supplier.setCreator(u);
		supplier.setModifier(u);
		AuditLog auditLog = new AuditLog(EnumModule.SUPPLIER.getModuleName(), 
				supplier.getId(), supplier.getName(), EnumOperationType.ADD.getOperationType(), u);
		supplierService.add(supplier, auditLog);
		JsonDto json = JsonDto.add(supplier.getId());
		return json.toString();
	}
	/**
	 * 
	  * delete(保存：新建)
	  * @Title: delete
	  * @param  Supplier组件实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(ModelMap modelMap, Long[] id){
		logger.info("SupplierController.delete删除组件");
		User user = (User) modelMap.get(Constant.VS_USER);
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.LEAD.getModuleName(), 
					id[i], supplierService.get(id[i]).getName(), EnumOperationType.DELETE.getOperationType(), user);
		}
		boolean flag = supplierService.delete(id,auditLogArr);
		if(flag){
			return JsonDto.delete(id).toString();
		}else{
			return new JsonDto("被删除数据存在关联项目或联系人，无法删除!").toString(); 
		}
	}
	
	/**
     * toSupplierLstPage(跳转至供应商组件列表界面)
     * todo: lihua 2014-05-22
     */
    @RequestMapping(value = "/toQueryPage.comp")
    public String toSupplierLstPage(HttpServletRequest request,
    		HibernatePage<Supplier> page,
    		Model model) throws NoSuchFieldException {
        model.addAttribute("page", page);
        //page.setHibernateOrderBy(orderBy);
        //page.setHibernateOrder(order);
        
        return "/project/supplier/listcomp";
    }
    
    
    /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request,  ModelMap model, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
        Search.toRangeDate(searchParams, "createdTime");
        Search.toRangeDate(searchParams, "modifiedTime");
        logger.debug("查询条件数目“{}”", searchParams.size());
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);		
        List<Supplier> supplier = supplierService.export(searchParams,dataShift);
        logger.debug("列表信息数目“{}”", supplier.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "supplier", supplier).write(response.getOutputStream());
    }
}
