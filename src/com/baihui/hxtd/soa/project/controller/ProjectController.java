
package com.baihui.hxtd.soa.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.project.entity.Project;
import com.baihui.hxtd.soa.project.service.ProjectService;
import com.baihui.hxtd.soa.system.entity.User;
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
public class ProjectController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));//true:允许输入空值，false:不能为空值
	}
	
	@Resource
	private ProjectService projectService;
	
	@RequestMapping(value="/toQueryPage.do")
	public String toQueryPage(ModelMap model){
        logger.info("转至查询页面");
        logger.info("存储表单默认值");
        HibernatePage<Project> page = new HibernatePage<Project>();
        model.addAttribute("page", page);
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
	@RequestMapping(value="/modify.do")
	public String modify(Project project,String type,HttpServletRequest request){
		logger.info("SupplierController.modify修改组件信息");
		project.setCreatedTime(new Date());
		project.setModifiedTime(new Date());
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		project.setModifier(u);
		projectService.save(project);
		if("add".equals(type)){
			return "redirect:/project/project/toAddPage.do";
		}
		return "redirect:/project/project/toViewPage.do?id="+project.getId();
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
	@RequestMapping(value="/add.do")
	public String add(Project project,String type,HttpServletRequest request){
		logger.info("projectController.modify修改组件信息");
		project.setCreatedTime(new Date());
		project.setModifiedTime(new Date());
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		project.setModifier(u);
		project.setCreator(u);
		projectService.save(project);
		if("add".equals(type)){
			return "redirect:/project/project/toAddPage.do";
		}
		return "redirect:/project/project/toViewPage.do?id="+project.getId();
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
	public String delete(Long[] id){
		logger.info("projectController.delete删除组件");
		projectService.delete(id);
		JsonDto json = new JsonDto();
		json.setMessage("删除成功");
		return json.toString();
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

}
