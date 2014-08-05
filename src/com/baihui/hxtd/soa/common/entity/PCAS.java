
package com.baihui.hxtd.soa.common.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.baihui.hxtd.soa.base.FieldInfo;

/**
 * 
 * 功能描述： 省市县三级联动实体类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.entity.PCAS.java
 * @version (版本)1 
 * @date 2014-5-30 下午01:35:53
 */
@Entity
@Table(name = "PRO_CITY_AREA")
public class PCAS {
	
	/**
	 * 主键ID
	 */
	@FieldInfo(desc = "主键ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	/**
	 * 显示名称
	 */
	@FieldInfo(desc = "显示名称")
	@Column(name = "NAME")
	private String name;
	/**
	 * 父级ID
	 */
	@FieldInfo(desc = "父级ID")
	@Column(name = "PID")
	private Long pid;
	
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	
}
