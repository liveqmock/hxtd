package com.baihui.hxtd.soa.project.entity;

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
import com.baihui.hxtd.soa.customer.entity.LeadDTO;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 
 * 功能描述：供应商实体类
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.customer.entity.Supplier.java
 * @version (版本)1 
 * @date 2014-5-16 下午02:57:10
 */
@Entity
@Table(name = "SUPPLIER")
public class SupplierDTO {
	
	public SupplierDTO(){}
	
	public SupplierDTO(String name, Dictionary type,User owner, String corporation, String phone, 
			String mobile, String email, String fax, Dictionary cardType, String cardNum, 
			PCAS province, PCAS city, PCAS county, String address, String remark,int excelRowNum){
		this.name = name;//0
		this.type = type;//1
		this.owner = owner;//2
		this.corporation = corporation;//3
		this.phone = phone;//4
		this.mobile = mobile;//5
		this.email = email;//6
		this.fax = fax;//7
		this.cardType = cardType;//8
		this.cardNum = cardNum;//9
		this.province = province;//10
		this.city = city;//11
		this.county = county;//12
		this.address = address;//13
		this.remark = remark;//14
		this.excelRowNum = excelRowNum;//15
		
	} 
	
	public static SupplierDTO createEntity(List<Object> list){
		return new SupplierDTO((String)list.get(0), (Dictionary)list.get(1), (User)list.get(2), 
				(String)list.get(3), (String)list.get(4), (String)list.get(5), (String)list.get(6), 
				(String)list.get(7),(Dictionary)list.get(8), (String)list.get(9),(PCAS) list.get(10), 
				(PCAS)list.get(11), (PCAS)list.get(12),(String)list.get(13), (String)list.get(14), (Integer)list.get(15));
	}
	
	/**
	 * 主键ID
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 供应商名称
	 */
	@Column(name = "NAME", length = 64, nullable = false)
	private String name;
	/**
	 * 供应商类型
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "TYPE")
	private Dictionary type;
	/** 
	 * 供应商所有者 
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNER")
	private User owner;
	/**
	 * 法人
	 */
	@Column(name = "CORPORATION")
	private String corporation;
	/**
	 * 证件号码
	 */
	@Column(name = "CARD_NUM")
	private String cardNum;
	/**
	 * 证件类型
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CARD_TYPE")
	private Dictionary cardType;
	
	/**
	 * 电话
	 */
	@Column(name = "PHONE")
	private String phone;
	/**
	 * 手机
	 */
	@Column(name = "MOBILE")
	private String mobile;
	/**
	 * 传真
	 */
	@Column(name = "FAX")
	private String fax;
	/**
	 * 省
	 */
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
	/**
	 * 详细地址
	 */
	@Column(name = "ADDRESS")
	private String address;
	/**
	 * 邮箱
	 */
	@Column(name = "EMAIL")
	private String email;
	/**
	 * 备注
	 */
	@Column(name = "REMARK", length = 512)
	private String remark;
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
	@Column(name = "CREATED_TIME")
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
	@Column(name = "MODIFIED_TIME", nullable = false)
	private Date modifiedTime;
	
	@Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted = false;
	
	/*** 记录在excel中行数 */
    private int excelRowNum;

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

	public int getExcelRowNum() {
		return excelRowNum;
	}

	public void setExcelRowNum(int excelRowNum) {
		this.excelRowNum = excelRowNum;
	}

	

}
