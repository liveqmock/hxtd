/**
 * @Title: ImportLog.java
 * @Package com.baihui.feiluocrm.entity
 * Copyright: Copyright (c) 2014 
 * Company:北京百会纵横科技有限公司
 * 
 * @author xiaolong.chen
 * @date 2014-1-14 上午11:04:48
 * @version V1.0
 */

package com.baihui.hxtd.soa.common.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;


/** 
* 
* 功能描述：导入日志
* @ClassName:  com.baihui.hxtd.soa.common.entity.ImportLog.java
* @author xiaoli.luo 
* @company 北京市百会纵横科技有限公司
* @copyright  本文件归属  北京市百会纵横科技有限公司 
* @since (该版本支持的 JDK 版本)  ：  1.6 
* @version (版本) 
* @date  2014-7-8 17:04:48
* @creator (创建)
*  
*/

@Entity
@Table(name="IMPORT_LOG")
public class ImportLog implements Serializable
{
    
    /** 系列化ID */
    private static final long serialVersionUID = 5959113031823719380L;

    /**导入日志ID */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
    private int id;

    /**导入数据开始时间*/
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "START_TIME")
    private Date startTime;

    /**导入数据结束时间*/
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "END_TIME")
    private Date endTime;

    /**导入状态：0 正在导入 1 导入结束 默认为0 */
    @Column(name = "STATUS")
    private Long status;

    /**创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "CREATED_TIME")
    private Date createdTime;

    /**修改时间*/
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@Column(name = "MODIFIED_TIME", nullable = false)
    private Date modifiedTime;
    
    /**导入的描述*/
    @Column(name="DESCRIBE" )
    private String Description;

    
    
    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

	public Long getStatus() {
		return status;
	}

	public void setStatus(Long status) {
		this.status = status;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}



}
