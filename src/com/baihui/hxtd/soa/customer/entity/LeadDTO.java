package com.baihui.hxtd.soa.customer.entity;

import java.util.Date;
import java.util.List;


import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;

/**
 * 线索实体类
 * 功能描述：
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author luoxiao.li
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.customer.entity.Lead.java
 * @version (版本) 
 * @date 2014-7-10 09:53:25
 * @modify (新建)
 *  
 *  
 * 
 */
public class LeadDTO {

	public LeadDTO(){}
	public LeadDTO(User owner,String name, String company,String department, String position, String mobile, 
			String phone, String email, String fax, Dictionary source, Dictionary status, Dictionary cardType,
			 String cardNum, Dictionary industry, PCAS province, PCAS city, PCAS county, String postCode,
			 String address, String remark,int excelRowNum, Date createdTime){
		this.owner = owner;//0
		this.name = name;//1
		this.company = company;//2
		this.department = department;//3
		this.position = position;//4
		this.mobile = mobile;//5
		this.phone = phone;//6
		this.email = email;//7
		this.fax = fax;//8
		this.source = source;//9
		this.status = status;//10
		this.cardType = cardType;//11
		this.cardNum = cardNum;//12
		this.industry = industry;//13
		this.province = province;//14
		this.city = city;//15
		this.county = county;//16
		this.postCode = postCode;//17
		this.address = address;//18
		this.remark = remark;//19
		this.excelRowNum = excelRowNum;//20
		this.createdTime = createdTime;//21
		
	} 
	
	public static LeadDTO createEntity(List<Object> list){
		return new LeadDTO((User)list.get(0), (String)list.get(1), (String)list.get(2), 
				(String)list.get(3), (String)list.get(4), (String)list.get(5), (String)list.get(6), 
				(String)list.get(7),(String)list.get(8), (Dictionary)list.get(9),(Dictionary) list.get(10), 
				(Dictionary)list.get(11), (String)list.get(12), (Dictionary)list.get(13), (PCAS)list.get(14), (PCAS)list.get(15),
				(PCAS)list.get(16), (String)list.get(17), (String)list.get(18), (String)list.get(19), (Integer)list.get(20), new Date());
	}
	/**
	 * 序列化
	 */
	private static final long serialVersionUID = 1L;

	/** 线索ID */
	private Long id;

	/** 线索所有者 */
	private User owner;

	/** 公司名称 */
	private String company;

	/** 姓名 */
	private String name;

	/** 部门 */
	private String department;

	/** 职位 */
	private String position;

	/** 邮箱 */
	private String email;

	/** 电话 */
	private String phone;

	/** 传真 */
	private String fax;

	/** 手机 */
	private String mobile;

	/** 线索来源 */
	private Dictionary source;

	/** 线索状态 */
	private Dictionary status;

	/** 证件类型 */
	private Dictionary cardType;

	/** 证件号码 */
	private String cardNum;

	/** 行业 */
	private Dictionary industry;

	/** 邮编 */
	private String postCode;
	/**
	 * 省
	 */
	private PCAS province;
	/**
	 * 市
	 */
	private PCAS city;
	/**
	 * 区/县
	 */
	private PCAS county;
	/** 详细地址 */
	private String address;

	/** 备注 */
	private String remark;

	/** 创建者 */
	private User creator;

	/** 创建时间 */
	private Date createdTime;

	/** 修改者 */
	private User modifier;

	/** 最终修改时间 */
	private Date modifiedTime;

	/**标记是否删除*/
	private Boolean isDeleted = false;
	
	/*** 记录在excel中行数 */
    private int excelRowNum;

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
	public int getExcelRowNum() {
		return excelRowNum;
	}
	public void setExcelRowNum(int excelRowNum) {
		this.excelRowNum = excelRowNum;
	}

}
