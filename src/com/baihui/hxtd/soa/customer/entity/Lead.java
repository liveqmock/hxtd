package com.baihui.hxtd.soa.customer.entity;

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
import com.baihui.hxtd.soa.market.entity.MarketActivity;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 线索实体类
 * 
 * @author luoxiaoli
 * @date 2014/5/12
 */


/**
 * 功能描述：
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.customer.entity.Lead.java
 * @version (版本) 
 * @date 2014-6-20 下午03:15:25
 * @modify (修改)
 *  
 *  
 * 
 */
@Entity
@Table(name = "LEAD")
public class Lead {

	public Lead(){}
	public Lead(User owner,String name){
		
	}
	/**
	 * 序列化
	 */
	private static final long serialVersionUID = 1L;

	/** 线索ID */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;

	/** 线索所有者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNER")
	private User owner;

	/** 公司名称 */
	@Column(name = "COMPANY")
	private String company;

	/** 姓名 */
	@Column(name = "NAME", length = 64, nullable = false)
	private String name;

	/** 部门 */
	@Column(name = "DEPARTMENT", length = 64)
	private String department;

	/** 职位 */
	@Column(name = "POSITION", length = 64)
	private String position;

	/** 邮箱 */
	@Column(name = "EMAIL", length = 64)
	private String email;

	/** 电话 */
	@Column(name = "PHONE", length = 32)
	private String phone;

	/** 传真 */
	@Column(name = "FAX", length = 32)
	private String fax;

	/** 手机 */
	@Column(name = "MOBILE", length = 32, nullable = false)
	private String mobile;

	/** 线索来源 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SOURCE")
	private Dictionary source;

	/** 线索状态 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "STATUS")
	private Dictionary status;

	/** 证件类型 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CARD_TYPE")
	private Dictionary cardType;

	/** 证件号码 */
	@Column(name = "CARD_NUM", length = 64)
	private String cardNum;

	/** 行业 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "INDUSTRY")
	private Dictionary industry;

	/** 邮编 */
	@Column(name = "POST_CODE", length = 16)
	private String postCode;
	/**
	 * 省
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PROVINCE",nullable = true)
	private PCAS province;
	/**
	 * 市
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CITY",nullable = true)
	private PCAS city;
	/**
	 * 区/县
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "COUNTY",nullable = true)
	private PCAS county;
	
	/**
	 * 关联市场活动
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MARKET_ACTIVITY_ID",nullable = true)
	private MarketActivity marketActivity;
	
	/** 详细地址 */
	@Column(name = "ADDRESS", length = 256)
	private String address;

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

	@Column(name = "IS_DELETED", nullable = false, updatable = false)
	private Boolean isDeleted = false;
	

	public Boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getCardNum() {
		return cardNum;
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
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

	public Dictionary getSource() {
		return source;
	}

	public void setSource(Dictionary source) {
		this.source = source;
	}

	public Dictionary getStatus() {
		return status;
	}

	public void setStatus(Dictionary status) {
		this.status = status;
	}

	public Dictionary getCardType() {
		return cardType;
	}

	public void setCardType(Dictionary cardType) {
		this.cardType = cardType;
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
	public MarketActivity getMarketActivity() {
		return marketActivity;
	}
	public void setMarketActivity(MarketActivity marketActivity) {
		this.marketActivity = marketActivity;
	}
}
