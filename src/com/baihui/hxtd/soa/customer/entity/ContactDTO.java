package com.baihui.hxtd.soa.customer.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.baihui.hxtd.soa.base.DBDateServiceInjecter;
import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;

/**
 * @author ruisong.luan
 * @date 2014-05-17
 */
public class ContactDTO implements Serializable {

	
	private static final long serialVersionUID = 1L;

	/** 构造函数 */
	public ContactDTO() {
	}

	/** 联系人关联类型枚举 */
	public enum EnumContactType {
		Customer(0), Supplier(1);
		int value;

		EnumContactType(int value) {
			this.value = value;
		}
	}

	public ContactDTO(List<Object> list) {
		this.owner = (User)list.get(0);// 0
		this.name = (String)list.get(1);// 1
		this.department = (String)list.get(2);// 2
		this.position = (String)list.get(3);// 3
		this.mobile = (String)list.get(4);// 4
		this.phone = (String)list.get(5);// 5
		this.email = (String)list.get(6);// 6
		this.fax = (String)list.get(7);// 7
		this.source = (Dictionary)list.get(8);// 8
		this.province = (PCAS)list.get(9);// 9
		this.city = (PCAS)list.get(10);// 10
		this.county = (PCAS)list.get(11);// 11
		this.postCode =(String)list.get(12);;// 12
		this.address = (String)list.get(13);;// 13
		this.remark = (String)list.get(14);;// 14
		this.excelRowNum = (Integer)list.get(15);// 15
	}

	public  static ContactDTO createEntity(List<Object> list){
			ContactDTO c = new ContactDTO(list);
			c.setCreatedTime(DBDateServiceInjecter.nowTime());
			return c;
	}
	
	/** 联系人ID */
	private Long id;

	/** 关联客户ID */
	private Customer customer;

	/** 关联供应商ID */
	private Supplier supplier;

	/** 联系人所有者 */
	private User owner;

	/** 线索来源 */
	private Dictionary source;

	/** 联系人名称 */
	private String name;

	/** 联系人所在部门 */
	private String department;

	/** 联系人职位 */
	private String position;

	/** 联系人电话号码(固定电话) */
	private String phone;

	/** 联系人手机号码 */
	private String mobile;

	/** 联系人邮箱 */
	private String email;

	/** 联系人传真 */
	private String fax;

	/** 联系人邮编 */
	private String postCode;

	/** 联系人所在省 */
	private PCAS province;

	/** 联系人所在市 */
	private PCAS city;

	/** 联系人县 */
	private PCAS county;

	/** 联系人详细地址 */
	private String address;

	/** 备注 */
	private String remark;

	/** 删除标记 */
	private Boolean isDeleted = false;

	/** 创建者 */
	private User creator;

	/** 创建时间 */
	private Date createdTime;

	/** 最后修改者 */
	private User modifier;

	/** 最后修改时间 */
	private Date modifiedTime;

	/** 在excel中的行号 */
	private int excelRowNum;

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

	public int getExcelRowNum() {
		return excelRowNum;
	}

	public void setExcelRowNum(int excelRowNum) {
		this.excelRowNum = excelRowNum;
	}
}
