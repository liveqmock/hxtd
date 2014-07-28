
package com.baihui.hxtd.soa.sales.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.sales.entity.SalesTarget;
import com.baihui.hxtd.soa.sales.service.SalesTargetService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

@Controller
@RequestMapping(value = "/sales/salesTarget")
@SessionAttributes(value = {Constant.VS_DATASHIFT, Constant.VS_USER})
public class SalesTargetController extends CommonController<SalesTarget> {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Resource
	private SalesTargetService salesTargetService;
	
	
	
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
	@ResponseBody
	public void query(HibernatePage<SalesTarget> page,
								HttpServletRequest request,ModelMap model,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException{
		logger.info("SalesTargetController.query查询销售目标列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.trimValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);		
		page = salesTargetService.findPage(searchParams,dataShift, page);
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
        logger.info("存储表单默认值");
        HibernatePage<SalesTarget> page = new HibernatePage<SalesTarget>().order(HibernatePage.DESC).orderBy("modifiedTime");
        model.addAttribute("page", page);
		return "/sales/salesTarget/list";
	}
	/**
	  * view(查询单个销售目标信息)
	  * @Title: view
	  * @param @param type
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view( @RequestParam(required=false)String type,
							  @RequestParam(required=false)Long id,
							  Model model){
		logger.info("SalesTargetController.view查询销售目标");
		SalesTarget com  = salesTargetService.get(id);
		model.addAttribute("salesTarget",com);
		return "/sales/salesTarget/view";
	}
	
	@RequestMapping(value = "/view.comp",params="type=time")
	public String view( Model model){
		logger.info("SalesTargetController.view时间段生成控件");
		return "/sales/salesTarget/view_time";
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
	public String toAddPage(Model model){
		logger.info("SalesTargetController.view查询销售目标");
		String funcUrl="/sales/salesTarget/add.do";
		setDefaultDict(model);
		model.addAttribute("funcUrl", funcUrl);
		return "/sales/salesTarget/edit";
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
		logger.info("SalesTargetController.toModifyPage查询销售目标");
		String funcUrl="/sales/salesTarget/modify.do";
		SalesTarget com  = salesTargetService.get(id);
		setDefaultDict(model);
		model.addAttribute("salesTarget",com);
		model.addAttribute("funcUrl", funcUrl);
		return "/sales/salesTarget/edit";
	}
	
	@RequestMapping(value = "/toAddPage.do",params="type=second")
	public String addSecond(@RequestParam(required=false)Long id,
							  Model model){
		logger.info("SalesTargetController.toModifyPage查询销售目标");
		String funcUrl="/sales/salesTarget/add.do";
		SalesTarget com  = salesTargetService.get(id);
		setDefaultDict(model);
		com.setId(null);
		com.setOwner(null);
		model.addAttribute("salesTarget",com);
		model.addAttribute("funcUrl", funcUrl);
		return "/sales/salesTarget/edit";
	}
	
	
	private void setDefaultDict(Model model){
	}
	
	/**
	  * modify(保存：修改)
	  * @Title: modify
	  * @param  SalesTarget销售目标实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
	public String modify(SalesTarget salesTarget,String type,HttpServletRequest request){
		logger.info("SalesTargetController.modify修改销售目标信息");
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getRealName());
		salesTarget.setModifier(u);
		AuditLog auditLog = new AuditLog(EnumModule.SALESTARGET.getModuleName(), 
				salesTarget.getId(), salesTarget.getTitle(), EnumOperationType.MODIFY.getOperationType(), u);
		salesTargetService.modify(salesTarget,auditLog);
		JsonDto json = JsonDto.modify(salesTarget.getId());
		salesTarget.setModifier(u);
		return json.toString();
	}
	/**
	 * 
	  * add(保存：新建)
	  * @Title: add
	  * @param  SalesTarget销售目标实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
	public String add(SalesTarget salesTarget,String ownerIds,HttpServletRequest request){
		logger.info("SalesTargetController.query查询销售目标列表");
		//临时代码，时间类型应从数据库中取
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("SalesTargetController.query 获得当前操作的用户{}",u.getRealName());
		salesTarget.setCreator(u);
		salesTarget.setModifier(u);
		String[] owners = ownerIds.split(",");
		AuditLog [] auditLogArr = new AuditLog [owners.length];
		for(int i=0; i<owners.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.SALESTARGET.getModuleName(), 
					null, salesTarget.getTitle(), EnumOperationType.ADD.getOperationType(), u);
		}
		salesTargetService.add(salesTarget,owners, auditLogArr);
		JsonDto json = JsonDto.add(salesTarget.getId());
		return json.toString();
	}
	/**
	 * 
	  * (保存：新建)
	  * @Title: delete
	  * @param  SalesTarget销售目标实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(ModelMap modelMap, Long[] id){
		logger.info("SalesTargetController.delete删除销售目标");
		User user = (User) modelMap.get(Constant.VS_USER);
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.SALESTARGET.getModuleName(), 
					id[i], salesTargetService.get(id[i]).getTitle(), EnumOperationType.DELETE.getOperationType(), user);
		}
		salesTargetService.delete(id,auditLogArr);
		return JsonDto.delete(id).toString();
	}
}
