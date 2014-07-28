package com.baihui.hxtd.soa.order.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.common.controller.model.FlowModel;
import com.baihui.hxtd.soa.common.entity.FlowInstance;
import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.NodeType;
import com.baihui.hxtd.soa.common.service.FlowInstanceService;
import com.baihui.hxtd.soa.common.service.FlowNodeService;
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.order.service.OrderService;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * 功能描述：订单模块controller
 *
 * @author ruisong.luan
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.order.controller.OrderController.java
 * @date 2014-6-30 下午05:49:46
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Controller
@RequestMapping(value = "/order/order")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_ORG, Constant.VS_DATASHIFT})
public class OrderController extends CommonController<Order> {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private OrderService orderService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private FlowInstanceService flowInstanceService;

    @Resource
    private FlowNodeService flowNodeService;


    @ModelAttribute
    public void flowNodeType(ModelMap modelMap) {
        modelMap.addAttribute("startNodeType", NodeType.start.getValue());
        modelMap.addAttribute("businessNodeType", NodeType.business.getValue());
        modelMap.addAttribute("endNodeType", NodeType.end.getValue());
    }

    /**
     * toQueryPage(从菜单跳转,跳转订单列表页)
     *
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(ModelMap modelMap) {
        logger.info("OrderController.toQueryPage跳转订单列表页");
        modelMap.addAttribute("page", new HibernatePage<Order>().order(HibernatePage.DESC).orderBy("modifiedTime"));
        return "/order/order/list";
    }


    /**
     * 查询订单列表(从功能按钮跳转)
     * --准备审批流程权限验证相关数据
     * ----跨流程环节审批，存储待执行的流程
     *
     * @throws IOException
     * @throws JsonMappingException
     * @throws JsonGenerationException
     */
    @ResponseBody
    @RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
    public void query(HibernatePage<Order> page, HttpServletRequest request, PrintWriter out, ModelMap model) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {

        logger.info("OrderController.query查询订单列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        Search.toRangeDate(searchParams, "createdTime");
        logger.info("添加默认的查询条件");
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        page = orderService.findPage(searchParams, dataShift, page);

        User user = (User) model.get(Constant.VS_USER);
        FlowNode executablePrepreerence = flowNodeService.findExecutablePrepreerence(user, DictionaryConstant.NODE_TYPE_ORDERAPPROVE);
        if (executablePrepreerence != null) {
            executablePrepreerence.setApprover(user);
            flowInstanceService.fullExecutable(Constant.MODULE_ORDER, executablePrepreerence, page.getResult());
        }

        JsonDto json = new JsonDto();
        json.setResult(page);
        HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
    }

    /**
     * 查看或编辑订单
     */
    @RequestMapping(value = "/toViewPage.do")
    public String view(Long id, ModelMap modelMap) {
        logger.info("OrderController.view查询组件");
        User user = (User) modelMap.get(Constant.VS_USER);

        Order order = orderService.get(id);
        modelMap.addAttribute("order", order);
        modelMap.addAttribute("entity", order);


        //存储历史记录
        List<FlowInstance> historys = flowInstanceService.findExecuted(Constant.MODULE_ORDER, id, DictionaryConstant.NODE_TYPE_ORDERAPPROVE);
        modelMap.addAttribute("historyRecords", historys);

        //存储当前流程
        FlowNode currentFlowNode = order.getFlowNode();
        if (currentFlowNode != null) {
            if (currentFlowNode.getType().equals(NodeType.start.getValue())) {
                currentFlowNode.setApprover(user);
            } else {
                flowNodeService.fullReserveExecutor(Constant.MODULE_ORDER, order.getId(), currentFlowNode);
            }
            modelMap.addAttribute("currentFlowNode", order.getFlowNode());

            //存储预定审批环节
            List<FlowNode> flowNodes = flowNodeService.findAllOfFlow(DictionaryConstant.NODE_TYPE_ORDERAPPROVE);
            List<FlowNode> reserveFlowNodes = FlowNodeService.findAfter(flowNodes, currentFlowNode);
            if (!currentFlowNode.getType().equals(NodeType.start.getValue())) {
                flowNodeService.fullReserveExecutor(Constant.MODULE_ORDER, order.getId(), reserveFlowNodes);
            }
            modelMap.addAttribute("reserveFlowNodes", reserveFlowNodes);
        }
        modelMap.addAttribute("endFlowNode", NodeType.end.getValue());

        return "/order/order/view";
    }

    /**
     * 赎回组件
     */
    @RequestMapping(value = "/redemption.comp")
    public String redemptionComp(@RequestParam(required = false) Long id, ModelMap modelMap) {
        logger.info("OrderController.view查询组件");
        Order order = orderService.get(id);
        modelMap.addAttribute("order", order);
        return "/order/order/redemption";
    }

    /**
     * 提前赎回订单
     */
    @ResponseBody
    @RequestMapping(value = "/redemption.do")
    public String advanceRedemptionOrder(@RequestParam(required = false) Long id, ModelMap modelMap) {
        logger.info("OrderController.view查询组件");
        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog auditLog = new AuditLog(EnumModule.ORDER.getModuleName(),
                id, orderService.get(id).getCode(), EnumOperationType.MODIFY.getOperationType(), user);
        auditLog.setRemark("提前赎回生成付款单");
        orderService.advanceRedemptionOrder(id, user, auditLog);
        return JsonDto.modify(id).toString();
    }

    @ResponseBody
    @RequestMapping(value = "/modify.do", produces = "text/text;charset=UTF-8")
    public String modify(Order order,
                         HttpServletRequest request) {
        logger.info("OrderController.modify修改订单信息");
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        logger.info("获得当前操作用户{}", u.getName());
        order.setModifier(u);
        order.setCreator(u);
        AuditLog auditLog = new AuditLog(EnumModule.ORDER.getModuleName(),
                order.getId(), order.getCode(), EnumOperationType.MODIFY.getOperationType(), u);
        orderService.modify(order, auditLog);
        JsonDto json = JsonDto.modify(order.getId());
        return json.toString();
    }

    /**
     * addSecond(再次购买，复制订单信息)
     *
     * @param @param  model
     * @param @param  id
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: addSecond
     */
    @RequestMapping(value = "/toAddPage.do", params = "type=second")
    public String addSecond(Model model, Long id) {
        logger.info("OrderController.toModifyPage修改订单所有者信息");
        String funcUrl = "/order/order/add.do";
        model.addAttribute("funcUrl", funcUrl);
        Order order = orderService.get(id);
        order.setId(null);
        order.setCode(null);
        model.addAttribute("order", order);
        setDefaultDict(model);
        return "/order/order/edit";
    }


    @RequestMapping(value = "/toModifyPage.do")
    public String toModifyPage(Model model, Long id) {
        logger.info("OrderController.toModifyPage修改订单所有者信息");
        String funcUrl = "/order/order/modify.do";
        model.addAttribute("funcUrl", funcUrl);
        Order order = orderService.get(id);
        model.addAttribute("order", order);
        setDefaultDict(model);
        return "/order/order/edit";
    }

    /**
     * delete(删除订单)
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do", produces = "text/text;charset=UTF-8")
    public String delete(ModelMap modelMap, Long[] id) {
        logger.info("OrderController.delete删除订单");
        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.ORDER.getModuleName(),
                    id[i], orderService.get(id[i]).getCode(), EnumOperationType.DELETE.getOperationType(), user);
        }
        boolean flag = orderService.delete(id, auditLogArr);
        if (flag) {
            return JsonDto.delete(id).toString();
        } else {
            return new JsonDto("被删除数据存在关联合同，删除失败!").toString();
        }
    }

    /**
     * view(跳转到新增页面)
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/toAddPage.do")
    public String toAddPage(ModelMap model) {
        logger.info("OrderController.toAddPage新建订单");
        String funcUrl = "/order/order/add.do";
        model.addAttribute("funcUrl", funcUrl);
        Order order = new Order();
        order.setOwner((User) model.get(Constant.VS_USER));
        model.addAttribute("order", order);
        model.addAttribute("investmentWay", dictionaryService.findChildren(DictionaryConstant.VC_INVESTMENT_WAY, true));
        return "/order/order/edit";
    }

    private void setDefaultDict(Model model) {
        model.addAttribute("investmentWay", dictionaryService.findChildren(DictionaryConstant.VC_INVESTMENT_WAY, true));
    }


    /**
     * add(保存：新建)
     *
     * @param order
     * @param request
     * @param type
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", produces = "text/text;charset=UTF-8")
    public String add(ModelMap modelMap, Order order, HttpServletRequest request) {
        logger.info("ComponentController.query查询组件列表");
        //临时代码，时间类型应从数据库中取
        User user = (User) modelMap.get(Constant.VS_USER);
        logger.info("ComponentController.query 获得当前操作的用户{}", user.getName());
        order.setCreator(user);
        order.setModifier(user);
        AuditLog auditLog = new AuditLog(EnumModule.ORDER.getModuleName(),
                order.getId(), order.getCode(), EnumOperationType.ADD.getOperationType(), user);
        orderService.add(order, auditLog);
        JsonDto json = JsonDto.add(order.getId());
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
        List<Order> orders = orderService.export(searchParams, dataShift);
        logger.debug("列表信息数目“{}”", orders.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "order", orders).write(response.getOutputStream());
    }

    /**
     * toCustomerLstPage(跳转至订单组件列表界面)
     *
     * @author huizijing
     */
    @RequestMapping(value = "/toQueryPage.comp")
    public String toCustomerLstPage(HibernatePage<Order> page, String type,
                                    HttpServletRequest request, Model model) throws NoSuchFieldException {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);

        page.setHibernatePageSize(12);// 设置每页显示12个
        //如果是合同页面，要过滤掉已有合同的订单，如果是应付款页面不用过滤
        model.addAttribute("type", type);
        model.addAttribute("page", page);
        return "/order/order/listcomp";
    }

