
package com.baihui.hxtd.soa.common.entity;

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

import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 
 * 功能描述：附件实体类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.entity.Attachment.java
 * @version (版本)1 
 * @date 2014-5-26 上午09:47:36
 */
@Entity
@Table(name = "ATTACHMENT")
public class Attachment {
	/**
	 * 主键ID
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 字典类型
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "DICTIONARY_ID")
	private Dictionary dict;
	/**
	 * 关联模块ID
	 */
	@Column(name = "MODULE_ID")
	private Long moduleId;
	/**
	 * 模块类型
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "TYPE")
	private Dictionary type;
	/**
	 * 文件原名
	 */
	@Column(name = "NAME")
	private String name;
	/**
	 * 存储地址
	 */
	@Column(name = "ADDRESS")
	private String address;
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
	
	/**
	 * 逻辑删除
	 */
	@Column(name = "IS_DELETED", nullable = false)
	private Boolean isDeleted = false;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Dictionary getDict() {
		return dict;
	}
	public void setDict(Dictionary dict) {
		this.dict = dict;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Boolean getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
	
	
	
}
