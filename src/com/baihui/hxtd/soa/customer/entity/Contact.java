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

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * @author xiayouxue
 * @date 2014-05-17
 */
@Entity
@Table(name = "CONTACT")
@DynamicInsert(true)
@SuppressWarnings("serial")
public class Contact implements Serializable {

	/** 构造函数 */
	public Contact() {
	}

	/** 联系人关联类型枚举 */
	public enum EnumContactType {
		Customer(0), Supplier(1);
		int value;

		EnumContactType(int value) {
			this.value = value;
		}
	}

	/** 联系人ID */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;

	/** 关联客户ID */
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ACCOUNT_ID")
	private Customer customer;
	
	/** 关联供应商ID */
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SUPPLIER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
    private Supplier supplier;

	/** 联系人所有者 */
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OWNER")
	@NotFound(action = NotFoundAction.IGNORE)
	private User owner;
		
	/** 线索来源 */
	@JoinColumn(name = "SOURCE")
	@ManyToOne(fetch = FetchType.LAZY)
	@NotFound(action = NotFoundAction.IGNORE)
	private Dictionary source;

	/** 联系人名称 */
	@Column(name = "NAME")
	private String name;

	/** 联系人所在部门 */
	@Column(name = "DEPARTMENT")
	private String department;

	/** 联系人职位 */
	@Column(name = "POSITION")
	private String position;

	/** 联系人电话号码(固定电话) */
	@Column(name = "PHONE")
	private String phone;

	/** 联系人手机号码 */
	@Column(name = "MOBILE")
	private String mobile;

	/** 联系人邮箱 */
	@Column(name = "EMAIL")
	private String email;

	/** 联系人传真 */
	@Column(name = "FAX")
	private String fax;

	/** 联系人邮编 */
	@Column(name = "POST_CODE")
	private String postCode;

	/** 联系人所在省 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PROVINCE")
	@NotFound(action = NotFoundAction.IGNORE)
	private PCAS province;

	/** 联系人所在市 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CITY")
	@NotFound(action = NotFoundAction.IGNORE)
	private PCAS city;

	/** 联系人县 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "COUNTY")
	@NotFound(action = NotFoundAction.IGNORE)
	private PCAS county;

	/** 联系人详细地址 */
	@Column(name = "ADDRESS")
	private String address;

	/** 备注 */
	@Column(name = "REMARK")
	private String remark;
	
	/**删除标记*/
	@Column(name = "IS_DELETED")
	private Boolean isDeleted = false;

	/** 创建者 */
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID", updatable = false)
	@NotFound(action = NotFoundAction.IGNORE)
	private User creator;

	/** 创建时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME", updatable = false)
	private Date createdTime;
	
	/** 最后修改者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODIFIER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private User modifier;

	/** 最后修改时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "MODIFIED_TIME")
	private Date modifiedTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public Dictionary getSource() {
		return source;
	}

	public void setSource(Dictionary source) {
		this.source = source;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
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