    /**
     * 查询没有被合同关联的订单
     *
     * @param searchParams
     * @param dataShift
     * @param page
     * @return
     * @throws NoSuchFieldException
     * @throws IOException
     * @throws JsonMappingException
     * @throws JsonGenerationException
     * @author huizijing
     */
    @ResponseBody
    @RequestMapping(value = "/query.do", params = "TYPE=relation")
    public void queryList(HibernatePage<Order> page,
                          HttpServletRequest request, ModelMap model, PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {

        logger.info("OrderController.query查询订单列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        Search.toRangeDate(searchParams, "createdTime");
        logger.info("添加默认的查询条件");
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        page = orderService.findListPage(searchParams, dataShift, page);
        JsonDto json = new JsonDto();
        json.setResult(page);
        page.setHibernateOrderBy("modifiedTime");
        page.setHibernateOrder(HibernatePage.DESC);
        HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
    }


    /** 跳转启动审批页面 */
    @RequestMapping("/toStartApprovePage.do")
    public String toStartApprovePage(Long id, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);

        //存储订单
        Order order = orderService.get(id);
        modelMap.addAttribute("order", order);
        modelMap.addAttribute("entity", order);

        //存储当前流程环节
        FlowNode currentFlowNode = order.getFlowNode();
        currentFlowNode.setApprover(user);
        modelMap.addAttribute("currentFlowNode", currentFlowNode);

        //存储待审批流程
        List<FlowNode> allFlowNodes = flowNodeService.findAllOfFlow(DictionaryConstant.NODE_TYPE_ORDERAPPROVE);
        List<FlowNode> preselectionFlowNodes = FlowNodeService.findAfter(allFlowNodes, currentFlowNode);
        flowNodeService.fullPreselectionApprover(preselectionFlowNodes, user);
        modelMap.addAttribute("preselectionFlowNodes", preselectionFlowNodes);
        modelMap.addAttribute("reserveFlowNodes", preselectionFlowNodes);

        return "/order/order/view";
    }

    /**
     * 启动流程
     * --更新业务对象流程环节为下一个流程环节
     * --保存流程环节到预审批记录中
     * --执行预存的审批记录
     */
    @ResponseBody
    @RequestMapping("/startApprove.do")
    public String startApprove(FlowModel flowModel, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);

        flowModel.setFlowValue(DictionaryConstant.NODE_TYPE_ORDERAPPROVE);
        FlowInstance executeRecord = flowModel.getExecuteRecord();
        executeRecord.setModule(InitApplicationConstant.findModuleByName(Constant.MODULE_ORDER));
        executeRecord.setApprover(user);
        executeRecord.setCreator(user);
        executeRecord.setModifier(user);

        flowInstanceService.start(flowModel);
        // 修改订单状态为审批中
        orderService.modifyOrderNoteing(flowModel.getExecuteRecord().getRecordId());
        JsonDto jsonDto = new JsonDto(executeRecord.getRecordId(), "启动审批成功！");
        return jsonDto.toString();
    }

