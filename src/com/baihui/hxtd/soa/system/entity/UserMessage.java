package com.baihui.hxtd.soa.system.entity;

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
import com.fasterxml.jackson.annotation.JsonFormat;


@Entity
@Table(name="user_message")
public class UserMessage {

	/** 主键ID */
	@FieldInfo(desc = "主键ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	
	/** 消息实体 */
	@FieldInfo(desc = "消息实体")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MESSAGE_ID")
	private Message message;
	
	/** 接收者 */
	@FieldInfo(desc = "接收者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	private User user;

	/**
	 * 最终修改时间
	 */
	@FieldInfo(desc = "最终修改时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
	private Date modifiedTime;
	/**
	 * 消息读取状态
	 */
	@FieldInfo(desc = "读取状态")
	@Column(name="STATUS")
	private Boolean status;
	
	/**
	 * 删除标志 
	 */
	@FieldInfo(desc = "删除标志 ")
	@Column(name = "IS_DELETED",columnDefinition="INT default 0")
	private Boolean isDeleted;
	
	@FieldInfo(desc = "发送时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createdTime;
	
	/**
	 * 发送的信息为true
	 * 接收的信息为FALSE
	 */
	@FieldInfo(desc = "发送类型")
	@Column(name = "TYPE", nullable = false)
	private Boolean type;
	

	public Boolean getType() {
		return type;
	}

	public void setType(Boolean type) {
		this.type = type;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Message getMessage() {
		return message;
	}

	public void setMessage(Message message) {
		this.message = message;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
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
