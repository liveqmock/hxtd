package com.baihui.hxtd.soa.system.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 工作台实体类
 * @author ruisong.luan
 *
 */
@Entity
@Table(name = "SM_WORKBANCH")
public class Workbanch {
	/**
	 * 主键ID
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 *标题 
	 */
	@Column(name = "TITLE")
	private String title;
	/**
	 * 链接
	 */
	@Column(name = "URL")
	private String url;
	/**
	 * 模块
	 */
	@Column(name = "MODULE")
	private String module;
	/**
	 * 类型（列表/报表）
	 */
	@Column(name = "TYPE")
	private String type;
	/**
	 * 宽度
	 */
	@Column(name = "WIDTH")
	private String width;
	/**
	 * 参数
	 */
	@Column(name = "PARAMS")
	private String params;
	/**
	 * 所有者
	 */
	@Column(name = "OWNER_ID")
	private Long owner;
	/**
	 * 排序ID
	 */
	@Column(name = "ORDER_INDEX")
	private Long orderIndex;
	/**
	 * 删除标识
	 */
	@Column(name = "IS_DELETED")
	private Boolean isDeleted=false;
	
	@Column(name = "CREATED_TIME")
	private Date createdTime;
	
	@Column(name = "MODIFIED_TIME")
	private Date modifiedTime;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getModule() {
		return module;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
	}
	public Long getOwner() {
		return owner;
	}
	public void setOwner(Long owner) {
		this.owner = owner;
	}
	public Long getOrderIndex() {
		return orderIndex;
	}
	public void setOrderIndex(Long orderIndex) {
		this.orderIndex = orderIndex;
	}
	public Boolean getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
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
	
	
}
