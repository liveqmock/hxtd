package com.baihui.hxtd.soa.customer.entity;

import java.io.Serializable;
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

import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author lihua
 * @date 2014-05-17
 */
@Entity
@Table(name = "CUSTOMER")
@SuppressWarnings("serial")
public class Customer implements Serializable {

	/** 构造函数 */
	public Customer() {}

	/** 客户ID */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;

	/** 客户所有者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNER")
	private User owner;

	/** 客户名称 */
	@Column(name = "NAME")
	private String name;

	/** 客户类型 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "TYPE")
	private Dictionary type;

	/** 客户来源 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SOURCE")
	private Dictionary source;

	/** 风险等级 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "RISK_GRADE")
	private Dictionary riskGrade;

	/** 证件类型 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CARD_TYPE")
	private Dictionary cardType;

	/** 证件号码 */
	@Column(name = "CARD_NUM")
	private String cardNum;

	/** 电话(固定号码) */
	@Column(name = "PHONE")
	private String phone;

	/** 移动电话 */
	@Column(name = "MOBILE")
	private String mobile;

	/** 邮政编码 */
	@Column(name = "POST_CODE")
	private String postCode;

	/** 传真 */
	@Column(name = "FAX")
	private String fax;

	/** 公司名称 */
	@Column(name = "COMPANY")
	private String company;

	/** 开户行 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OPEN_BANK")
	private Dictionary openBank;

	/** 银行户名 */
	@Column(name = "BANK_NAME")
	private String bankName;

	/** 银行账号 */
	@Column(name = "BANK_ACCOUNT")
	private String bankAccount;

	/** 所有权 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNERSHIP")
	private Dictionary ownerShip;

	/** 客户所在行业 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INDUSTRY")
	private Dictionary industry;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PROVINCE")
	private PCAS province;
	/**
	 * 市
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CITY")
	private PCAS city;
	/**
	 * 区/县
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "COUNTY")
	private PCAS county;

	/** 客户所在地址 */
	@Column(name = "ADDRESS")
	private String address;

	/** 备注 */
	@Column(name = "REMARK")
	private String remark;

	/** 创建者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID",updatable=false)
	private User creator;

	/** 创建时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME",updatable=false)
	private Date createdTime;

	/** 最后修改者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODIFIER_ID")
	private User modifier;

	/** 最后修改时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "MODIFIED_TIME")
	private Date modifiedTime;

	/**
	 * 邮箱
	 */
	@Column(name = "EMAIL")
	private String email;
	
	
	/**
	 * 
	 */
	@Column(name = "IS_DELETED",updatable=false)
	private Boolean isDeleted;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Dictionary getType() {
		return type;
	}

	public void setType(Dictionary type) {
		this.type = type;
	}

	public Dictionary getSource() {
		return source;
	}

	public void setSource(Dictionary source) {
		this.source = source;
	}

	public Dictionary getRiskGrade() {
		return riskGrade;
	}

	public void setRiskGrade(Dictionary riskGrade) {
		this.riskGrade = riskGrade;
	}

	public Dictionary getCardType() {
		return cardType;
	}

	public void setCardType(Dictionary cardType) {
		this.cardType = cardType;
	}

	public String getCardNum() {
		return cardNum;
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
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


	public Dictionary getOwnerShip() {
		return ownerShip;
	}

	public void setOwnerShip(Dictionary ownerShip) {
		this.ownerShip = ownerShip;
	}

	public Dictionary getIndustry() {
		return industry;
	}

	public void setIndustry(Dictionary industry) {
		this.industry = industry;
	}

	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}




	public Boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public Date getModifiedTime() {
		return modifiedTime;
	}

	public void setModifiedTime(Date modifiedTime) {
		this.modifiedTime = modifiedTime;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public User getModifier() {
		return modifier;
	}

	public void setModifier(User modifier) {
		this.modifier = modifier;
	}

	public PCAS getProvince() {
		return province;
	}

	public void setProvince(PCAS province) {
		this.province = province;
	}

	public PCAS getCity() {
		return city;
	}

	public void setCity(PCAS city) {
		this.city = city;
	}

	public PCAS getCounty() {
		return county;
	}

	public void setCounty(PCAS county) {
		this.county = county;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	
}
