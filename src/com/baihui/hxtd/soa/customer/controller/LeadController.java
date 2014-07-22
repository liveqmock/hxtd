package com.baihui.hxtd.soa.customer.controller;

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
import com.baihui.hxtd.soa.customer.entity.Lead;
import com.baihui.hxtd.soa.customer.service.LeadService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

/**
 * 线索控制器
 *
 * @author luoxiaoli
 * @version 1.0
 * @date 2014/5/12
 */
@Controller
@RequestMapping(value = "/customer/lead")
@SessionAttributes(value = {Constant.VS_USER,Constant.VS_USER_ID,Constant.VS_DATASHIFT})
public class LeadController extends CommonController<Lead>{

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/** 注入LeadService */
	@Resource
	private LeadService leadService;

	@Resource
	 private DictionaryService dictionaryService;

	/**
	 * 查询线索列表(从功能按钮跳转)
	 * @param page
	 * @param request
	 * @return
	 * @throws NoSuchFieldException
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 */
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public void query(HibernatePage<Lead> page,//
			HttpServletRequest request,ModelMap model, PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {

		logger.info("LeadController.query查询线索列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
		page = leadService.findPage(searchParams,dataShift, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}

	/**
	 * toQueryPage(从菜单跳转,跳转线索列表页)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(Model model) {
		logger.info("LeadController.toQueryPage跳转线索列表页");
		model.addAttribute("page",new HibernatePage<Lead>(10).order(HibernatePage.DESC).orderBy("modifiedTime"));
		setDefaultDict(model);
		return "/customer/lead/list";
	}

	/**
	 * 查看或编辑线索
	 *
	 * @param type
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required = false) String type,
			@RequestParam(required = false) Long id, Model model) {
		logger.info("LeadController.view查询线索");
		String returnStr="/customer/lead/view";
		Lead lead = leadService.get(id);
		model.addAttribute("lead",lead);
		return returnStr;
	}



	@ResponseBody
	@RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
	public String modify(Lead lead,
						HttpServletRequest request) {
		logger.info("LeadController.modify修改线索信息");
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}", u.getName());
		lead.setModifier(u);
		lead.setCreator(u);
		AuditLog auditLog = new AuditLog(EnumModule.LEAD.getModuleName(), 
				lead.getId(), lead.getName(), EnumOperationType.MODIFY.getOperationType(), u);
		leadService.modify(lead,auditLog);
		JsonDto json = JsonDto.modify(lead.getId());
		return json.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/modifyOwner.do",
					produces = "text/text;charset=UTF-8")
	public String modifyOwner(Long[] id, Long ownerId,ModelMap modelMap) {
		User user = (User)modelMap.get(Constant.VS_USER);
        AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.LEAD.getModuleName(), 
					id[i], leadService.get(id[i]).getName(), EnumOperationType.MODIFY.getOperationType(), user,"批量更改所有者");
		}
		
		leadService.modifyOwner(ownerId, id,auditLogArr);
		JsonDto json = new JsonDto("所有者更改成功！");
		json.setSuccessFlag(true);
		return json.toString();
	}


	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(Model model,Long id) {
		logger.info("LeadController.toModifyPage修改线索所有者信息");
		String funcUrl="/customer/lead/modify.do";
		model.addAttribute("funcUrl",funcUrl);
		Lead lead = leadService.get(id);
		model.addAttribute("lead",lead);
		setDefaultDict(model);
		return "/customer/lead/edit";
	}

	/**
	 *  delete(删除线索)
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(ModelMap modelMap, Long[] id){
		logger.info("LeadController.delete删除线索id={}",id[0]);
		User user = (User)modelMap.get(Constant.VS_USER);
		
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.LEAD.getModuleName(), 
					id[i], leadService.get(id[i]).getName(), EnumOperationType.DELETE.getOperationType(), user);
		}
		
		leadService.delete(id,auditLogArr);
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
		logger.info("LeadController.toAddPage新建线索");
		String funcUrl="/customer/lead/add.do";
		model.addAttribute("funcUrl", funcUrl);
		setDefaultDict(model);
		return "/customer/lead/edit";
	}

	private void setDefaultDict(Model model){
		model.addAttribute("source",dictionaryService.findChildren("040101"));
		model.addAttribute("status",dictionaryService.findChildren("040102"));
		model.addAttribute("cardType",dictionaryService.findChildren("040103"));
		model.addAttribute("industry",dictionaryService.findChildren("040305"));
		model.addAttribute("isMarketActivity",Constant.SOURCE_MARKET_ACTIVITY);
	}



	/**
	 * add(保存：新建)
	 * @param lead
	 * @param request
	 * @param type
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
	public String add(Lead lead,HttpServletRequest request){
		logger.info("leadController.add添加线索");
		//临时代码，时间类型应从数据库中取
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("leadController.query 获得当前操作的用户{}",u.getName());
		lead.setCreator(u);
		lead.setModifier(u);
		AuditLog auditLog = new AuditLog(EnumModule.LEAD.getModuleName(), 
				lead.getId(), lead.getName(), EnumOperationType.ADD.getOperationType(), u);
		leadService.add(lead, auditLog);
		JsonDto json = JsonDto.add(lead.getId());
		return json.toString();
	}


	 /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request, ModelMap model, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
        Search.toRangeDate(searchParams, "createdTime");
        logger.debug("查询条件数目“{}”", searchParams.size());
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        User user = (User)model.get(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.LEAD.getModuleName(), 
				null, null, EnumOperationType.EXPORT.getOperationType(), user,"导出线索");
        List<Lead> leads = leadService.export(searchParams,dataShift,auditLog);
        logger.debug("列表信息数目“{}”", leads.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "lead", leads).write(response.getOutputStream());
    }

    /**
     * 线索转成客户
     */
    @ResponseBody
    @RequestMapping(value = "/leadConverter.do", produces = "text/text;charset=UTF-8")
    public String convCustomerAndContact(ModelMap modelMap, Long id) {
        logger.info("线索转换");
        User user = (User)modelMap.get(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.LEAD.getModuleName(), 
				id, leadService.get(id).getName(), EnumOperationType.MODIFYLEADCONVERTER.getOperationType(), user,"线索转换客户，联系人");
        leadService.modifyLeadConverter(id,auditLog);
        JsonDto json = new JsonDto("转换成功");
        json.setSuccessFlag(true);
        return json.toString();
    }


}
