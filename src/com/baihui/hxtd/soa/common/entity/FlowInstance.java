package com.baihui.hxtd.soa.common.entity;

import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 功能描述：流程任务实体类
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.entity.FlowInstance.java
 * @date 2014-5-26 上午09:47:36
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Entity
@Table(name = "wf_task")
@DynamicInsert(true)
@SuppressWarnings("serial")
public class FlowInstance implements Serializable {

    public FlowInstance() {
    }

    public FlowInstance(FlowNode node, Module typeDic, Long recordId, Organization org, User approver,
                        Boolean isPassed, Date approveTime, String reason, User creator, Date createdTime) {
        this.flowNode = node;
        this.recordId = recordId;
        this.module = typeDic;
        this.org = org;
        this.approver = approver;
        this.isPassed = isPassed;
        this.approveTime = approveTime;
        this.reason = reason;
        this.creator = creator;
        this.createdTime = createdTime;
    }

    /**
     * 主键ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    /**
     * 流程环节
     */
    @ManyToOne
    @JoinColumn(name = "NODE_ID")
    private FlowNode flowNode;
    /**
     * 模块
     */
    @ManyToOne
    @JoinColumn(name = "MODULE_ID")
    private Module module;
    /**
     * 关联模块ID
     */
    @Column(name = "RECORD_ID")
    private Long recordId;
    /**
     * 所处机构
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ORG_ID")
    private Organization org;
    /**
     * 审批者
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "APPROVER_ID")
    private User approver;
    /**
     * 审批状态
     */
    @Column(name = "IS_PASSED")
    private Boolean isPassed;
    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "APPROVE_TIME")
    private Date approveTime;
    /**
     * 退回原因
     */
    @Column(name = "REJECT_REASON")
    private String reason;
    /**
     * 创建者
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;
    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "CREATED_TIME", updatable = false)
    private Date createdTime;
    /**
     * 最后修改者
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;
    /**
     * 最后修改时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
    private Date modifiedTime;

    /** 流程业务实体 */
    @Transient
    private IdFlowable flowBusiness;

    /** 待选执行者 */
    @Transient
    private List<User> executors = new ArrayList<User>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public FlowNode getFlowNode() {
        return flowNode;
    }

    public void setFlowNode(FlowNode flowNode) {
        this.flowNode = flowNode;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Long getRecordId() {
        return recordId;
    }

    public void setRecordId(Long recordId) {
        this.recordId = recordId;
    }

    public Organization getOrg() {
        return org;
    }

    public void setOrg(Organization org) {
        this.org = org;
    }

    public User getApprover() {
        return approver;
    }

    public void setApprover(User approver) {
        this.approver = approver;
    }

    public Boolean getIsPassed() {
        return isPassed;
    }

    public void setIsPassed(Boolean isPassed) {
        this.isPassed = isPassed;
    }

    public Date getApproveTime() {
        return approveTime;
    }

    public void setApproveTime(Date approveTime) {
        this.approveTime = approveTime;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public User getModifier() {
        return modifier;
    }

    public void setModifier(User modifier) {
        this.modifier = modifier;
    }

    public Date getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(Date modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    public IdFlowable getFlowBusiness() {
        return flowBusiness;
    }

    public void setFlowBusiness(IdFlowable flowBusiness) {
        this.flowBusiness = flowBusiness;
    }

    public List<User> getExecutors() {
        return executors;
    }

    public void setExecutors(List<User> executors) {
        this.executors = executors;
    }
}
