
package com.baihui.hxtd.soa.common.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baihui.hxtd.soa.common.controller.model.ListModel;
import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.common.service.PCASService;
import com.baihui.hxtd.soa.util.JsonDto;

@Controller
@RequestMapping(value="/common/pcas")
public class PCASController {
	
	@Resource
	private PCASService pcasService;
	
	@ResponseBody
	@RequestMapping(value="/getRoot.docomp",produces = "text/text;charset=UTF-8")
	public String getRoot(){
		ListModel<PCAS> model = new ListModel<PCAS>();
		model.setList(pcasService.getRoot());
		JsonDto json = new JsonDto();
		json.setResult(model);
		return json.toString();
	}
	@ResponseBody
	@RequestMapping(value="/getChildren.docomp",produces = "text/text;charset=UTF-8")
	public String getChildren(Long pid){
		ListModel<PCAS> model = new ListModel<PCAS>();
		model.setList(pcasService.getChildren(pid));
		JsonDto json = new JsonDto();
		json.setResult(model);
		return json.toString();
	}
	
}
