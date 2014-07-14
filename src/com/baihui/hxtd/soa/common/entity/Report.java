package com.baihui.hxtd.soa.common.entity;

import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 报表实体类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Entity
@Table(name = "REPORT")
public class Report implements Serializable, Idable, Initialized {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "CODE", length = 32, unique = true, updatable = false)
    private String code;

    @Column(name = "NAME", length = 62, nullable = false, unique = true)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODULE_ID", nullable = false)
    private Module module;

    @Column(name = "X_FIELD_NAME", length = 32, nullable = false)
    private String xFieldName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "X_TYPE_ID", nullable = false)
    private Dictionary xGroupType;

    @Column(name = "Y_FIELD_NAME", length = 32)
    private String yFieldName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Y_TYPE_ID", nullable = false)
    private Dictionary yAggregateType;

    @Column(name = "Z_FIELD_NAME", length = 32)
    private String zFieldName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Z_TYPE_ID")
    private Dictionary zGroupType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CHART_ID", nullable = false)
    private Dictionary chart;

    @Column(name = "REMARK", length = 512)
    private String remark;

    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted;

    @Column(name = "IS_INITIALIZED", nullable = false, updatable = false)
    private Boolean isInitialized;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", nullable = false, updatable = false)
    private User creator;

    @Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createdTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID", nullable = false)
    private User modifier;

    @Column(name = "MODIFIED_TIME", updatable = false)
    private Date modifiedTime;


    public Report() {
    }

    public Report(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public String getxFieldName() {
        return xFieldName;
    }

    public void setxFieldName(String xFieldName) {
        this.xFieldName = xFieldName;
    }

    public Dictionary getxGroupType() {
        return xGroupType;
    }

    public void setxGroupType(Dictionary xGroupType) {
        this.xGroupType = xGroupType;
    }

    public String getzFieldName() {
        return zFieldName;
    }

    public void setzFieldName(String zFieldName) {
        this.zFieldName = zFieldName;
    }

    public Dictionary getzGroupType() {
        return zGroupType;
    }

    public void setzGroupType(Dictionary zGroupType) {
        this.zGroupType = zGroupType;
    }

    public Dictionary getyAggregateType() {
        return yAggregateType;
    }

    public void setyAggregateType(Dictionary yAggregateType) {
        this.yAggregateType = yAggregateType;
    }

    public String getyFieldName() {
        return yFieldName;
    }

    public void setyFieldName(String yFieldName) {
        this.yFieldName = yFieldName;
    }

    public Dictionary getChart() {
        return chart;
    }

    public void setChart(Dictionary chart) {
        this.chart = chart;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Boolean getIsInitialized() {
        return isInitialized;
    }

    public void setIsInitialized(Boolean isInitialized) {
        this.isInitialized = isInitialized;
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
