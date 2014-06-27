package com.baihui.hxtd.soa.system.entity;


import com.baihui.hxtd.soa.common.entity.Initialized;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "SM_FUNCTION")
@SuppressWarnings("serial")
public class Function implements Serializable, Cloneable, Comparable<Function>, Initialized {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "CODE", length = 32, nullable = false)
    private String code;

    @Column(name = "NAME", length = 32, nullable = false, unique = true)
    private String name;

    @Column(name = "URL", length = 64)
    private String url;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PRIVILEGE_LEVEL_ID")
    private Dictionary privilegeLevel;

    @Column(name = "REMARK", length = 512)
    private String remark;

    @Column(name = "IS_INITIALIZED", nullable = false, updatable = false)
    private Boolean isInitialized;

    //@JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MENU_ID")
    private Menu menu;

    @JsonBackReference
    @ManyToMany(mappedBy = "functions")
    private Set<User> owners = new HashSet<User>();

    @JsonBackReference
    @ManyToMany(mappedBy = "functions")
    private Set<Role> roles = new HashSet<Role>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createdTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME", nullable = false)
    private Date modifiedTime;

    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted = false;

    @JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_ID")
    private Function parent;

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Function() {
    }

    public Function(Long id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object obj) {
        return obj == null ? false : (((Function) obj).getId().equals(getId()));
    }

    @Override
    public int hashCode() {
        return id == null ? super.hashCode() : id.hashCode();
    }

    @Override
    public Function clone() {
        try {
            return (Function) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new RuntimeException("未知的异常", e);
        }
    }

    @Override
    public int compareTo(Function o) {
        return Integer.parseInt(getCode()) - Integer.parseInt(o.getCode());
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

    public Set<User> getOwners() {
        return owners;
    }

    public void setOwners(Set<User> owners) {
        this.owners = owners;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
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

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public Function getParent() {
        return parent;
    }

    public void setParent(Function parent) {
        this.parent = parent;
    }


}
