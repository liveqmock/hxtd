
package com.baihui.hxtd.soa.project.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 
 * 功能描述： 产品实体类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.project.entity.Project.java
 * @version (版本) 1
 * @date 2014-6-6 下午03:53:02
 */
@Entity
@Table(name = "project")
public class Project {
	/**
	 * 主键ID
	 */
	@FieldInfo(desc = "主键ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 供应商
	 */
	@FieldInfo(desc = "供应商名称")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="SUPPLIER_ID")
	private Supplier supplier;
	/**
	 * 项目编号
	 */
	@FieldInfo(desc = "项目编号")
	@Column(name="CODE")
	private String code;
	/**
	 * 项目名称
	 */
	@FieldInfo(desc = "项目名称")
	@Column(name="NAME")
	private String name;
	/**
	 * 融资额度
	 */
	@FieldInfo(desc = "融资额度")
	@Column(name="FINANCE_LIMIT")
	private BigDecimal financeLimit;
	/**
	 * 开始时间
	 */
	@FieldInfo(desc = "开始时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name="BEGIN_TIME")
	private Date beginTime;
	/**
	 * 融资前周期（天）
	 */
	@FieldInfo(desc = "融资前周期（天）")
	@Column(name="BEFORE_FINANCE_CYCLE")
	private Integer beforeFinanceCycle;
	/**
	 * 融资周期
	 */
	@FieldInfo(desc = "融资周期")
	@Column(name="FINANCE_CYCLE")
	private Integer financeCycle;
	/**
	 * 开放期 
	 */
	@FieldInfo(desc = "开放期")
	@Column(name="OPEN_TIME")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	private Date openTime;
	/**
	 * 截止时间
	 */
	@FieldInfo(desc = "截止时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name="DENDLINE_TIME")
	private Date dendlineTime;
	/**
	 * 收益率
	 */
	@FieldInfo(desc = "收益率")
	@Column(name="EARNING_RATE")
	private Float er;
	/**
	 * 提前赎回率
	 */
	@FieldInfo(desc = "赎回赔率")
	@Column(name="ADVANCE_REDEEM_RATE")
	private Float aer;
	/**
	 * 支付方式
	 */
	@FieldInfo(desc = "支付方式")
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PAY_TYPE")
	private Dictionary payType;
	/**
	 * 备注
	 */
	@FieldInfo(desc = "备注")
	@Column(name = "REMARK", length = 512)
	private String remark;
	/**
	 * 创建者
	 */
	@FieldInfo(desc = "创建者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID", updatable = false)
	private User creator;
	/**
	 * 创建时间
	 */
	@FieldInfo(desc = "创建时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME")
	private Date createdTime;
	/**
	 * 最后修改者
	 */
	@FieldInfo(desc = "最后修改者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODIFIER_ID")
	private User modifier;
	/**
	 * 最后修改时间
	 */
	@FieldInfo(desc = "最后修改时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "MODIFIED_TIME", nullable = false)
	private Date modifiedTime;
	
	
	@Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted = false;


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public Supplier getSupplier() {
		return supplier;
	}


	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
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


	public BigDecimal getFinanceLimit() {
		return financeLimit;
	}


	public void setFinanceLimit(BigDecimal financeLimit) {
		this.financeLimit = financeLimit;
	}


	public Date getBeginTime() {
		return beginTime;
	}


	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}


	public Integer getBeforeFinanceCycle() {
		return beforeFinanceCycle;
	}


	public void setBeforeFinanceCycle(Integer beforeFinanceCycle) {
		this.beforeFinanceCycle = beforeFinanceCycle;
	}


	public Integer getFinanceCycle() {
		return financeCycle;
	}


	public void setFinanceCycle(Integer financeCycle) {
		this.financeCycle = financeCycle;
	}


	public Date getOpenTime() {
		return openTime;
	}


	public void setOpenTime(Date openTime) {
		this.openTime = openTime;
	}


	public Date getDendlineTime() {
		return dendlineTime;
	}


	public void setDendlineTime(Date dendlineTime) {
		this.dendlineTime = dendlineTime;
	}


	public Float getEr() {
		return er;
	}


	public void setEr(Float er) {
		this.er = er;
	}


	public Float getAer() {
		return aer;
	}


	public void setAer(Float aer) {
		this.aer = aer;
	}


	public Dictionary getPayType() {
		return payType;
	}


	public void setPayType(Dictionary payType) {
		this.payType = payType;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
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


	public Boolean getIsDeleted() {
		return isDeleted;
	}


	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
	
	
}
