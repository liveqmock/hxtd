package com.baihui.hxtd.soa.customer.controller;

import java.io.IOException;
import java.util.Date;
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
import com.baihui.hxtd.soa.customer.entity.Lead;
import com.baihui.hxtd.soa.customer.service.LeadService;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 线索控制器
 * 
 * @author luoxiaoli
 * @version 1.0
 * @date 2014/5/12
 */
@Controller
@RequestMapping(value = "/customer/lead")
@SessionAttributes(value = {Constant.VS_DATASHIFT})
public class LeadController {
	
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
	 */
	@ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public String query(HibernatePage<Lead> page,// 
			HttpServletRequest request,ModelMap model) throws NoSuchFieldException {
		
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
		return json.toString();
	}

	/**
	 * toQueryPage(从菜单跳转,跳转线索列表页)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(Model model) {
		logger.info("LeadController.toQueryPage跳转线索列表页");
		model.addAttribute("page",new HibernatePage<Lead>().order("desc").orderBy("modifiedTime"));
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
		logger.info("LeadController.view查询组件");
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
		lead.setCreatedTime(new Date(new java.util.Date().getTime()));
		lead.setModifiedTime(new Date(new java.util.Date().getTime()));
		lead.setModifier(u);
		lead.setCreator(u);
		leadService.save(lead);
		JsonDto json = JsonDto.modify(lead.getId());
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/modifyOwner.do",
					produces = "text/text;charset=UTF-8")
	public String modifyOwner(Long[] id, Long ownerId) {
		leadService.modifyOwner(ownerId, id);
		JsonDto json = new JsonDto("转换成功");
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
	public String delete(Long[] id){
		//logger.info("LeadController.delete删除线索id={}",id);
		leadService.delete(id);
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
		logger.info("ComponentController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("ComponentController.query 获得当前操作的用户{}",u.getName());
		lead.setCreator(u);
		lead.setModifier(u);
		lead.setCreatedTime(new Date(new java.util.Date().getTime()));
		lead.setModifiedTime(new Date(new java.util.Date().getTime()));
		leadService.save(lead);
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
        Search.toRangeDate(searchParams, "createTime");
        logger.debug("查询条件数目“{}”", searchParams.size());
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        List<Lead> leads = leadService.export(searchParams,dataShift);
        logger.debug("列表信息数目“{}”", leads.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "lead", leads).write(response.getOutputStream());
    }
	
    /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @ResponseBody
    @RequestMapping(value = "/leadConverter.do", produces = "text/text;charset=UTF-8")
    public String convCustomerAndContact(Long id) {
        logger.info("线索转换");
        leadService.leadConverter(id);
        JsonDto json = new JsonDto("转换成功");
        json.setSuccessFlag(true);
        return json.toString();
    }
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {

	}

}
