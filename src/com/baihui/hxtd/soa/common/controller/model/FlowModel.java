package com.baihui.hxtd.soa.common.controller.model;

import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.WFNode;
import com.baihui.hxtd.soa.system.entity.User;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 审批模型
 *
 * @author xiayouxue
 * @date 2014/7/22
 */
public class FlowModel {

    /** 流程类型 */
    private String flowType;
    /** 所属模块 */
    private Module module;
    /** 主键编号值 */
    private Long id;
    /** 节点列表 */
    private List<WFNode> nodes = new ArrayList<WFNode>();
    /** 操作者 */
    private User operater;
    /** 操作时间 */
    private Date operateTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFlowType() {
        return flowType;
    }

    public void setFlowType(String flowType) {
        this.flowType = flowType;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public List<WFNode> getNodes() {
        return nodes;
    }

    public void setNodes(List<WFNode> nodes) {
        this.nodes = nodes;
    }

    public User getOperater() {
        return operater;
    }

    public void setOperater(User operater) {
        this.operater = operater;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }
}
