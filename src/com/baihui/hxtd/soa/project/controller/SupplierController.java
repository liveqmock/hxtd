
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
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;

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
	  * toQueryPage(链接到供应商列表页面)
	  * @Description: 请求供应商列表页面
	  * @param model 模型映射
	  * @return String 供应商JSP地址
	  * @throws NoSuchFieldException
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(ModelMap model) {
		/**************初始化分页(默认按照最后修改时间倒叙)**************/
        HibernatePage<Supplier> page = new HibernatePage<Supplier>().order(HibernatePage.DESC).orderBy("modifiedTime");
        model.addAttribute("page", page);
        
        /***************供应商类型字典*************/
		List<Dictionary> dict = dictionaryService.findChildren(DictionaryConstant.VC_SUPPLIERTYPE, true);
		model.addAttribute("dict", dict);
		
		return "/project/supplier/list";
	}
	 /**
	   * query(异步查询供应商列表数据)
	   * @Description: JqueryAjax异步请求获取供应商数据
	   * @param page 分页设置
	   * @param request Http请求
	   * @param model 模型映射
	   * @param out PrintWriter
	   * @throws NoSuchFieldException, IOException
	  */
	@RequestMapping(value = "/query.do",produces = "text/text;charset=UTF-8")
	public void query(HibernatePage<Supplier> page, 
			HttpServletRequest request, 
			ModelMap model, 
			PrintWriter out) throws NoSuchFieldException, IOException{
		/***************组装查询条件*************/
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);
		Search.trimValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		
		/**************数据级权限过滤***********/
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);		
		page = supplierService.findPage(searchParams,dataShift, page);
		
		/*************JSON转换****************/
		JsonDto json = new JsonDto();
		json.setResult(page);
		
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	/**
	  * toAddPage(请求新增供应商)
	  * @Description: 请求新增供应商
	  * @param model 模型映射
	  * @return String 供应商新增JSP地址
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage(ModelMap model){
		/***************初始化供应商********************/
		Supplier supplier = new Supplier();
		supplier.setOwner((User)model.get(Constant.VS_USER));
		model.addAttribute("com", supplier);
		
		String funcUrl="/project/supplier/add.do";
		model.addAttribute("funcUrl", funcUrl);
		setDefaultDict(model);
		
		return "/project/supplier/edit";
	}
	/**
	  * add(异步新增供应商)
	  * @Title: add
	  * @Description: 异步新增供应商
	  * @param supplier 供应商实体
	  * @param type 请求类型(已失效)
	  * @param request HTTP对象
	  * @return String 新增结果信息
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
	public String add(Supplier supplier, 
			String type, ModelMap modelMap){
		User user = (User) modelMap.get(Constant.VS_USER);
		supplier.setCreator(user);
		supplier.setModifier(user);
		
		/***************审计日志*******************/
		AuditLog auditLog = new AuditLog(EnumModule.SUPPLIER.getModuleName(), 
				supplier.getId(), supplier.getName(), EnumOperationType.ADD.getOperationType(), user);
		
		supplierService.add(supplier, auditLog);
		
		return JsonDto.add(supplier.getId()).toString();
	}
	/**
	  * view(查看供应商详情信息)
	  * @Description: 请求查看供应商详情
	  * @param id 供应商ID
	  * @param model 模型映射
	  * @return String 供应商详情JSP地址
	  * @throws
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required = false) Long id,
			Model model){
		/*******************供应商详情*****************/
		Supplier supplier = supplierService.get(id);
		model.addAttribute("com", supplier);
		
		/**********供应商关联联系人、项目列表************/
		List<Contact> contacts = contectService.findContactBySupplier(supplier);
		List<Project> projects = projectService.findProjectBySupplier(supplier);
		model.addAttribute("contacts", contacts);
		model.addAttribute("projects", projects);
		
		return "/project/supplier/view";
	}
	/**
	  * toModifyPage(请求供应商编辑页面)
	  * @Description: 跳转供应商编辑页面
	  * @param id 供应商ID
	  * @param model 模型映射
	  * @return String 供应商编辑JSP地址
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(@RequestParam(required = false) Long id,
			ModelMap model){
		Supplier supplier  = supplierService.get(id);
		model.addAttribute("com", supplier);
		
		String funcUrl = "/project/supplier/modify.do";
		model.addAttribute("funcUrl", funcUrl);
		
		setDefaultDict(model);
		
		return "/project/supplier/edit";
	}
	/**
	  * modify(异步更新供应商信息)
	  * @Title: modify
	  * @Description: 异步更新供应商信息
	  * @param supplier 供应商实体
	  * @param type 请求类型(已失效)
	  * @param request HTTP对象
	  * @return String 更新结果信息
	 */
	@ResponseBody
	@RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
	public String modify(Supplier supplier, 
			String type, ModelMap modelMap){
		logger.info("SupplierController.modify修改供应商信息");
		
		User user = (User) modelMap.get(Constant.VS_USER);
		supplier.setModifier(user);
		AuditLog auditLog = new AuditLog(EnumModule.SUPPLIER.getModuleName(), 
				supplier.getId(), supplier.getName(), EnumOperationType.MODIFY.getOperationType(), user);
		
		supplierService.modify(supplier, auditLog);
		
		return JsonDto.modify(supplier.getId()).toString();
	}
	/**
	  * delete(标记批量删除供应商)
	  * @Title: modify
	  * @Description: 标记批量删除供应商
	  * @param modelMap 模型映射
	  * @param id 供应商IDS
	  * @return String 删除结果信息
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do", produces = "text/text;charset=UTF-8")
	public String delete(ModelMap modelMap, Long[] id){
		logger.info("SupplierController.delete删除供应商");
		
		User user = (User) modelMap.get(Constant.VS_USER);
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.LEAD.getModuleName(), 
					id[i], supplierService.get(id[i]).getName(), EnumOperationType.DELETE.getOperationType(), user);
		}
		
		JsonDto json = new JsonDto();
		if(supplierService.delete(id, auditLogArr)){
			json = JsonDto.delete(id);
		} else{
			json = new JsonDto("被删除数据存在关联项目或联系人，无法删除!");
		}
		
		return json.toString();
	}
	
	/**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request, 
    		ModelMap model, 
    		HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
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
	
	/*******************************************供应商组件***********************************************/
	/**
	  * viewCom(请求查看供应商组件详情页)
	  * @Description: 请求查看供应商组件详情页
	  * @param id 供应商ID
	  * @param model 模型映射
	  * @return String 供应商组件JSP地址
	 */
	@RequestMapping(value = "/toViewPage.comp")
	public String viewCom(@RequestParam(required=false)Long id,
			Model model){
		logger.info("SupplierController.view查询供应商");
		Supplier com = supplierService.get(id);
		model.addAttribute("com",com);
		
		return "/project/supplier/viewcomp";
	}
	
    @RequestMapping(value = "/toSearchSupplierPage.docomp")
    public String toSupplierLstPage(HibernatePage<Supplier> page,
    		Model model) {
    	page.setHibernatePageSize(12);
        model.addAttribute("page", page);
        
        return "/project/supplier/listcomp";
    }
    @ResponseBody
    @RequestMapping(value = "/searchSupplier.docomp")
	public String searchSupplier(HibernatePage<Supplier> page, 
			HttpServletRequest request, 
			ModelMap model) throws NoSuchFieldException{
		/***************查询条件*************/
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);
		Search.trimValue(searchParams);
		
		/**************数据级权限过滤***********/
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);		
		page = supplierService.findPage(searchParams, dataShift, page);
		
		/*************JSON转换****************/
		JsonDto json = new JsonDto();
		json.setResult(page);
		
		return json.toString();
	}
    
    /*************************************************获取字典*************************************************/
    /**
     * 设置字典
     */
    private void setDefaultDict(ModelMap model){
		model.addAttribute("type", dictionaryService.findChildren(DictionaryConstant.VC_SUPPLIERTYPE, true));
		model.addAttribute("cardType", dictionaryService.findChildren(DictionaryConstant.VC_DOCTYPE, true));
	}
}
