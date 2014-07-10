package com.baihui.hxtd.soa.system.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.system.entity.Workbanch;
import com.baihui.hxtd.soa.system.service.WorkbanchService;
import com.baihui.hxtd.soa.util.BusinessResult;
import com.baihui.hxtd.soa.util.JsonDto;

@Controller
@RequestMapping(value="/workbanch")
@SessionAttributes(value = {Constant.VS_DATASHIFT, Constant.VS_USER_ID})
public class WorkbanchController {
	@Resource
	private WorkbanchService workbanchService;

    @RequestMapping(value = "/toViewPage.do")
    public String workbanchIndex(ModelMap model) {
        Long ownerId = (Long)model.get(Constant.VS_USER_ID);
    	model.addAttribute("list",workbanchService.getMyWorkbanchs(ownerId));
    	return "/system/workbanch/index";
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
    public String delete(Long[] ids) {
    	workbanchService.delete(ids);
    	JsonDto json = JsonDto.delete(ids);
    	return json.toString();
    }
	
}