    /** 跳转执行审批页面 */
    @RequestMapping("/toExecuteApprovePage.do")
    public String toExecuteApprovePage(Long id, Long flowNodeId, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);
        List<FlowNode> allFlowNodes = flowNodeService.findAllOfFlow(DictionaryConstant.NODE_TYPE_ORDERAPPROVE);

        //存储订单
        Order order = orderService.get(id);
        modelMap.addAttribute("order", order);
        modelMap.addAttribute("entity", order);

        //存储历史记录
        List<FlowInstance> historys = flowInstanceService.findExecuted(Constant.MODULE_ORDER, id, DictionaryConstant.NODE_TYPE_ORDERAPPROVE);
        modelMap.addAttribute("historyRecords", historys);

        //存储当前业务流程环节
        FlowNode businessFlowNode = order.getFlowNode();
        businessFlowNode.setApprover(user);
        modelMap.addAttribute("businessFlowNode", businessFlowNode);

        //存储当前执行流程环节
        FlowNode currentFlowNode = businessFlowNode;
        if (flowNodeId != null) {
            currentFlowNode = flowNodeService.get(flowNodeId);
            currentFlowNode.setApprover(user);

            List<FlowNode> skipFlowNodes = FlowNodeService.findBetween(allFlowNodes, businessFlowNode, currentFlowNode);
            flowNodeService.fullReserveExecutor(Constant.MODULE_ORDER, order.getId(), skipFlowNodes);
            modelMap.addAttribute("skipFlowNodes", skipFlowNodes);
        }
        modelMap.addAttribute("currentFlowNode", currentFlowNode);


