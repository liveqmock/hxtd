package com.baihui.hxtd.soa.system.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.common.service.ReportService;
import com.baihui.hxtd.soa.system.entity.Workbanch;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.WorkbanchService;
import com.baihui.hxtd.soa.util.BusinessResult;
import com.baihui.hxtd.soa.util.JsonDto;

@Controller
@RequestMapping(value="/workbanch")
@SessionAttributes(value = {Constant.VS_DATASHIFT, Constant.VS_USER_ID})
public class WorkbanchController {
	@Resource
	private WorkbanchService workbanchService;
	@Resource
	private ReportService reportService;

    @RequestMapping(value = "/toViewPage.do")
    public String workbanchIndex(ModelMap model) {
        Long ownerId = (Long)model.get(Constant.VS_USER_ID);
    	model.addAttribute("list",workbanchService.getMyWorkbanchs(ownerId));
    	return "/system/workbanch/index";
    }
    @RequestMapping(value = "/add.comp")
    public String toAddPage(ModelMap model) throws NoSuchFieldException {
    	List<Report> list = reportService.findAllReport((DataShift)model.get(Constant.VS_DATASHIFT));
    	model.addAttribute("reports",list);
    	return "/system/workbanch/edit";
    }
    
    @RequestMapping(value = "/toQueryPage.do")
    public String toCustomPage() {
    	return "/system/workbanch/list";
    }
    
    @ResponseBody
    @RequestMapping(value = "/query.do",produces = "text/text;charset=UTF-8")
    public String query(ModelMap model) {
    	Long ownerId = (Long)model.get(Constant.VS_USER_ID);
    	List<Workbanch> list = workbanchService.getMyWorkbanchs(ownerId);
    	BusinessResult<List<Workbanch>> result = new BusinessResult<List<Workbanch>> (list);
    	JsonDto json = new JsonDto();
    	json.setResult(result);
    	return json.toString();
    }
    
    @ResponseBody
    @RequestMapping(value = "/modifyOrder.do",produces = "text/text;charset=UTF-8")
    public String modifyOrder(Long[] ids) {
    	workbanchService.modifyOrder(ids);
    	JsonDto json = new JsonDto("位置记忆成功");
    	json.setSuccessFlag(true);
    	return json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
    public String delete(Long[] id) {
    	workbanchService.delete(id);
    	JsonDto json = JsonDto.delete(id);
    	return json.toString();
    }
    
    @ResponseBody
    @RequestMapping(value = "/add.do",produces = "text/text;charset=UTF-8")
    public String add(Workbanch work,ModelMap model) {
    	Long ownerId = (Long)model.get(Constant.VS_USER_ID);
    	workbanchService.add(work,ownerId);
    	JsonDto json = JsonDto.add(work.getId());
    	return json.toString();
    }
	
}
