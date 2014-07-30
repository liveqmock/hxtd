package com.baihui.hxtd.soa.financial.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
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
import com.baihui.hxtd.soa.financial.entity.Payments;
import com.baihui.hxtd.soa.financial.service.PaymentsService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

/**
 * 
 * 功能描述：应付账款控制器
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.order.dao.OrderDao.java
 * @version (版本) 1
 * @date 2014-7-27 上午11:10:28
 */
@Controller
@RequestMapping("/financial/payments")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_USER_ID, Constant.VS_ORG})
public class PaymentsController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private PaymentsService paymentsService;

    @Resource
	private DictionaryService dictionaryService;
    /**
     * 跳转至列表页
     */
    @RequestMapping("/toQueryPage")
    public String toQueryPage(ModelMap model) {
    	logger.info("PaymentController.toQueryPage跳转应付列表页");
	    HibernatePage<Payments> page=new HibernatePage<Payments>();
	    page.setHibernateOrderBy("modifiedTime");
	    page.setHibernateOrder(HibernatePage.DESC);
	    getDictionary(model);
		model.addAttribute("page",page);
        return "/financial/payments/list";
    }


   

	/**
     * 查询
     */
    @ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public void query(HibernatePage<Payments> page,
			HttpServletRequest request,ModelMap model,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
		
		logger.info("PaymentController.query查询应付款列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		page = paymentsService.findPage(searchParams, page);
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
			@RequestParam(required = false) Long id, ModelMap model) throws ParseException {
		logger.info("PaymentsController.view查询详情");
		String returnStr="/financial/payments/view";
		if("edit".equals(type)){
			returnStr="/financial/payments/edit";
		}
		Payments payments = paymentsService.getById(id);
		//获取所有数据字典类型
		getDictionary(model);
		model.addAttribute("payments",payments);
		return returnStr;
	}

	
	
	@ResponseBody
	@RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
	public String modify(Payments payments, 
						HttpServletRequest request) {
		logger.info("PaymentsController.modify修改应付款信息");
		User user = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}", user.getName());
		payments.setModifier(user);
		setPropertyNull(payments);
		AuditLog auditLog = new AuditLog(EnumModule.PAYMENTS.getModuleName(), 
				payments.getId(), payments.getName(), EnumOperationType.MODIFY.getOperationType(), user);
		paymentsService.modify(payments,auditLog);
		JsonDto json = JsonDto.modify(payments.getId());
		return json.toString();
	}
	
	
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(ModelMap model,Long id) throws ParseException {
		logger.info("PaymentController.toModifyPage修改 应收信息");
		String funcUrl="/financial/payments/modify.do";
		model.addAttribute("funcUrl",funcUrl);
		Payments payments = paymentsService.getById(id);
		getDictionary(model);
		model.addAttribute("payments",payments);
		return "/financial/payments/edit";
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
		logger.info("PaymentController.delete删除");
		User user = (User)modelMap.get(Constant.VS_USER);
		AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.PAYMENTS.getModuleName(), 
					id[i], paymentsService.getById(id[i]).getName(), EnumOperationType.DELETE.getOperationType(), user);
		}
		paymentsService.delete(id,auditLogArr);
		JsonDto json = JsonDto.delete(id);
		return json.toString();
	}
	
	/**
	 * view(跳转到新增页面)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage( ModelMap model){
		logger.info("PaymentController.toAddPage新建应付款");
		String funcUrl="/financial/payments/add.do";
		getDictionary(model);
		model.addAttribute("funcUrl", funcUrl);
		return "/financial/payments/edit";
	}
	

	
	/**
	 * add(保存：新建)
	 * @param payments
	 * @param request
	 * @param type
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
	public String add(Payments payments,HttpServletRequest request){
		logger.info("PaymentController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User user = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("PaymentController.query 获得当前操作的用户{}",user.getName());
		payments.setOwner(user);
		payments.setCreator(user);
		payments.setModifier(user);
		setPropertyNull(payments);
		AuditLog auditLog = new AuditLog(EnumModule.PAYMENTS.getModuleName(), 
				payments.getId(), payments.getName(), EnumOperationType.ADD.getOperationType(), user);
		paymentsService.add(payments,auditLog);
		JsonDto json = JsonDto.add(payments.getId());
		return json.toString();
	}
	
	 /**
     * 获取所有数据字典类型
     * @author huizijing
     */
	public void getDictionary(ModelMap model){
		//设置开户行
		List<Dictionary> openBank = dictionaryService.findChildren(DictionaryConstant.VC_OPENBANK, true);
		model.addAttribute("openBank", openBank);
		
		//设置支付方式
		List<Dictionary> payType = dictionaryService.findChildren(DictionaryConstant.VC_PAY_TYPE, true);
		model.addAttribute("payType", payType);
	}
	
	/**
	 * 如果所传属性的id为空就设置属性为空
	 * @param customer
	 */
	private void setPropertyNull(Payments payments) {
		if(null==payments.getOpenBank().getId()){
			payments.setOpenBank(null);
		}
		if(null==payments.getPayType().getId()){
			payments.setPayType(null);
		}
	}
}
