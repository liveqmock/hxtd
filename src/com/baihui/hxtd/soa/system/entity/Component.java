package com.baihui.hxtd.soa.system.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.baihui.hxtd.soa.common.entity.Initialized;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 功能描述：组件表实体类
 *
 * @author ruisong.luan
 * @version (版本) 1.0
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.system.entity.Component.java
 * @date 2014-5-6 下午01:08:38
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Entity
@Table(name = "SM_COMPONENT")
@SuppressWarnings("serial")
public class Component implements Serializable, Comparable<Component>, Initialized {

    /**
     * 主键ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    /**
     * 组件编号
     */
    @Column(name = "CODE", length = 32, nullable = false, unique = true)
    private String code;

    /**
     * 组件名称
     */
    @Column(name = "NAME", length = 64, nullable = false)
    private String name;

    /**
     * 组件调用入口
     */
    @Column(name = "URL", length = 64, nullable = false)
    private String url;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PRIVILEGE_LEVEL_ID")
    private Dictionary privilegeLevel;

    /**
     * 备注
     */
    @Column(name = "REMARK", length = 512)
    private String remark;

    @Column(name = "IS_INITIALIZED", nullable = false, updatable = false)
    private Boolean isInitialized;

    /**
     * 创建者
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "CREATED_TIME")
    private Date createdTime;

    /**
     * 最后修改者
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    /**
     * 最后修改时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false)
    private Date modifiedTime;

    @JsonBackReference
    @ManyToMany(mappedBy = "components")
    private Set<User> owners = new HashSet<User>();

    @JsonBackReference
    @ManyToMany(mappedBy = "components")
    private Set<Role> roles = new HashSet<Role>();

    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted = false;

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Component() {
    }

    public Component(Long id) {
        this.id = id;
    }

    @Override
    public int compareTo(Component o) {
        return (int) (getId() - o.getId());
    }

    @Override
    public boolean equals(Object obj) {
        return obj == null ? false : (getId().equals(((Component) obj).getId()));
    }

    @Override
    public int hashCode() {
        return id == null ? super.hashCode() : id.hashCode();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Dictionary getPrivilegeLevel() {
        return privilegeLevel;
    }

    public void setPrivilegeLevel(Dictionary privilegeLevel) {
        this.privilegeLevel = privilegeLevel;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Boolean getIsInitialized() {
        return isInitialized;
    }

    public void setIsInitialized(Boolean isInitialized) {
        this.isInitialized = isInitialized;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Set<User> getOwners() {
        return owners;
    }

    public void setOwners(Set<User> owners) {
        this.owners = owners;
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


}
