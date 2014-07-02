
package com.baihui.hxtd.soa.project.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.project.entity.Project;
import com.baihui.hxtd.soa.project.service.ProjectService;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;
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
@SessionAttributes(value = {Constant.VS_USER})
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
	
	@RequestMapping(value="/toQueryPage.do")
	public String toQueryPage(ModelMap model){
        logger.info("转至查询页面");
        logger.info("存储表单默认值");
        HibernatePage<Project> page = new HibernatePage<Project>();
        model.addAttribute("page", page);
        model.addAttribute("payType", dictionaryService.findChildren("040201"));
		return "/project/project/list";
	}
	
	
	@RequestMapping(value = "/query.do",produces = "text/text;charset=UTF-8")
	@ResponseBody
	public String query(HibernatePage<Project> page,
								HttpServletRequest request) throws NoSuchFieldException{
		logger.info("SupplierController.query查询组件列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		page = projectService.findPage(searchParams, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		return json.toString();
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
		return "/project/project/view";
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
		model.addAttribute("payType", dictionaryService.findChildren("040201"));
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
	public String modify(Project project,String type,HttpServletRequest request){
		logger.info("SupplierController.modify修改组件信息");
		project.setCreatedTime(new Date());
		project.setModifiedTime(new Date());
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		project.setModifier(u);
		projectService.modify(project, u);
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
		model.addAttribute("payType", dictionaryService.findChildren("040201"));
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
	public String add(Project project,String type,HttpServletRequest request){
		logger.info("projectController.modify修改组件信息");
		project.setCreatedTime(new Date());
		project.setModifiedTime(new Date());
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		project.setModifier(u);
		project.setCreator(u);
		projectService.add(project, u);
		JsonDto json = new JsonDto(project.getId(),"保存成功!");
		return json.toString();
	}

	/**
	 * 
	  * delete()
	  * @Title: delete
	  * @param  Supplier组件实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(ModelMap modelMap, Long[] id){
		logger.info("projectController.delete删除组件");
		User user = (User)modelMap.get(Constant.VS_USER);
		boolean flag = projectService.delete(user,id);
		if(flag){
			return new JsonDto().toString();
		}else{
			return new JsonDto("数据存在关联,删除失败!").toString(); 
		}
	}
	
	/**
	  * toProjectLstCompPage(跳转至项目列表组件页)
	  * @Author: lihua
	  * @Description: 请求跳转至项目列表组件页
	  * @param model ModelMap
	  * @return String 项目列表组件视图页
	 */
	@RequestMapping(value = "/toQueryPage.comp")
	public String toProjectLstCompPage(ModelMap model){
		HibernatePage<Project> page = new HibernatePage<Project>();
        model.addAttribute("page", page);
        
		return "/project/project/listcomp";
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
        List<Project> project = projectService.export(searchParams,dataShift);
        logger.debug("列表信息数目“{}”", project.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "project", project).write(response.getOutputStream());
    }
}
