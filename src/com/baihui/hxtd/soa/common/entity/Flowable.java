package com.baihui.hxtd.soa.common.entity;

/**
 * 具有流程功能的
 *
 * @author xiayouxue
 * @date 2014/7/23
 */
public interface Flowable {
    /** 获取流程环节 */
    public FlowNode getFlowNode();

    /** 获取简述，关于该业务实体的简要描述 */
    public String getSketch();
}
