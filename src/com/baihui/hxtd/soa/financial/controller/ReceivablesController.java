package com.baihui.hxtd.soa.financial.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
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
import com.baihui.hxtd.soa.financial.entity.Receivables;
import com.baihui.hxtd.soa.financial.service.ReceivablesService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

/**
 * 
 * 功能描述：应收账款控制器
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.order.dao.OrderDao.java
 * @version (版本) 1
 * @date 2014-7-27 上午11:10:28
 */
@Controller
@RequestMapping("/financial/receivables")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_USER_ID, Constant.VS_ORG})
public class ReceivablesController extends CommonController<Receivables>{

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ReceivablesService receivablesService;

    /**
     * 跳转至列表页
     */
    @RequestMapping("/toQueryPage")
    public String toQueryPage(ModelMap model) {
    	logger.info("ReceivablesController.toQueryPage跳转应收列表页");
	    HibernatePage<Receivables> page=new HibernatePage<Receivables>();
	    page.setHibernateOrderBy("modifiedTime");
	    page.setHibernateOrder(HibernatePage.DESC);
		model.addAttribute("page",page);
        return "/financial/receivables/list";
    }


    /**
     * 查询
     */
    @ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public void query(HibernatePage<Receivables> page,
			HttpServletRequest request,ModelMap model,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
		
		logger.info("ReceviablesController.query查询合同列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		page = receivablesService.findPage(searchParams, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}

	/**
	 * 查看
	 * 
	 * @param type
	 * @param id
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required = false) String type,
			@RequestParam(required = false) Long id, Model model) throws ParseException {
		logger.info("ReceviablesController.view查询详情");
		String returnStr="/financial/receivables/view";
		if("edit".equals(type)){
			returnStr="/financial/receivables/edit";
		}
		Receivables receivables = receivablesService.getById(id);
		model.addAttribute("receivables",receivables);
		return returnStr;
	}

	
	/**
	  * 收款完成
	  * @Title: modify
	  * @Description: 收款完成,将订单状态修改为已收款，同时订单正式生效
	  * @param @param receivables
	  * @param @param modelMap
	  * @param @param request
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyFinish.do", produces = "text/text;charset=UTF-8")
	public String modifyFinish(Receivables receivables, ModelMap modelMap,
						HttpServletRequest request) {
		logger.info("ReceviablesController.modify修改收款信息");
		User user = (User) modelMap.get(Constant.VS_USER);
		logger.info("获得当前操作用户{}", user.getName());
		receivables.setModifier(user);
		AuditLog auditLog = new AuditLog(EnumModule.RECEIVABLES.getModuleName(), 
				receivables.getId(), receivables.getName(), EnumOperationType.MODIFY.getOperationType(), user);
		receivablesService.modifyFinish(receivables,auditLog);
		JsonDto json = JsonDto.modify(receivables.getId());
		return json.toString();
	}
	
	
	@RequestMapping(value = "/toModifyFinishPage.do")
	public String toModifyFinishPage(Model model,Long id) throws ParseException {
		logger.info("ReceviablesController.toModifyPage修改 应收信息");
		String funcUrl="/financial/receivables/modify.do";
		model.addAttribute("funcUrl",funcUrl);
		Receivables receivables = receivablesService.getById(id);
		model.addAttribute("receivables",receivables);
		return "/financial/receivables/edit";
	}
	
	/**
	 *  delete(删除)
	 * @param id
	 * @return
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(ModelMap modelMap, Long[] id) throws ParseException{
		logger.info("ReceviablesController.delete删除");
		User user = (User)modelMap.get(Constant.VS_USER);
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.RECEIVABLES.getModuleName(), 
					id[i], receivablesService.getById(id[i]).getName(), EnumOperationType.DELETE.getOperationType(), user);
		}
		receivablesService.delete(id,auditLogArr);
		JsonDto json = JsonDto.delete(id);
		return json.toString();
	}
	
	/**
	 * view(跳转到新增页面)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage( Model model){
		logger.info("ReceviablesController.toAddPage新建合同");
		String funcUrl="/financial/receivables/add.do";
		model.addAttribute("funcUrl", funcUrl);
		return "/financial/receivables/edit";
	}
	

	
	/**
	 * add(保存：新建)
	 * @param Receivables
	 * @param request
	 * @param type
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
	public String add(Receivables receivables,HttpServletRequest request, ModelMap modelMap){
		logger.info("ReceviablesController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User user = (User) modelMap.get(Constant.VS_USER);
		logger.info("ReceviablesController.query 获得当前操作的用户{}",user.getName());
		receivables.setOwner(user);
		receivables.setCreator(user);
		receivables.setModifier(user);
		AuditLog auditLog = new AuditLog(EnumModule.RECEIVABLES.getModuleName(), 
				receivables.getId(), receivables.getName(), EnumOperationType.ADD.getOperationType(), user);
		receivablesService.add(receivables,auditLog);
		JsonDto json = JsonDto.add(receivables.getId());
		return json.toString();
	}
	
	
	 /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request, Long organizationId, HibernatePage<Receivables> page, ModelMap modelMap, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
        logger.debug("查询条件数目“{}”", searchParams.size());

        List<Receivables> receivables= receivablesService.find(searchParams);
        logger.debug("列表信息数目“{}”", receivables.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "receivables", receivables).write(response.getOutputStream());
    }

    /**
     * 导出限制数据
     * 1.指定最大条数的
     */
    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        logger.info("导出excel文件");

        List<Receivables> receivabless = receivablesService.find();
        logger.debug("列表信息数目“{}”", receivabless.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "receivables", receivabless).write(response.getOutputStream());
    }

}
