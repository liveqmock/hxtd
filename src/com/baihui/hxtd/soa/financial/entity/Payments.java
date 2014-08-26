package com.baihui.hxtd.soa.financial.entity;

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
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 应付款项
 * @author huizijing
 *
 */
@Entity
@Table(name = "payments")
public class Payments {
	/**ID */
	@FieldInfo(desc = "主键ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	
	/**名称 */
	@FieldInfo(desc = "名称")
	@Column(name = "NAME")
	private String name;
	
	/** 关联客户 */
	@FieldInfo(desc = "关联客户")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUSTOMER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private Customer customer;
	
	/** 关联订单 */
	@FieldInfo(desc = "关联订单")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ORDER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private Order order;
	
	/** 账款 */
	@FieldInfo(desc = "账款")
	@Column(name = "FUND")
	private BigDecimal fund; 
	
	/** 实际付款 */
	@FieldInfo(desc = "实际付款")
	@Column(name = "ACTUAL")
	private BigDecimal actual; 
	
	/** 是否打款 */
	@FieldInfo(desc = "是否打款")
	@Column(name = "STATUS")
	private boolean status = false;
	
	/** 开户行 */
	@FieldInfo(desc = "开户行")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OPEN_BANK_DIC")
	@NotFound(action = NotFoundAction.IGNORE)
	private Dictionary openBank;

	/** 银行户名 */
	@FieldInfo(desc = "银行户名")
	@Column(name = "BANK_NAME")
	private String bankName;

	/** 银行账号 */
	@FieldInfo(desc = "银行账号")
	@Column(name = "BANK_ACCOUNT")
	private String bankAccount;

	/** 支付方式 */
	@FieldInfo(desc = "支付方式")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PAY_TYPE_DIC")
	@NotFound(action = NotFoundAction.IGNORE)
	private Dictionary payType;
	
	/** 备注 */
	@FieldInfo(desc = "备注")
	@Column(name = "REMARK")
	private String remark;
	
	/** 操作时间 */
	@FieldInfo(desc = "操作时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "OPERATE_TIME")
	private Date operateTime;
	
	/** 操作者 */
	@FieldInfo(desc = "操作者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNER_ID",updatable = false)
	@NotFound(action = NotFoundAction.IGNORE)
	private User owner;

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
	@FieldInfo(desc = "修改者 ")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODIFIER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private User modifier;
	
	/** 最终修改时间 */
	@FieldInfo(desc = "最终修改时间 ")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
	private Date modifiedTime;
	
	/**删除标识*/
	@FieldInfo(desc = "删除标识")
	@Column(name = "IS_DELETED", nullable = false)
	private Boolean isDeleted = false;

	
	
	public Payments() {
		super();
	}

	public Payments(String name, Customer customer, Order order,
			BigDecimal fund, String remark, Date operateTime) {
		super();
		this.name = name;
		this.customer = customer;
		this.order = order;
		this.fund = fund;
		this.remark = remark;
		this.operateTime = operateTime;
	}

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

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public BigDecimal getFund() {
		return fund;
	}

	public void setFund(BigDecimal fund) {
		this.fund = fund;
	}

	public BigDecimal getActual() {
		return actual;
	}

	public void setActual(BigDecimal actual) {
		this.actual = actual;
	}

	public boolean getStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	
	public Dictionary getOpenBank() {
		return openBank;
	}

	public void setOpenBank(Dictionary openBank) {
		this.openBank = openBank;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
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

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
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
