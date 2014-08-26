
package com.baihui.hxtd.soa.common.entity;

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

import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 
 * 功能描述：联系纪要实体类
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.common.entity.Memoir.java
 * @version (版本)1 
 * @date 2014-5-26 上午09:47:36
 */
@Entity
@Table(name = "MEMOIR")
@DynamicInsert(true)
@SuppressWarnings("serial")
public class Memoir implements Serializable {
	
	public Memoir(){}
	
	/**
	 * 主键ID
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 关联模块ID
	 */
	@Column(name = "RECORD_ID")
	private Long moduleId;
	/**
	 * 模块类型
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODULE_ID")
	private Dictionary type;
	/**
	 * 所处机构
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ORG_ID")
	private Organization org;
	/**
	 * 沟通者
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "USER_ID")
	private User employee;
	/**
	 * 沟通纪要
	 */
	@Column(name = "SUMMARY")
	private String summary;
	/**
	 * 下次联系时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@Column(name = "NEXTCONTACTTIME")
	private Date nextContactTime;
	/**
	 * 下次联系要点
	 */
	@Column(name = "NEXTCONTACTPOINTS")
	private String nextContactPoints;
	/**
	 * 备注
	 */
	@Column(name = "REMARK")
	private String remark;
	/**
	 * 删除标记
	 */
	@Column(name = "IS_DELETED")
	private Boolean isDeleted = false;
	/**
	 * 参与沟通用户
	 
	@ManyToMany
    @JoinTable(name = "Memoir_User", joinColumns = {@JoinColumn(name = "MEMOIR_ID")}, inverseJoinColumns = {@JoinColumn(name = "USER_ID")})
    private Set<User> memoirUser = new HashSet<User>();
    */
	
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
	@Column(name = "CREATED_TIME", updatable = false)
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
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
	private Date modifiedTime;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getModuleId() {
		return moduleId;
	}
	public void setModuleId(Long moduleId) {
		this.moduleId = moduleId;
	}
	public Dictionary getType() {
		return type;
	}
	public void setType(Dictionary type) {
		this.type = type;
	}
	public Organization getOrg() {
		return org;
	}
	public void setOrg(Organization org) {
		this.org = org;
	}
	public User getEmployee() {
		return employee;
	}
	public void setEmployee(User employee) {
		this.employee = employee;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public Date getNextContactTime() {
		return nextContactTime;
	}
	public void setNextContactTime(Date nextContactTime) {
		this.nextContactTime = nextContactTime;
	}
	public String getNextContactPoints() {
		return nextContactPoints;
	}
	public void setNextContactPoints(String nextContactPoints) {
		this.nextContactPoints = nextContactPoints;
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
	/**public Set<User> getMemoirUser() {
		return memoirUser;
	}
	public void setMemoirUser(Set<User> memoirUser) {
		this.memoirUser = memoirUser;
	}*/
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
