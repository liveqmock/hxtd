package com.baihui.hxtd.soa.system.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

/**
 * 字典实体类
 *
 * @author xiayouxue
 * @date 2014/5/6
 */
@Entity
@Table(name = "SM_DICTIONARY")
@SuppressWarnings("serial")
public class Dictionary implements Serializable {
	
	public Dictionary(){}

    public Dictionary(Long id){
        this.id = id;
    }

	public Dictionary(String value) {
        this.value = value;
    }

    @Override
    public boolean equals(Object obj) {
        return obj == null ? false : (getValue().equals(((Dictionary) obj).getValue()));
    }

    @Override
    public int hashCode() {
        return getValue().hashCode();
    }

	/**主键ID*/
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    /**字典名称*/
    @Column(name = "`KEY`")
    private String key;

    /**字典值*/
    @Column(name = "`VALUE`")
    private String value;

    /**深度*/
    @Column(name = "LEVEL")
    private Long level;

    /**顺序*/
    @Column(name = "`ORDER`")
    private Long order;

    /**字典类型编码*/
    @Column(name = "TYPE")
    private String type;

    /**是否启用 默认为1：启用*/
    @Column(name = "IS_ACTIVE")
    private Long isActive;

	/**备注*/
    @Column(name = "REMARK", length = 512)
    private String remark;
    
    /**删除标记*/
	@Column(name = "IS_DELETED")
	private Boolean isDeleted = false;

    /**创建者*/
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    /**创建时间*/
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
    @Column(name = "CREATED_TIME", updatable = false)
    private Date createdTime;

    /**修改者*/
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    /**修改时间*/
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME")
    private Date modifiedTime;

    /**父级字典*/
    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_ID")
    private Dictionary parent;

    /**子级字典*/
    @JsonManagedReference
    @OneToMany(mappedBy = "parent", cascade = CascadeType.REMOVE)
    private Set<Dictionary> children = new HashSet<Dictionary>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Long getLevel() {
		return level;
	}

	public void setLevel(Long level) {
		this.level = level;
	}

	public Long getOrder() {
		return order;
	}

	public void setOrder(Long order) {
		this.order = order;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

    public Long getIsActive() {
		return isActive;
	}

	public void setIsActive(Long isActive) {
		this.isActive = isActive;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public Boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
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

	public void setCreatedTime(Date createTime) {
		this.createdTime = createTime;
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

	public Dictionary getParent() {
		return parent;
	}

	public void setParent(Dictionary parent) {
		this.parent = parent;
	}

	public Set<Dictionary> getChildren() {
		return children;
	}

	public void setChildren(Set<Dictionary> children) {
		this.children = children;
	}
}
