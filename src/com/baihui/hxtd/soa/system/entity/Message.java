package com.baihui.hxtd.soa.system.entity;

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

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 系统消息实体类
 * @author huizijing
 * 2016/6/4
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "sm_message")
public class Message implements Serializable{

	/**
	 * 消息ID
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	
	/**
	 * 提醒标题
	 */
	@Column(name="TITLE")
	private String title;
	
	/**
	 * 提醒内容
	 */
	@Column(name="CONTENT")
	private String content;
	
	/**
	 * 创建者
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="CREATOR_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private User creator;
	
	/**
	 * 创建时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name="CREATED_TIME")
	private Date createdTime;
	
	/**
	 * 修改者
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="MODIFIER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private User modifier;
	
	/**
	 * 最终修改时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
	private Date modifiedTime;
    
	@Column(name = "IS_DELETED", nullable = false)
	private Boolean isDeleted;
	
	/**
	 * 构造函数
	 */
	public Message() {
		super();
	}

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
