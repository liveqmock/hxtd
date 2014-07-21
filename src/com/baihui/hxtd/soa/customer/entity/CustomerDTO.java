package com.baihui.hxtd.soa.customer.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

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
public class CustomerDTO implements Serializable {

	/** 构造函数 */
	public CustomerDTO() {}
	
	public CustomerDTO(User owner,String name, String company, String phone, String mobile, 
			String email, String fax, Dictionary source, Dictionary industry, Dictionary type,
			Dictionary riskGrade, Dictionary cardType, String cardNum, String dept,String job,
			String postCode, Dictionary ownerShip, Dictionary openBank, String bankName, String bankAccount,
			PCAS province, PCAS city, PCAS county, String address, String contributionType, 
			String contributionScale, String appointment, String financialAdvisor, String financialManager,
			String financialDirector, String remark,int excelRowNum){
		this.owner = owner;//0
		this.name = name;//1
		this.company = company;//2
		this.phone = phone;//3
		this.mobile = mobile;//4
		this.email = email;//5
		this.fax = fax;//6
		this.source = source;//7
		this.industry = industry;//8
		this.type = type;//9
		this.riskGrade = riskGrade;//10
		this.cardType = cardType;//11
		this.cardNum = cardNum;//12
		this.dept = dept;//13
		this.job = job;//14
		this.postCode = postCode;//15
		this.ownerShip = ownerShip;//16
		this.openBank = openBank;//17
		this.bankName = bankName;//18
		this.bankAccount = bankAccount;//19
		this.province = province;//20
		this.city = city;//21
		this.county = county;//22
		this.address = address;//23
		this.contributionType = contributionType;//24
		this.contributionScale = contributionScale;//25
		this.appointment = appointment;//26
		this.financialAdvisor = financialAdvisor;//27
		this.financialManager = financialManager;//28
		this.financialDirector = financialDirector;//29
		this.remark = remark;//30
		this.excelRowNum = excelRowNum;//31
		
	} 
	
	public static CustomerDTO createEntity(List<Object> list){
		return new CustomerDTO((User)list.get(0), (String)list.get(1), (String)list.get(2), 
				(String)list.get(3), (String)list.get(4), (String)list.get(5), (String)list.get(6), 
				(Dictionary)list.get(7), (Dictionary)list.get(8),(Dictionary) list.get(9), 
				(Dictionary)list.get(10), (Dictionary)list.get(11), 
				(String)list.get(12), (String)list.get(13), (String)list.get(14),(String)list.get(15),
				(Dictionary)list.get(16), (Dictionary)list.get(17), 
				(String)list.get(18),(String)list.get(19),
				
				(PCAS)list.get(20), (PCAS)list.get(21), (PCAS)list.get(22),
				(String)list.get(23), (String)list.get(24), (String)list.get(25),
				(String)list.get(26), (String)list.get(27), (String)list.get(28),(String)list.get(29),
				(String)list.get(30), (Integer)list.get(31));
	}

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
	@JoinColumn(name = "TYPE_DIC")
	private Dictionary type;

	/** 客户来源 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SOURCE_DIC")
	private Dictionary source;

	/** 风险等级 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "RISK_GRADE_DIC")
	private Dictionary riskGrade;

	/** 证件类型 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CARD_TYPE_DIC")
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
	@JoinColumn(name = "OPEN_BANK_DIC")
	private Dictionary openBank;

	/** 银行户名 */
	@Column(name = "BANK_NAME")
	private String bankName;

	/** 银行账号 */
	@Column(name = "BANK_ACCOUNT")
	private String bankAccount;

	/** 所有权 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNERSHIP_DIC")
	private Dictionary ownerShip;

	/** 客户所在行业 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INDUSTRY_DIC")
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
	@Column(name = "MODIFIED_TIME",updatable=false, insertable=false)
	private Date modifiedTime;

	/**
	 * 邮箱
	 */
	@Column(name = "EMAIL")
	private String email;
	
	
	/**
	 * 出资方式
	 */
	@Column(name = "CONTRIBUTION_TYPE")
	private String contributionType;
	

	/**
	 * 出资规模
	 */
	@Column(name = "CONTRIBUTION_SCALE")
	private String contributionScale;
	
	/**
	 * 家庭住址
	 */
	@Column(name = "FAMILY_ADDR")
	private String familyAddr;
	
	/**
	 * 理财顾问
	 */
	@Column(name = "FINANCIAL_ADVISOR")
	private String financialAdvisor;
	
	/**
	 * 理财经理
	 */
	@Column(name = "FINANCIAL_MANAGER")
	private String financialManager;
	
	/**
	 * 邀约人
	 */
	@Column(name = "APPOINTMENT")
	private String appointment;

	/**
	 * 理财总监
	 */
	@Column(name = "FINANCIAL_DIRECTOR")
	private String financialDirector;

	/**
	 * 所在部门
	 */
	@Column(name = "DEPT")
	private String dept;
	
	/**
	 * 职务名称
	 */
	@Column(name = "JOB")
	private String job;
	
	@Column(name = "IS_DELETED",updatable=false)
	private Boolean isDeleted;

	/*** 记录在excel中行数 */
    private int excelRowNum;
	
	
	
	
	
	
	
	
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	public String getContributionType() {
		return contributionType;
	}

	public void setContributionType(String contributionType) {
		this.contributionType = contributionType;
	}

	public String getContributionScale() {
		return contributionScale;
	}

	public void setContributionScale(String contributionScale) {
		this.contributionScale = contributionScale;
	}

	public String getFamilyAddr() {
		return familyAddr;
	}

	public void setFamilyAddr(String familyAddr) {
		this.familyAddr = familyAddr;
	}

	public String getFinancialAdvisor() {
		return financialAdvisor;
	}

	public void setFinancialAdvisor(String financialAdvisor) {
		this.financialAdvisor = financialAdvisor;
	}

	public String getFinancialManager() {
		return financialManager;
	}

	public void setFinancialManager(String financialManager) {
		this.financialManager = financialManager;
	}

	public String getAppointment() {
		return appointment;
	}

	public void setAppointment(String appointment) {
		this.appointment = appointment;
	}

	public String getFinancialDirector() {
		return financialDirector;
	}

	public void setFinancialDirector(String financialDirector) {
		this.financialDirector = financialDirector;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public Boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public int getExcelRowNum() {
		return excelRowNum;
	}

	public void setExcelRowNum(int excelRowNum) {
		this.excelRowNum = excelRowNum;
	}
	
	

	
}
