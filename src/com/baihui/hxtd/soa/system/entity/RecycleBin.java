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

/**
 * 功能描述：回收站表
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.setting.entity.Recyclebin.java
 * @version (版本) 
 * @date 2014-7-7 11:32:25
 * @create (创建)
 *  
 *  
 * 
 */
@Entity
@Table(name = "SM_RECYCLEBIN")
public class RecycleBin {
	
	/** 回收站id */
	@FieldInfo(desc = "主键ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	
	/** 操作模块的名称 */
	@FieldInfo(desc = "模块名称 ")
	@Column(name = "MODULE_NAME")
	private String moduleName;
	
	/** 操作记录的id */
	@FieldInfo(desc = "记录id")
	@Column(name = "RECORD_ID")
	private Long recordId;
	
	/** 操作记录的名称 */
	@FieldInfo(desc = "记录名称")
	@Column(name = "RECORD_NAME")
	private String recordName;
	
	/** 备注 */
	@FieldInfo(desc = "备注 ")
	@JoinColumn(name = "REMARK")
	private String remark;
	
	/** 操作者 */
	@FieldInfo(desc = "操作者")
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID", updatable = false)
	@NotFound(action = NotFoundAction.IGNORE)
	private User creator;

	/** 操作时间 */
	@FieldInfo(desc = "操作时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME", insertable = false, updatable=false)
	private Date createdTime;
	
	
	public RecycleBin(){
		
	}
	
	public RecycleBin(String moduleName, Long recordId, String recordName, User creator) {
		super();
		this.moduleName = moduleName;
		this.recordId = recordId;
		this.recordName = recordName;
		this.creator = creator;
	}
	
	public RecycleBin(String moduleName, Long recordId, String recordName, User creator, String remark) {
		super();
		this.moduleName = moduleName;
		this.recordId = recordId;
		this.recordName = recordName;
		this.creator = creator;
		this.remark = remark;
	}


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public Long getRecordId() {
		return recordId;
	}
	public void setRecordId(Long recordId) {
		this.recordId = recordId;
	}
	public String getRecordName() {
		return recordName;
	}
	public void setRecordName(String recordName) {
		this.recordName = recordName;
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

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRemark() {
		return remark;
	}
	
}
