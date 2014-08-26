package com.baihui.hxtd.soa.order.entity;

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

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 
 * 功能描述：合同实体类
 * 
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.order.entity.Contract.java
 * @version (版本)1
 * @date 2014-7-15 上午10:57:57
 */

@Entity
@Table(name = "contract")
public class Contract {
	/**
	 * 序列化
	 */
	private static final long serialVersionUID = 1L;

	/**ID */
	@FieldInfo(desc = "主键ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	
	/**
	 * 合同名称
	 */
	@FieldInfo(desc = "合同名称")
	@Column(name = "NAME")
	private String name;
	
	/**
	 * 合同编号
	 */
	@FieldInfo(desc = "合同编号")
	@Column(name = "CODE")
	private String code;
	
	/**
	 * 合同金额
	 */
	@FieldInfo(desc = "合同金额")
	@Column(name = "PURCHASE_MONEY")
	private BigDecimal purchaseMoney;
	
	/** 合同类型 */
	@FieldInfo(desc = "合同类型")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "TYPE_DIC")
	private Dictionary type;
	
	/** 合同内容*/
	@FieldInfo(desc = "合同内容")
	@Column(name = "CONTENT")
	private String content;
	
	/** 关联订单 */
	@FieldInfo(desc = "关联订单")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ORDER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private Order order;
	
	/** 关联客户 */
	@FieldInfo(desc = "关联客户")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ACCOUNT_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private Customer customer;
	
	/** 赎回方式 */
	@FieldInfo(desc = "赎回方式")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "REDEEM_TYPE_DIC")
	@NotFound(action = NotFoundAction.IGNORE)
	private Dictionary redeemType;
	
	/** 签订时间 */
	@FieldInfo(desc = "签订时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name = "SIGN_TIME")
	private Date signTime;
	
	/** 生效时间 */
	@FieldInfo(desc = "生效时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name = "EFFECT_TIME")
	private Date effectTime;
	
	/** 失效时间 */
	@FieldInfo(desc = "失效时间")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name = "BEREFT_TIME")
	private Date bereftTime;
	
	/** 备注 */
	@FieldInfo(desc = "备注")
	@Column(name = "REMARK", length = 512)
	private String remark;
	
	/** 创建者 */
	@FieldInfo(desc = "创建者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID", updatable = false)
	@NotFound(action = NotFoundAction.IGNORE)
	private User creator;

	/** 创建时间 */
	@FieldInfo(desc = "创建时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME",updatable = false)
	private Date createdTime;
	
	/** 修改者 */
	@FieldInfo(desc = "修改者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODIFIER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private User modifier;
	
	/** 最终修改时间 */
	@FieldInfo(desc = "最终修改时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
	private Date modifiedTime;
	
	/**删除标识*/
	@FieldInfo(desc = "删除标识")
	@Column(name = "IS_DELETED", nullable = false)
	private Boolean isDeleted = false;

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Dictionary getRedeemType() {
		return redeemType;
	}

	public void setRedeemType(Dictionary redeemType) {
		this.redeemType = redeemType;
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

	public Date getSignTime() {
		return signTime;
	}

	public void setSignTime(Date signTime) {
		this.signTime = signTime;
	}

	public Date getEffectTime() {
		return effectTime;
	}

	public void setEffectTime(Date effectTime) {
		this.effectTime = effectTime;
	}

	public Date getBereftTime() {
		return bereftTime;
	}

	public void setBereftTime(Date bereftTime) {
		this.bereftTime = bereftTime;
	}

	public BigDecimal getPurchaseMoney() {
		return purchaseMoney;
	}

	public void setPurchaseMoney(BigDecimal purchaseMoney) {
		this.purchaseMoney = purchaseMoney;
	}

	

	
}
