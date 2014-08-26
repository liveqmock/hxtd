package com.baihui.hxtd.soa.market.entity;

import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.IdFlowable;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "market_activity")
@DynamicInsert(true)
@DynamicUpdate(true)
@SuppressWarnings("serial")
public class MarketActivity implements Serializable, IdFlowable {

    public MarketActivity() {
    }

    /** 主键Id */
    @FieldInfo(desc = "主键Id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    /** 活动名称 */
    @FieldInfo(desc = "活动名称")
    @Column(name = "NAME")
    private String name;

    /** 活动类型 */
    @FieldInfo(desc = "活动类型")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TYPE_DIC")
    @NotFound(action = NotFoundAction.IGNORE)
    private Dictionary typeDic;

    /** 流程环节 */
    @FieldInfo(desc = "流程环节")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FLOW_NODE_ID")
    private FlowNode flowNode;

    /** 活动状态 */
    @FieldInfo(desc = "活动状态")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "STATUS_DIC")
    @NotFound(action = NotFoundAction.IGNORE)
    private Dictionary statusDic;

    /** 开始日期 */
    @FieldInfo(desc = "开始日期")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
    @Column(name = "BEGIN_DATE")
    private Date beginDate;

    /** 结束日期 */
    @FieldInfo(desc = "结束日期")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
    @Column(name = "END_DATE")
    private Date endDate;

    /** 预计成本 */
    @FieldInfo(desc = "预计成本")
    @Column(name = "PREDICT_COST")
    private double predictCost;

    /** 实际成本 */
    @FieldInfo(desc = "实际成本")
    @Column(name = "REALITY_COST")
    private double realityCost;

    /** 活动次数 */
    @FieldInfo(desc = "活动次数")
    @Column(name = "TIMES")
    private Long times;

    /** 预期效果 */
    @FieldInfo(desc = "预期效果")
    @Column(name = "EXPECT_EFFECT")
    private String expectEffect;

    /** 期望成功率 */
    @FieldInfo(desc = "期望成功率")
    @Column(name = "EXPECT_SUCCESS_RATE")
    private float expectSuccessRate;

    /** 活动发起人 */
    @FieldInfo(desc = "活动发起人")
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SPONSOR", updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    private User sponsor;

    /** 负责人 */
    @FieldInfo(desc = "负责人")
    //@JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BOSSHEAD")
    @NotFound(action = NotFoundAction.IGNORE)
    private User bossHead;

    /** 备注 */
    @FieldInfo(desc = "备注")
    @Column(name = "REMARK")
    private String remark;

    /** 是否发送消息提醒 */
    @FieldInfo(desc = "是否发送消息提醒")
    @Column(name = "IS_SEND", updatable = false)
    private Long isSendMsg;

    /** 删除标记 */
    @FieldInfo(desc = "删除标记")
    @Column(name = "IS_DELETED")
    private Boolean isDeleted = false;

    /** 创建者 */
    @FieldInfo(desc = "创建者")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    private User creator;

    /** 创建时间 */
    @FieldInfo(desc = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "CREATED_TIME", updatable = false)
    private Date createdTime;

    /** 最后修改者 */
    @FieldInfo(desc = "最后修改者")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    @NotFound(action = NotFoundAction.IGNORE)
    private User modifier;

    /** 最后修改时间 */
    @FieldInfo(desc = "最后修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
    private Date modifiedTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Dictionary getTypeDic() {
        return typeDic;
    }

    public void setTypeDic(Dictionary typeDic) {
        this.typeDic = typeDic;
    }

    public FlowNode getFlowNode() {
        return flowNode;
    }

    @Override
    public String getSketch() {
        return "市场活动名称：" + getName();
    }

    public void setFlowNode(FlowNode flowNode) {
        this.flowNode = flowNode;
    }

    public Dictionary getStatusDic() {
        return statusDic;
    }

    public void setStatusDic(Dictionary statusDic) {
        this.statusDic = statusDic;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getPredictCost() {
        return predictCost;
    }

    public void setPredictCost(double predictCost) {
        this.predictCost = predictCost;
    }

    public double getRealityCost() {
        return realityCost;
    }

    public void setRealityCost(double realityCost) {
        this.realityCost = realityCost;
    }

    public Long getTimes() {
        return times;
    }

    public void setTimes(Long times) {
        this.times = times;
    }

    public String getExpectEffect() {
        return expectEffect;
    }

    public void setExpectEffect(String expectEffect) {
        this.expectEffect = expectEffect;
    }

    public float getExpectSuccessRate() {
        return expectSuccessRate;
    }

    public void setExpectSuccessRate(float expectSuccessRate) {
        this.expectSuccessRate = expectSuccessRate;
    }

    public User getSponsor() {
        return sponsor;
    }

    public void setSponsor(User sponsor) {
        this.sponsor = sponsor;
    }

    public User getBossHead() {
        return bossHead;
    }

    public void setBossHead(User bossHead) {
        this.bossHead = bossHead;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Long getIsSendMsg() {
        return isSendMsg;
    }

    public void setIsSendMsg(Long isSendMsg) {
        this.isSendMsg = isSendMsg;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
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
}
