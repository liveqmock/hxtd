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

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 
 * 功能描述：供应商实体类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.customer.entity.Supplier.java
 * @version (版本)1 
 * @date 2014-5-16 下午02:57:10
 */
@Entity
@Table(name = "SUPPLIER")
public class Supplier {
	
	public Supplier(){}
	/**
	 * 主键ID
	 */
	@FieldInfo(desc = "主键ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 供应商名称
	 */
	@FieldInfo(desc = "供应商名称")
	@Column(name = "NAME", length = 64, nullable = false)
	private String name;
	/**
	 * 供应商类型
	 */
	@FieldInfo(desc = "供应商类型")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "TYPE")
	private Dictionary type;
	/** 
	 * 供应商所有者 
	 */
	@FieldInfo(desc = "供应商所有者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNER")
	private User owner;
	/**
	 * 法人
	 */
	@FieldInfo(desc = "法人")
	@Column(name = "CORPORATION")
	private String corporation;
	/**
	 * 证件号码
	 */
	@FieldInfo(desc = "证件号码")
	@Column(name = "CARD_NUM")
	private String cardNum;
	/**
	 * 证件类型
	 */
	@FieldInfo(desc = "证件类型")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CARD_TYPE")
	private Dictionary cardType;
	/**
	 * 电话
	 */
	@FieldInfo(desc = "电话")
	@Column(name = "PHONE")
	private String phone;
	/**
	 * 手机
	 */
	@FieldInfo(desc = "手机")
	@Column(name = "MOBILE")
	private String mobile;
	/**
	 * 传真
	 */
	@FieldInfo(desc = "传真")
	@Column(name = "FAX")
	private String fax;
	/**
	 * 省
	 */
	@FieldInfo(desc = "省")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PROVINCE", nullable = true)
	@NotFound(action = NotFoundAction.IGNORE)
	private PCAS province;
	/**
	 * 市
	 */
	@FieldInfo(desc = "市")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CITY", nullable = true)
	@NotFound(action = NotFoundAction.IGNORE)
	private PCAS city;
	/**
	 * 区/县
	 */
	@FieldInfo(desc = "区/县")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "COUNTY", nullable = true)
	@NotFound(action = NotFoundAction.IGNORE)
	private PCAS county;
	/**
	 * 详细地址
	 */
	@FieldInfo(desc = "详细地址")
	@Column(name = "ADDRESS")
	private String address;
	/**
	 * 邮箱
	 */
	@FieldInfo(desc = "邮箱")
	@Column(name = "EMAIL")
	private String email;
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

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public String getCorporation() {
		return corporation;
	}

	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}

	public String getCardNum() {
		return cardNum;
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}

	public Dictionary getCardType() {
		return cardType;
	}

	public void setCardType(Dictionary cardType) {
		this.cardType = cardType;
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

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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
