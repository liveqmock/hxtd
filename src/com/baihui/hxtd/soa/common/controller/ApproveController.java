package com.baihui.hxtd.soa.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.baihui.hxtd.soa.base.Constant;
/**
 * 
 * 功能描述：流程审批控制器
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.ApproveController.java
 * @version (版本) 1
 * @date 2014-07-16
 */
@Controller
@RequestMapping(value = "/common/approve")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_USER_ID, Constant.VS_ORG})
public class ApproveController {

	/** -------------------订单审批规则----------------------
	 * 订单审批节点：select * from wf_node where type='a00'; 流程类型：a00
	 * 审批任务： select * from wf_task where module_id ='?' and record_id = orderId
	 * 
	 * 渠道部对应  ：渠道专员->渠道经理->渠道总监->副总经理->总裁
	 * 投资理财部对应 ：  投资专员->投资经理 ->投资总监->副总经理->总裁
	 * 理财部对应 ：  理财经理-> 投资经理 -> 投资总监->副总经理->总裁
	 * 职位或岗位叫法不同对于审批来说权限是一致
	 * 
	 * 拿理财部举例：
	 *   下面找的都是直属机构用户并非其它组里的用户
	 *   例如：理财1组里没有投资经理，则到理财部里找，而理财部还有理财2组，理财2组里有投资经理
	 *   	  那么找的结果不是理财2组的投资经理，而找的是直属于理财部的投资经理
	 *   
	 * 1.理财经理、投资经理去理财组里找
	 * 	   投资经理在理财组里找不到可以去理财部找
	 * 
	 * 2.投资总监去理财部里找，找不到可以去分部里找，
	 *   找不到直接去董事会查找(因为目前有些总监是由副总裁兼职的)
	 *   tip：最好一个人可以直属于多个机构
	 *   
	 * 3.副总经理去董事会查找
	 * 
	 * 4.总裁
	 * 
	 * ----------------------处理规则------------------------------
	 * 
	 * 创建订单的人或订单所有者才能发起审批流程
	 * 创建订单后在订单详情页可以发起审批
	 * 1.流程未发起时，订单创建人或所有者 可以为每个审批节点选择审批者
	 * 2.订单创建人或所有者 一旦发起流程，审批流程列表不再显示，只显示审批记录列表，每次审批后刷新审批记录列表
	 * 3.非流程发起者(即非理财经理)审批时可以更改下一节点的审批者
	 * 	   选择同意，进入下一审批节点；选择退回，输入退回意见，退回上一节点
	 *   更新订单表中的订单状态，刷新流程记录
	 * 4.越级审批  如：审批流转到投资总监审批时，副总裁或总裁可以直接越过投资总监将订单审批通过
	 *   更新其它被越级的审批时间，状态更新为通过，备注为：谁直接审批通过
	 * 
	 */
	
	/*@Resource
	private MemoirService memoirService;
	@Resource
	private DictionaryService dictionaryService;*/
	/*private static Map<String,String> moduleMap; //模块字典类型
	static{
		moduleMap = new HashMap<String,String>();
		moduleMap.put("supplier", "11010101");
		moduleMap.put("lead", "11010103");
		moduleMap.put("contact", "11010104");
		moduleMap.put("customer", "11010102");
	}*/
	
    /*@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }*/
    
    /**
      * query(查询订单审批流程及记录)
      * @Description: 订单详情页面异步查询订单审批流程及记录
      * @param request HttpServletRequest
     */
	@RequestMapping(value = "/query.do")
	public void query(HttpServletRequest request) {
		
	}
    
    /**
	  * toOrderApproveSendPage(跳转至订单审批发送页)
	  * @Description: 请求发送审批
	  * @param model ModelMap
	  * @return String 订单审批发送地址页
	 */
	@RequestMapping(value = "/toSendPage.doself")
	public String toOrderApproveSendPage(ModelMap model,
			@RequestParam(value = "RecordsId", required = false)Long id){
		/********获取下一流程节点及参与者***********/
		
		
		
		return "/common/wf/orderApprove";
	}
}
