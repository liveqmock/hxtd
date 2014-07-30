package com.baihui.hxtd.soa.system.entity;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
 * @author lihua
 * @date 2014-05-17
 */
@Entity
@Table(name = "sm_recyclebin")
@SuppressWarnings("serial")
public class RecyclebinDTO implements Serializable {

	/** 回收站id */
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
	
	/** 备注 */
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
	
	/*** 记录在excel中行数 */
    private int excelRowNum;
    
    
	/** 构造函数 */
	public RecyclebinDTO() {}
	
	public RecyclebinDTO(String moduleName, String recordName,long recordId,
			User creator, String remark ,int excelRowNum) {
		this.moduleName = moduleName;
		this.recordName = recordName;
		this.recordId = recordId;
		this.creator = creator;
		this.remark = remark;
		this.excelRowNum = excelRowNum;
	}



	public static  RecyclebinDTO createEntity(List<Object> list) throws ParseException{
		//DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		return new RecyclebinDTO((String)list.get(0), (String)list.get(1),Long.valueOf((String)list.get(2)), (User)list.get(3), 
				(String)list.get(4), (Integer)list.get(5));
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

	public int getExcelRowNum() {
		return excelRowNum;
	}

	public void setExcelRowNum(int excelRowNum) {
		this.excelRowNum = excelRowNum;
	}

	
	
}
