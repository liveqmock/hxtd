package com.baihui.hxtd.soa.market.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.controller.CommonController;
import com.baihui.hxtd.soa.common.controller.model.FlowModel;
import com.baihui.hxtd.soa.common.entity.FlowInstance;
import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.NodeType;
import com.baihui.hxtd.soa.common.service.FlowInstanceService;
import com.baihui.hxtd.soa.common.service.FlowNodeService;
import com.baihui.hxtd.soa.market.entity.MarketActivity;
import com.baihui.hxtd.soa.market.service.MarketActivityService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 功能描述：市场活动控制器
 *
 * @author lihua
 * @version (版本) 1
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.controller.MarketActivityController.java
 * @date 2014-5-26 上午11:17:53
 * @since (该版本支持的 JDK 版本) ： 1.5
 */
@Controller
@RequestMapping(value = "/market/marketactivity")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER, Constant.VS_DATASHIFT})
public class MarketActivityController extends CommonController<MarketActivity> {

    //IOC注入
    @Resource
    private MarketActivityService marketActivityService;

    @Resource
    private DictionaryService dicService;

    @Resource
    private FlowInstanceService flowInstanceService;

    @Resource
    private FlowNodeService flowNodeService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }

    @ModelAttribute
    public void flowNodeType(ModelMap modelMap) {
        modelMap.addAttribute("startNodeType", NodeType.start.getValue());
        modelMap.addAttribute("businessNodeType", NodeType.business.getValue());
        modelMap.addAttribute("endNodeType", NodeType.end.getValue());
    }

    /**
     * toQueryPage(跳转列表页)
     * @param page  分页
     * @param modelMap Model
     * @return String 活动列表页地址
     * @Description: 请求查看活动列表
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(HibernatePage<MarketActivity> page, ModelMap modelMap) {
        page.setHibernateOrderBy("beginDate");// 默认按照开始时间倒序排序
        page.setHibernateOrder(HibernatePage.DESC);
        modelMap.addAttribute("page", page);

        initPageDic(modelMap);

        modelMap.addAttribute("startNodeType", NodeType.start.getValue());
        modelMap.addAttribute("businessNodeType", NodeType.business.getValue());


        return "/market/marketactivity/list";
    }
    
    /**
     * anscyQuery(异步加载数据列表)
     *
     * @param request HttpServletRequest
     * @param page    分页
     * @throws NoSuchFieldException 字段异常
     * @Description: 分页异步加载数据
     */
    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String anscyQuery(HttpServletRequest request, HibernatePage<MarketActivity> page, ModelMap model, PrintWriter out) throws NoSuchFieldException, IOException {
        /************获取查询条件**************/
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "createdTime");
        Search.toMinDate(searchParams, "beginDate");
        Search.toMaxDate(searchParams, "endDate");
        Search.toRangeDate(searchParams, "modifiedTime");
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);

        /************分页查询*****************/
        marketActivityService.findPage(searchParams, dataShift, page);

        User user = (User) model.get(Constant.VS_USER);
        List<MarketActivity> activitiesNoMoney = ReflectionUtils.findNameValueMatcheds(page.getResult(), "predictCost", 0d);
        List<MarketActivity> activitiesMoney = (List<MarketActivity>) ((ArrayList) page.getResult()).clone();
        activitiesMoney.removeAll(activitiesNoMoney);

        FlowNode prepreerenceMoney = flowNodeService.findExecutablePrepreerence(user, DictionaryConstant.NODE_TYPE_MARKETACTIVITY_MONEY);
        if (prepreerenceMoney != null) {
            prepreerenceMoney.setApprover(user);
            flowInstanceService.fullExecutable(Constant.MODULE_MARKETACTIVITY, prepreerenceMoney, activitiesMoney);
        }
        FlowNode prepreerenceNoMoney = flowNodeService.findExecutablePrepreerence(user, DictionaryConstant.NODE_TYPE_MARKETACTIVITY_NOMONEY);
        if (prepreerenceNoMoney != null) {
            prepreerenceNoMoney.setApprover(user);
            flowInstanceService.fullExecutable(Constant.MODULE_MARKETACTIVITY, prepreerenceNoMoney, activitiesNoMoney);
        }


        /************json转换****************/
        JsonDto json = new JsonDto();
        json.setResult(page);

        return json.toString();
    }

    /**
     * toAddPage(跳转至新增活动页)
     *
     * @param model ModelMap
     * @return String 新增活动地址页
     * @Description: 请求新增活动页
     */
    @RequestMapping(value = "/toAddPage.do")
    public String toAddPage(ModelMap model) {
        /************获取数据字典**********************/
        initPageDic(model);

        /************初始化活动(发起者)****************/
        User user = (User) model.get(Constant.VS_USER);
        Date date = new Date();
        MarketActivity entity = new MarketActivity();
        entity.setSponsor(user); //所有者
        entity.setBossHead(user); //负责人
        entity.setTimes(Long.parseLong("1"));
        entity.setBeginDate(date);
        entity.setEndDate(date);
        model.addAttribute("activity", entity);

        return "/market/marketactivity/edit";
    }

    /**
     * add(新增市场活动)
     *
     * @param activity 市场活动实体
     * @param userId   操作用户ID
     * @Description: 新增一条市场活动记录
     */
    @ResponseBody
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public String add(MarketActivity activity, @ModelAttribute(Constant.VS_USER_ID) Long userId) {
        /************设置修改者、创建者****************/
        User user = new User(userId);
        Date date = new Date();
        activity.setSponsor(user);
        activity.setCreator(user);
        activity.setCreatedTime(date);
        activity.setModifier(user);

        /************ 新增 *****************************/
        AuditLog auditLog = new AuditLog(EnumModule.MARKETACTIVITY.getModuleName(), activity.getId(), activity.getName(), EnumOperationType.ADD.getOperationType(), user);
        marketActivityService.add(activity, user, auditLog);
        return JsonDto.add(activity.getId()).toString();
    }

    /**
     * toModifyPage(跳转至修改页面)
     *
     * @param id    活动主键ID
     * @param model Model
     * @return String 编辑页地址信息
     * @Description: 请求修改活动记录页
     */
    @RequestMapping(value = "/toModifyPage.do")
    public String toModifyPage(Long id, ModelMap model) {
        /************获取数据字典**********************/
        initPageDic(model);

        model.addAttribute("activity", marketActivityService.get(id));

        return "/market/marketactivity/edit";
    }

    /**
     * modify(修改活动)
     *
     * @param activity 活动实体
     * @param userId   操作用户ID
     * @Description: 保存修改后的活动信息
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do")
    public String modify(MarketActivity activity, @ModelAttribute(Constant.VS_USER_ID) Long userId) {

        Integer type = activity.getFlowNode().getType();
        if (type != NodeType.start.getValue()) {
            return new JsonDto("已开始审批流程，不能修改！").toString();
        }

        User user = new User(userId);
        activity.setModifier(user);

        AuditLog auditLog = new AuditLog(EnumModule.MARKETACTIVITY.getModuleName(), activity.getId(), activity.getName(), EnumOperationType.MODIFY.getOperationType(), user);
        marketActivityService.modify(activity, user, auditLog);

        return JsonDto.modify(activity.getId()).toString();
    }

    /**
     * toViewPage(查看活动记录)
     *
     * @param id       活动主键ID
     * @param modelMap Model
     * @return String 查看页地址
     * @Description: 查看活动记录
     */
    @RequestMapping(value = "/toViewPage.do")
    public String toViewPage(Long id, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);

        MarketActivity activity = marketActivityService.get(id);
        modelMap.addAttribute("activity", activity);

        modelMap.addAttribute("entity", activity);
        //存储历史记录
        String flowValue = activity.getFlowNode().getFlow().getValue();
        List<FlowInstance> historys = flowInstanceService.findExecuted(Constant.MODULE_MARKETACTIVITY, id, flowValue);
        modelMap.addAttribute("historyRecords", historys);

        //存储当前流程
        FlowNode currentFlowNode = activity.getFlowNode();
        if (currentFlowNode != null) {
            if (currentFlowNode.getType().equals(NodeType.start.getValue())) {
                currentFlowNode.setApprover(user);
            } else {
                flowNodeService.fullReserveExecutor(Constant.MODULE_MARKETACTIVITY, activity.getId(), currentFlowNode);
            }
            modelMap.addAttribute("currentFlowNode", activity.getFlowNode());

            //存储预定审批环节
            List<FlowNode> flowNodes = flowNodeService.findAllOfFlow(flowValue);
            List<FlowNode> reserveFlowNodes = flowNodeService.findAfter(flowNodes, currentFlowNode);
            if (!currentFlowNode.getType().equals(NodeType.start.getValue())) {
                flowNodeService.fullReserveExecutor(Constant.MODULE_MARKETACTIVITY, activity.getId(), reserveFlowNodes);
            }
            modelMap.addAttribute("reserveFlowNodes", reserveFlowNodes);
        }
        modelMap.addAttribute("endFlowNode", NodeType.end.getValue());

        return "/market/marketactivity/view";
    }

    /**
     * delete(删除活动记录)
     *
     * @param id 活动主键ID集合
     * @return String Json串
     * @throws
     * @Description: 删除活动记录，支持批量删除
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(ModelMap modelMap, Long[] id) {
        if (id == null || id.length == 0) {
            JsonDto json = new JsonDto("请至少选择一条记录删除!");
            json.setSuccessFlag(false);
            return json.toString();
        }
        User user = (User) modelMap.get(Constant.VS_USER);
        AuditLog[] auditLogArr = new AuditLog[id.length];
        for (int i = 0; i < id.length; i++) {
            auditLogArr[i] = new AuditLog(EnumModule.MARKETACTIVITY.getModuleName(),
                    id[i], marketActivityService.getNameById(id[i]), EnumOperationType.DELETE.getOperationType(), user);
        }
        marketActivityService.delete(user, id, auditLogArr);

        JsonDto json = new JsonDto("删除成功");
        json.setSuccessFlag(true);
        return json.toString();
    }

    /**
     * exportPagination(列表页导出数据)
     *
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @param modelMap ModelMap
     * @throws NoSuchFieldException,IOException
     * @Description: 导出3000条市场活动记录
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request,
                                 HttpServletResponse response,
                                 ModelMap modelMap) throws NoSuchFieldException, IOException {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);

        DataShift dataShift = (DataShift) modelMap.get(Constant.VS_DATASHIFT);
        List<MarketActivity> marketActivityLst = marketActivityService.export(searchParams, dataShift);

        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "marketactivity", marketActivityLst).write(response.getOutputStream());
    }

    /**
     * initPageDic(初始化页面字典)
     *
     * @param model Model
     * @Description: 获取视图字典数据
     */
    private void initPageDic(ModelMap model) {
        model.addAttribute("statusDic", dicService.findChildren(DictionaryConstant.VC_ACTIVITYSTATUS, true));// 活动状态
        model.addAttribute("typeDic", dicService.findChildren(DictionaryConstant.VC_ACTIVITYTYPE, true));// 活动类型
    }


    /** 跳转启动审批页面 */
    @RequestMapping("/toStartApprovePage.do")
    public String toStartApprovePage(Long id, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);

        //存储市场活动
        MarketActivity marketActivity = marketActivityService.get(id);
        modelMap.addAttribute("activity", marketActivity);
        modelMap.addAttribute("entity", marketActivity);

        //存储历史记录
        String flowValue = marketActivity.getFlowNode().getFlow().getValue();
        List<FlowInstance> historys = flowInstanceService.findExecuted(Constant.MODULE_MARKETACTIVITY, id, flowValue);
        modelMap.addAttribute("historyRecords", historys);

        //存储当前流程环节
        FlowNode currentFlowNode = marketActivity.getFlowNode();
        currentFlowNode.setApprover(user);
        modelMap.addAttribute("currentFlowNode", currentFlowNode);

        //存储待审批流程
        List<FlowNode> allFlowNodes = flowNodeService.findAllOfFlow(flowValue);
        List<FlowNode> preselectionFlowNodes = flowNodeService.findAfter(allFlowNodes, currentFlowNode);
        flowNodeService.fullReserveExecutor(Constant.MODULE_MARKETACTIVITY, marketActivity.getId(), preselectionFlowNodes);
        flowNodeService.fullPreselectionApprover(preselectionFlowNodes, user);
        modelMap.addAttribute("preselectionFlowNodes", preselectionFlowNodes);
        modelMap.addAttribute("reserveFlowNodes", preselectionFlowNodes);

        modelMap.addAttribute("endFlowNode", NodeType.end.getValue());


        return "/market/marketactivity/view";
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

        flowModel.setFlowValue(flowModel.getExecuteRecord().getFlowNode().getFlow().getValue());
        FlowInstance executeRecord = flowModel.getExecuteRecord();
        executeRecord.setModule(InitApplicationConstant.findModuleByName(Constant.MODULE_MARKETACTIVITY));
        executeRecord.setApprover(user);
        executeRecord.setCreator(user);
        executeRecord.setModifier(user);

        flowInstanceService.start(flowModel);

        JsonDto jsonDto = new JsonDto(executeRecord.getRecordId(), "启动审批成功！");
        return jsonDto.toString();
    }

    /** 跳转执行审批页面 */
    @RequestMapping("/toExecuteApprovePage.do")
    public String toExecuteApprovePage(Long id, Long flowNodeId, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);
        //存储市场活动
        MarketActivity marketActivity = marketActivityService.get(id);
        modelMap.addAttribute("activity", marketActivity);
        modelMap.addAttribute("entity", marketActivity);

        String flowValue = marketActivity.getFlowNode().getFlow().getValue();
        List<FlowNode> allFlowNodes = flowNodeService.findAllOfFlow(flowValue);
