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
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 公告实体类
 *
 * @author huizijing
 * @date 2014/6/3
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "NOTICE")
public class Notice implements Serializable{

	/** 公告ID */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	
	@Column(name = "TITLE")
	private String title;
	
	@Column(name = "CONTENT")
	private String content;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "SENT_TIME")
	private Date sentTime;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID",updatable=false)
	@NotFound(action = NotFoundAction.IGNORE)
	private User creator;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME",updatable=false)
	private Date createdTime;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MODIFIER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private User modifier;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "MODIFIED_TIME",updatable=false, insertable=false)
	private Date modifiedTime;
   
	/**
	 * 过期时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "DEAD_TIME")
	private Date deadTime;
	
	@Column(name = "IS_DELETED", nullable = false)
	private Boolean isDeleted;
    
	public Notice() {
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

	public Date getSentTime() {
		return sentTime;
	}

	public void setSentTime(Date sentTime) {
		this.sentTime = sentTime;
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

	public Date getModifieTime() {
		return modifiedTime;
	}

	public void setModifieTime(Date modifieTime) {
		this.modifiedTime = modifieTime;
	}

	public Date getDeadTime() {
		return deadTime;
	}

	public void setDeadTime(Date deadTime) {
		this.deadTime = deadTime;
	}

	public Boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	
	
}
