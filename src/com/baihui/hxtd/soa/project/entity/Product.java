package com.baihui.hxtd.soa.project.entity;

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

import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 功能描述：产品实体类
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.project.entity.Product.java
 * @version (版本)1 
 * @date 2014-5-16 下午02:57:10
 */
@Entity
@Table(name = "PRODUCT")
public class Product {
	
	public Product(){}
	
	/**
	 * 主键ID
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 项目
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PROJECT_ID")
	private Project project;
	/**
	 * 产品名称
	 */
	@Column(name = "NAME")
	private String name;
	/**
	 * 产品编码
	 */
	@Column(name = "CODE")
	private String code;
	/**
	 * 产品类型
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "TYPE")
	private Dictionary type;
	/**
	 * 出售金额
	 */
	@Column(name = "START_SELL_MONEY")
	private float sellMoney;
	/**
	 * 最小利率
	 */
	@Column(name = "MIN_ERNING_RATE")
	private float minRate;
	/**
	 * 最大利率
	 */
	@Column(name = "MAX_ERNING_RATE")
	private float maxRate;
	/**
	 * 预期收益
	 */
	@Column(name = "EXPECT_PROFIT")
	private float expectProfit;
	/**
	 * 销售期限
	 */
	@Column(name = "SALE_LIMIT")
	private Long saleLimit;
	/**
	 * 销售单位
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SALE_UNIT")
	private Dictionary saleUnit;
	/**
	 * 销售开始日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name = "SALE_BEGIN_TIME")
	private Date saleBeginTime;
	/**
	 * 销售结束日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name = "SALE_END_TIME")
	private Date saleEndTime;
	/**
	 * 提前赎回率
	 */
	@Column(name = "ADVANCE_REDEEM_RATE")
	private float redeemRate;
	/**
	 * 提前赎回公式
	 */
	@Column(name = "ADVANCE_REDEEM_FORMULA")
	private String redeemFormula;
	/**
	 * 是否有效
	 */
	@Column(name = "IS_EFFECT")
	private char isEffect;
	/**
	 * 备注
	 */
	@Column(name = "REMARK", length = 512)
	private String remark;
	/**
	 * 标记删除
	 */
	@Column(name = "IS_DELETED")
	private Boolean isDeleted = false;

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
	@Column(name = "MODIFIED_TIME")
	private Date modifiedTime;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Dictionary getType() {
		return type;
	}
	public void setType(Dictionary type) {
		this.type = type;
	}
	public float getSellMoney() {
		return sellMoney;
	}
	public void setSellMoney(float sellMoney) {
		this.sellMoney = sellMoney;
	}
	public float getMinRate() {
		return minRate;
	}
	public void setMinRate(float minRate) {
		this.minRate = minRate;
	}
	public float getMaxRate() {
		return maxRate;
	}
	public void setMaxRate(float maxRate) {
		this.maxRate = maxRate;
	}
	public float getExpectProfit() {
		return expectProfit;
	}
	public void setExpectProfit(float expectProfit) {
		this.expectProfit = expectProfit;
	}
	public Long getSaleLimit() {
		return saleLimit;
	}
	public void setSaleLimit(Long saleLimit) {
		this.saleLimit = saleLimit;
	}
	public Dictionary getSaleUnit() {
		return saleUnit;
	}
	public void setSaleUnit(Dictionary saleUnit) {
		this.saleUnit = saleUnit;
	}
	public Date getSaleBeginTime() {
		return saleBeginTime;
	}
	public void setSaleBeginTime(Date saleBeginTime) {
		this.saleBeginTime = saleBeginTime;
	}
	public Date getSaleEndTime() {
		return saleEndTime;
	}
	public void setSaleEndTime(Date saleEndTime) {
		this.saleEndTime = saleEndTime;
	}
	public float getRedeemRate() {
		return redeemRate;
	}
	public void setRedeemRate(float redeemRate) {
		this.redeemRate = redeemRate;
	}
	public String getRedeemFormula() {
		return redeemFormula;
	}
	public void setRedeemFormula(String redeemFormula) {
		this.redeemFormula = redeemFormula;
	}
	public char getIsEffect() {
		return isEffect;
	}
	public void setIsEffect(char isEffect) {
		this.isEffect = isEffect;
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
