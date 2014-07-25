
package com.baihui.hxtd.soa.sales.entity;

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

import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 
 * 功能描述：销售目标实体类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.sales.entity.SalesTarget.java
 * @version (版本)1 
 * @date 2014-7-15 下午13:06:45
 */
@Entity
@Table(name = "SALES_TARGET")
public class SalesTarget {

	/** 销售目标ID */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 标题
	 */
	@Column(name="TITLE")
	private String title;
	/**
	 * 标题
	 */
	@Column(name="TIME_STR")
	private String timeStr;
	/**
	 * 定制目标的人员
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNER_ID",updatable=false)
	private User owner;
	
	/**
	 * 目标成交额
	 */
	@Column(name="BARGAIN_MONEY")
	private BigDecimal bargainMoney;
	/**
	 * 开始时间
	 */
	@Column(name="BEGIN_TIME")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	private Date beginTime;
	/**
	 * 结束时间
	 */
	@Column(name="END_TIME")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	private Date endTime;
	
	/** 备注 */
	@Column(name = "REMARK", length = 512)
	private String remark;

	/** 创建者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID", updatable = false)
	private User creator;

	/** 创建时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME")
	private Date createdTime;

	/** 修改者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODIFIER_ID")
	private User modifier;

	/** 最终修改时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "MODIFIED_TIME")
	private Date modifiedTime;
	
	/**删除标识*/
	@Column(name = "IS_DELETED", nullable = false, updatable = false)
	private Boolean isDeleted = false;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public BigDecimal getBargainMoney() {
		return bargainMoney;
	}

	public void setBargainMoney(BigDecimal bargainMoney) {
		this.bargainMoney = bargainMoney;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getTimeStr() {
		return timeStr;
	}

	public void setTimeStr(String timeStr) {
		this.timeStr = timeStr;
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
