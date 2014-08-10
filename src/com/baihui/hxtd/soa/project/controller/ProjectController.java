
package com.baihui.hxtd.soa.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.project.entity.Project;
import com.baihui.hxtd.soa.project.service.ProductService;
import com.baihui.hxtd.soa.project.service.ProjectService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
/**
 * 
 * 功能描述：项目模块控制器
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.project.controller.ProjectController.java
 * @version (版本) 1
 * @date 2014-6-8 上午10:33:45
 */
@RequestMapping(value="/project/project")
@Controller
@SessionAttributes(value = {Constant.VS_DATASHIFT, Constant.VS_USER})
public class ProjectController extends CommonController<Project> {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));//true:允许输入空值，false:不能为空值
	}
	
	@Resource
	private ProjectService projectService;
	
	@Resource
	private DictionaryService dictionaryService;
	
	@Resource
	private ProductService productService;
	
	@Resource
    private CommonService commonService;
	
	@RequestMapping(value="/toQueryPage.do")
	public String toQueryPage(ModelMap model){
        logger.info("转至查询页面");
        logger.info("存储表单默认值");
        HibernatePage<Project> page = new HibernatePage<Project>().order(HibernatePage.DESC).orderBy("modifiedTime");
        model.addAttribute("page", page);
        model.addAttribute("payType", dictionaryService.findChildren(DictionaryConstant.VC_PAY_TYPE, true));
		return "/project/project/list";
	}
	
	
	@RequestMapping(value = "/query.do",produces = "text/text;charset=UTF-8")
	@ResponseBody
	public void query(HibernatePage<Project> page,
								HttpServletRequest request,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException{
		logger.info("SupplierController.query查询项目列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.trimValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		page = projectService.findPage(searchParams, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	/**
	 * 
	  * view(查询单个项目信息)
	  * @Title: view
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value="/toViewPage.do")
	public String view(Long id,Model model){
		Project project = projectService.get(id);
		model.addAttribute("project",project);
		model.addAttribute("products",productService.findProductByProject(project));
		return "/project/project/view";
	}
	/**
	 * 
	  * viewCom(查询简单的项目信息)
	  * @Title: viewCom
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value="/toViewPage.comp")
	public String viewComp(Long id,Model model){
		Project project = projectService.get(id);
		model.addAttribute("project",project);
		return "/project/project/viewcomp";
	}
	
	/**
	 * 
	  * view(查询单个项目信息)
	  * @Title: view
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value="/toModifyPage.do")
	public String toModifyPage(Long id,Model model){
		Project project = projectService.get(id);
		model.addAttribute("project",project);
		model.addAttribute("payType", dictionaryService.findChildren(DictionaryConstant.VC_PAY_TYPE, true));
		model.addAttribute("funcUrl","/project/project/modify.do");
		return "/project/project/edit";
	}
	/**
	 * 
	  * modify(修改项目)
	  * @Title: modify
	  * @param @param project
	  * @param @param type
	  * @param @param request
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value="/modify.do", produces = "text/text;charset=UTF-8")
	public String modify(Project project, String type, ModelMap modelMap){
		logger.info("SupplierController.modify修改项目信息");
		User u = (User) modelMap.get(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		project.setModifier(u);
		AuditLog auditLog = new AuditLog(EnumModule.PROJECT.getModuleName(), 
				project.getId(), project.getName(), EnumOperationType.MODIFY.getOperationType(), u);
		projectService.modify(project, auditLog);
		JsonDto json = new JsonDto(project.getId(),"保存成功!");
		return json.toString();
	}
	
	/**
	 * 
	  * toAddPage(跳转新增)
	  * @Title: view
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value="/toAddPage.do")
	public String toAddPage(Long id,Model model){
		model.addAttribute("funcUrl","/project/project/add.do");
		model.addAttribute("payType", dictionaryService.findChildren(DictionaryConstant.VC_PAY_TYPE, true));
		return "/project/project/edit";
	}

	/**
	 * 
	  * add(新增项目)
	  * @Title: add
	  * @param @param project
	  * @param @param type
	  * @param @param request
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value="/add.do", produces = "text/text;charset=UTF-8")
	public String add(Project project,String type, ModelMap modelMap){
		logger.info("projectController.modify修改项目信息");
		User u = (User) modelMap.get(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		project.setModifier(u);
		project.setCreator(u);
		AuditLog auditLog = new AuditLog(EnumModule.PROJECT.getModuleName(), 
				project.getId(), project.getName(), EnumOperationType.ADD.getOperationType(), u);
		projectService.add(project, auditLog);
		JsonDto json = new JsonDto(project.getId(),"保存成功!");
		return json.toString();
	}

	/**
	 * 
	  * delete()
	  * @Title: delete
	  * @param  Supplier项目实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(ModelMap modelMap, Long[] id){
		logger.info("projectController.delete删除项目");
		User user = (User)modelMap.get(Constant.VS_USER);
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.PRODUCT.getModuleName(), 
					id[i], projectService.get(id[i]).getName(), EnumOperationType.DELETE.getOperationType(), user);
		}
		boolean flag = projectService.delete(auditLogArr,id);
		if(flag){
			return JsonDto.delete(id).toString();
		}else{
			return new JsonDto("被删除数据存在关联产品，删除失败!").toString(); 
		}
	}
	
	/**
	  * toProjectLstCompPage(跳转至项目列表项目页)
	  * @Author: lihua
	  * @Description: 请求跳转至项目列表项目页
	  * @param model ModelMap
	  * @return String 项目列表项目视图页
	 */
	@RequestMapping(value = "/toQueryPage.comp")
	public String toProjectLstCompPage(ModelMap model){
		HibernatePage<Project> page = new HibernatePage<Project>();
        model.addAttribute("page", page);
        
		return "/project/project/listcomp";
	}
    
    /**
     * 导出限制数据
     * 1.指定最大条数的
	 * @throws NoSuchFieldException 
     */
    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, 
    		ModelMap modelMap, 
    		HttpServletResponse response) throws IOException {
    	List<Project> projects = projectService.export();
        ServletContext servletContext = request.getSession().getServletContext();
        String name = "project";
        
        Workbook workbook = ImportExport.exportExcel(response, servletContext, name, projects);
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
        workbook.write(response.getOutputStream());
        
        User user = (User) modelMap.get(Constant.VS_USER);
        commonService.saveAuditlog(ImportExport.Type.limit, name, user, projects.size());
    }
}
