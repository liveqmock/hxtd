package com.baihui.hxtd.soa.system.entity;

import java.util.Date;
/**
 * 功能描述：
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.setting.entity.AuditLog.java
 * @version (版本) 
 * @date 2014-6-22 18:00:25
 * @create (创建)
 *  
 *  
 * 
 */

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

@Entity
@Table(name = "SM_AUDIT_LOG")
public class AuditLog {
	
	/** 审计日志id */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	
	/** 操作模块的名称 */
	@Column(name = "MODULE_NAME")
	private String moduleName;
	
	/** 操作记录的id */
	@Column(name = "RECORD_ID")
	private Long recordId;
	
	/** 操作记录的名称 */
	@Column(name = "RECORD_NAME")
	private String recordName;
	
	/** 执行操作的类型 */
	@JoinColumn(name = "TYPE")
	private Integer type;
	/** 备注（如：系统清空回收站） */
	@JoinColumn(name = "REMARK")
	private String remark;
	
	/** 操作者 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CREATOR_ID", updatable = false)
	@NotFound(action = NotFoundAction.IGNORE)
	private User creator;

	/** 操作时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME", insertable = false, updatable=false)
	private Date createdTime;
	
	
	public AuditLog(){
		
	}

    public AuditLog(String moduleName,String recordName, Integer type, User creator) {
        this.moduleName = moduleName;
        this.recordName = recordName;
        this.type = type;
        this.creator = creator;
    }
	
	public AuditLog(String moduleName, Long recordId, String recordName, Integer type, User creator) {
		super();
		this.moduleName = moduleName;
		this.recordId = recordId;
		this.recordName = recordName;
		this.type = type;
		this.creator = creator;
	}
	
	public AuditLog(String moduleName, Long recordId, String recordName, Integer type, User creator, String remark) {
		super();
		this.moduleName = moduleName;
		this.recordId = recordId;
		this.recordName = recordName;
		this.type = type;
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
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
