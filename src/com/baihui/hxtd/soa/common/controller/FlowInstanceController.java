package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.common.entity.FlowInstance;
import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.IdFlowable;
import com.baihui.hxtd.soa.common.entity.NodeType;
import com.baihui.hxtd.soa.common.service.FlowInstanceService;
import com.baihui.hxtd.soa.common.service.FlowNodeService;
import com.baihui.hxtd.soa.system.entity.User;
import org.springframework.ui.ModelMap;

import javax.annotation.Resource;
import java.util.List;

/**
 * 流程实例控制器
 *
 * @author xiayouxue
 * @date 2014/7/26
 */
public class FlowInstanceController {

    /** 已执行的流程实例 */
    public final static String FLOW_INSTANCE_EXECUTEDS = "historyRecords";
    /** 当前执行的流程环节 */
    public final static String FLOW_NODE_CURRENT = "currentFlowNode";
    /** 预定的流程环节 */
    public final static String FLOW_NODE_RESERVES = "reserveFlowNodes";
    /** 预选执行者的流程环节 */
    public final static String FLOW_NODE_PRESELECTIONS = "preselectionFlowNodes";


    private FlowInstance flowInstance;

    @Resource
    private FlowInstanceService flowInstanceService;

    @Resource
    private FlowNodeService flowNodeService;


    /** 存储流程图谱 */
    public void storeFlowGraph(IdFlowable idFlowable, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);

        //存储历史记录
        List<FlowInstance> historys = flowInstanceService.findExecuted(flowInstance.getModule().getName(), idFlowable.getId(), flowInstance.getFlowNode().getFlow().getValue());
        modelMap.addAttribute(FLOW_INSTANCE_EXECUTEDS, historys);

        //存储当前流程
        FlowNode currentFlowNode = idFlowable.getFlowNode();
        if (currentFlowNode.getType().equals(NodeType.start.getValue())) {
            currentFlowNode.setApprover(user);
        } else {
            flowNodeService.fullReserveExecutor(flowInstance.getModule().getName(), idFlowable.getId(), currentFlowNode);
        }
        modelMap.addAttribute(FLOW_NODE_CURRENT, currentFlowNode);

        //存储预定审批环节
        List<FlowNode> flowNodes = flowNodeService.findAllOfFlow(flowInstance.getFlowNode().getFlow().getValue());
        List<FlowNode> reserveFlowNodes = flowNodeService.findAfter(flowNodes, currentFlowNode);
        if (!currentFlowNode.getType().equals(NodeType.start.getValue())) {
            flowNodeService.fullReserveExecutor(Constant.MODULE_ORDER, idFlowable.getId(), reserveFlowNodes);
        }
        modelMap.addAttribute(FLOW_NODE_RESERVES, reserveFlowNodes);

        modelMap.addAttribute("endFlowNode", NodeType.end.getValue());
    }

    /** 存储流程环节候选执行者 */
    public void storePreselection(IdFlowable idFlowable, ModelMap modelMap) {
        User user = (User) modelMap.get(Constant.VS_USER);
        List<FlowNode> allFlowNodes = flowNodeService.findAllOfFlow(flowInstance.getFlowNode().getFlow().getValue());
        List<FlowNode> preselectionFlowNodes = flowNodeService.findAfter(allFlowNodes, idFlowable.getFlowNode());
        flowNodeService.fullPreselectionApprover(preselectionFlowNodes, user);
        modelMap.addAttribute(FLOW_NODE_PRESELECTIONS, preselectionFlowNodes);
        modelMap.addAttribute("reserveFlowNodes", preselectionFlowNodes);
    }


    public FlowInstance getFlowInstance() {
        return flowInstance;
    }

    public void setFlowInstance(FlowInstance flowInstance) {
        this.flowInstance = flowInstance;
    }
}