        //存储下一个流程
        FlowNode nextFlowNode = FlowNodeService.findNext(allFlowNodes, currentFlowNode);
        flowNodeService.fullPreselectionApprover(nextFlowNode, user);
        flowNodeService.fullReserveExecutor(Constant.MODULE_ORDER, order.getId(), nextFlowNode);
        modelMap.addAttribute("nextFlowNode", nextFlowNode);

        //存储待审批流程
        List<FlowNode> preselectionFlowNodes = FlowNodeService.findAfter(allFlowNodes, currentFlowNode);
        flowNodeService.fullReserveExecutor(Constant.MODULE_ORDER, order.getId(), preselectionFlowNodes);
        modelMap.addAttribute("reserveFlowNodes", preselectionFlowNodes);

        return "/order/order/view";
    }

    /**
     * 执行审批
     * --更新业务对象流程环节为下一个流程环节
     * --执行预存的审批记录
     * --更新下一个预存的审批记录的审批人
     */
    @ResponseBody
    @RequestMapping("/executeApprove.do")
    public String executeApprove(FlowModel flowModel, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);

        flowModel.setFlowValue(DictionaryConstant.NODE_TYPE_ORDERAPPROVE);

        FlowInstance executeRecord = flowModel.getExecuteRecord();
        executeRecord.setModule(InitApplicationConstant.findModuleByName(Constant.MODULE_ORDER));
        executeRecord.setApprover(user);
        executeRecord.setCreator(user);
        executeRecord.setModifier(user);

        flowInstanceService.execute(flowModel);
        // 审批通过
        if (executeRecord.getIsPassed() && flowModel.getNextFlowNode().getType().equals(NodeType.end.getValue())) {
        	// 修改对应订单的订单状态
        	Long id = flowModel.getExecuteRecord().getRecordId();
        	AuditLog auditLog = new AuditLog(EnumModule.ORDER.getModuleName(),
                    id, orderService.get(id).getCode(), EnumOperationType.MODIFY.getOperationType(), user);
        	auditLog.setRemark("审批完成自动生成收款单");
        	orderService.modifyOrderNoteFinish(id, user, auditLog);
        }
        JsonDto jsonDto = new JsonDto(executeRecord.getRecordId(), "执行审批成功！");
        return jsonDto.toString();
    }

}
