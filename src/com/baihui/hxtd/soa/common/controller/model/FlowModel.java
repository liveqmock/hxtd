package com.baihui.hxtd.soa.common.controller.model;

import com.baihui.hxtd.soa.common.entity.FlowInstance;
import com.baihui.hxtd.soa.common.entity.FlowNode;

import java.util.ArrayList;
import java.util.List;

/**
 * 审批模型
 *
 * @author xiayouxue
 * @date 2014/7/22
 */
public class FlowModel {

    /** 流程类型 */
    private String flowValue;
    /** 预定执行记录列表 */
    private List<FlowInstance> reserveExecuteRecoreds = new ArrayList<FlowInstance>();
    /** 当前执行记录 */
    private FlowInstance executeRecord;
    /** 当前流程环节 */
    private FlowNode currentFlowNode;
    /** 下一个流程环节 */
    private FlowNode nextFlowNode;

    public String getFlowValue() {
        return flowValue;
    }

    public void setFlowValue(String flowValue) {
        this.flowValue = flowValue;
    }

    public List<FlowInstance> getReserveExecuteRecoreds() {
        return reserveExecuteRecoreds;
    }

    public void setReserveExecuteRecoreds(List<FlowInstance> reserveExecuteRecoreds) {
        this.reserveExecuteRecoreds = reserveExecuteRecoreds;
    }

    public FlowInstance getExecuteRecord() {
        return executeRecord;
    }

    public void setExecuteRecord(FlowInstance executeRecord) {
        this.executeRecord = executeRecord;
    }

    public FlowNode getCurrentFlowNode() {
        return currentFlowNode;
    }

    public void setCurrentFlowNode(FlowNode currentFlowNode) {
        this.currentFlowNode = currentFlowNode;
    }

    public FlowNode getNextFlowNode() {
        return nextFlowNode;
    }

    public void setNextFlowNode(FlowNode nextFlowNode) {
        this.nextFlowNode = nextFlowNode;
    }
}
