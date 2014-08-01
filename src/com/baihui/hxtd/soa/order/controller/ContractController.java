
package com.baihui.hxtd.soa.order.controller;

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
import com.baihui.hxtd.soa.order.entity.Contract;
import com.baihui.hxtd.soa.order.service.ContractService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
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
 * 
 * 功能描述：合同模块controller
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.order.controller.ContractController.java
 * @version (版本)1 
 * @date 2014-7-15
 */
@Controller
@RequestMapping(value = "/order/contract")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_DATASHIFT})
public class ContractController extends CommonController<Contract> {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private DictionaryService dictionaryService;
	
	@Resource
	private ContractService contractService;
	
	
	/**
	 * 查询合同列表(从功能按钮跳转)
	 * @param page
	 * @param request
	 * @return
	 * @throws NoSuchFieldException
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 */
	@ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public void query(HibernatePage<Contract> page,
			HttpServletRequest request,ModelMap model,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
		
		logger.info("ContractController.query查询合同列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		Search.toRangeDate(searchParams, "signTime");
		Search.toRangeDate(searchParams, "effectTime");
		Search.toRangeDate(searchParams, "bereftTime");
		logger.info("添加默认的查询条件");
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
		page = contractService.findPage(searchParams,dataShift, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}

	/**
	 * toQueryPage(从菜单跳转,跳转列表页)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(Model model) {
		logger.info("ContractController.toQueryPage跳转合同列表页");
	    HibernatePage<Contract> page=new HibernatePage<Contract>();
	    page.setHibernateOrderBy("signTime");
	    page.setHibernateOrder(HibernatePage.DESC);
		model.addAttribute("page",page);
		setDefaultDict(model);
		return "/order/contract/list";
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
		logger.info("ContractController.view查询详情");
		String returnStr="/order/contract/view";
		if("edit".equals(type)){
			returnStr="/order/contract/edit";
		}
		Contract contract = contractService.getById(id);
		model.addAttribute("contract",contract);
		return returnStr;
	}

	
	
	@ResponseBody
	@RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
	public String modify(Contract contract, ModelMap modelMap,
						HttpServletRequest request) {
		logger.info("ContractController.modify修改合同信息");
		User user = (User) modelMap.get(Constant.VS_USER);
		logger.info("获得当前操作用户{}", user.getName());
		contract.setModifier(user);
//		if(null==contract.getType().getId()){
//			contract.setType(null);
//		}
		AuditLog auditLog = new AuditLog(EnumModule.CONTRACT.getModuleName(), 
				contract.getId(), contract.getCode(), EnumOperationType.MODIFY.getOperationType(), user);
		contractService.modify(contract,auditLog);
		JsonDto json = JsonDto.modify(contract.getId());
		return json.toString();
	}
	
	
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(Model model,Long id) throws ParseException {
		logger.info("ContractController.toModifyPage修改 合同信息");
		String funcUrl="/order/contract/modify.do";
		model.addAttribute("funcUrl",funcUrl);
		Contract contract = contractService.getById(id);
		model.addAttribute("contract",contract);
		setDefaultDict(model);
		return "/order/contract/edit";
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
		logger.info("ContractController.delete删除");
		User user = (User)modelMap.get(Constant.VS_USER);
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.CONTRACT.getModuleName(), 
					id[i], contractService.getById(id[i]).getCode(), EnumOperationType.DELETE.getOperationType(), user);
		}
		contractService.delete(id,auditLogArr);
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
		logger.info("ContractController.toAddPage新建合同");
		String funcUrl="/order/contract/add.do";
		model.addAttribute("funcUrl", funcUrl);
		setDefaultDict(model);
		return "/order/contract/edit";
	}
	
	private void setDefaultDict(Model model){
		model.addAttribute("redeemType",dictionaryService.findChildren(DictionaryConstant.VC_REDEEM_TYPE, true));
	}
	

	
	/**
	 * add(保存：新建)
	 * @param Contract
	 * @param request
	 * @param type
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
	public String add(Contract contract,HttpServletRequest request, ModelMap modelMap){
		logger.info("ContractController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User user = (User) modelMap.get(Constant.VS_USER);
		logger.info("ContractController.query 获得当前操作的用户{}",user.getName());
		contract.setCreator(user);
		contract.setModifier(user);
		AuditLog auditLog = new AuditLog(EnumModule.CONTRACT.getModuleName(), 
				contract.getId(), contract.getCode(), EnumOperationType.ADD.getOperationType(), user);
//		if(null==contract.getType().getId()){
//			contract.setType(null);
//		}
		contractService.add(contract,auditLog);
		JsonDto json = JsonDto.add(contract.getId());
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
        List<Contract> contracts = contractService.export(searchParams,dataShift);
        logger.debug("列表信息数目“{}”", contracts.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "contract", contracts).write(response.getOutputStream());
    }
	
	
	
}