//        allFlowNodes = flowInstanceService.findReserveFlowNode(flowInstanceService.findReserve(Constant.MODULE_MARKETACTIVITY,id,flowValue));

        //存储历史记录
        List<FlowInstance> historys = flowInstanceService.findExecuted(Constant.MODULE_MARKETACTIVITY, id, flowValue);
        modelMap.addAttribute("historyRecords", historys);

        //存储当前业务流程环节
        FlowNode businessFlowNode = marketActivity.getFlowNode();
        businessFlowNode.setApprover(user);
        modelMap.addAttribute("businessFlowNode", businessFlowNode);

        //存储当前执行流程环节
        FlowNode currentFlowNode = businessFlowNode;
        if (flowNodeId != null) {
            currentFlowNode = flowNodeService.get(flowNodeId);
            currentFlowNode.setApprover(user);

            List<FlowNode> skipFlowNodes = flowNodeService.findBetween(allFlowNodes, businessFlowNode, currentFlowNode);
            flowNodeService.fullReserveExecutor(Constant.MODULE_MARKETACTIVITY, marketActivity.getId(), skipFlowNodes);
            modelMap.addAttribute("skipFlowNodes", skipFlowNodes);
        }
        modelMap.addAttribute("currentFlowNode", currentFlowNode);


        //存储下一个流程
        FlowNode nextFlowNode = flowNodeService.findNext(allFlowNodes, currentFlowNode);
        flowNodeService.fullPreselectionApprover(nextFlowNode, user);
        flowNodeService.fullReserveExecutor(Constant.MODULE_MARKETACTIVITY, marketActivity.getId(), nextFlowNode);
        modelMap.addAttribute("nextFlowNode", nextFlowNode);

        //存储待审批流程
        List<FlowNode> preselectionFlowNodes = flowNodeService.findAfter(allFlowNodes, currentFlowNode);
        flowNodeService.fullReserveExecutor(Constant.MODULE_MARKETACTIVITY, marketActivity.getId(), preselectionFlowNodes);
        modelMap.addAttribute("reserveFlowNodes", preselectionFlowNodes);

        modelMap.addAttribute("endFlowNode", NodeType.end.getValue());

        return "/market/marketactivity/view";
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

        flowModel.setFlowValue(flowModel.getExecuteRecord().getFlowNode().getFlow().getValue());

        FlowInstance executeRecord = flowModel.getExecuteRecord();
        executeRecord.setModule(InitApplicationConstant.findModuleByName(Constant.MODULE_MARKETACTIVITY));
        executeRecord.setApprover(user);
        executeRecord.setCreator(user);
        executeRecord.setModifier(user);

        flowInstanceService.execute(flowModel);
        JsonDto jsonDto = new JsonDto(executeRecord.getRecordId(), "执行审批成功！");
        return jsonDto.toString();
    }


    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        DataShift dataShift = (DataShift) modelMap.get(Constant.VS_DATASHIFT);
        dataShift = dataShift.renameUserFieldName("bossHead");
        exportLimit(request, modelMap, response, dataShift);
    }
    
    /************************************组件请求******************************************/
    @RequestMapping(value = "/toSearchMarketActivityPage.docomp")
    public String toQueryPageComp(HibernatePage<MarketActivity> page, ModelMap model) {
        page.setHibernateOrderBy("modifiedTime");// 默认按照修改时间倒序排序
        page.setHibernateOrder(HibernatePage.DESC);
        page.setHibernatePageSize(12);
        model.addAttribute("page", page);
        initPageDic(model);
        
        return "/market/marketactivity/listcomp";
    }
    @ResponseBody
    @RequestMapping(value = "/searchMarketActivity.docomp")
    public String searchMarketActivity(HttpServletRequest request, 
    		HibernatePage<MarketActivity> page, 
    		ModelMap model) throws NoSuchFieldException {
        /************获取查询条件**************/
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);

        /************分页查询*****************/
        marketActivityService.findPage(searchParams, dataShift, page);

        /************json转换****************/
        JsonDto json = new JsonDto();
        json.setResult(page);

        return json.toString();
    }

}
