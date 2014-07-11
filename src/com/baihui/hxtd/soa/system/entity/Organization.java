package com.baihui.hxtd.soa.system.entity;


import com.baihui.hxtd.soa.common.entity.Initialized;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

/**
 * 组织实体类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Entity
@Table(name = "SM_ORG")
@SuppressWarnings("serial")
public class Organization implements Serializable, Cloneable, Initialized {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "SHORT_NAME", length = 64)
    private String name;

    @Column(name = "FULL_NAME", length = 128)
    private String fullName;

    @Column(name = "LEVEL", nullable = false)
    private Integer level;

    @Column(name = "IS_LEAF", nullable = false)
    private Boolean isLeaf;

    @Column(name = "ADDRESS", length = 512)
    private String address;

    @Column(name = "ZIP_CODE", length = 32)
    private String zipCode;

    @Column(name = "PHONE", length = 32)
    private String phone;

    @Column(name = "EMAIL", length = 32)
    private String email;

    @Column(name = "WEB_SITE", length = 64)
    private String webSite;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TYPE", nullable = false)
    private Dictionary type;

    @Column(name = "`ORDER`")
    private Long order;

    @Column(name = "REMARK", length = 512)
    private String remark;

    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted;

    @Column(name = "IS_INITIALIZED", nullable = false, updatable = false)
    private Boolean isInitialized;

    @JsonBackReference
    @OneToMany(mappedBy = "organization", cascade = {CascadeType.REMOVE})
    private Set<User> owners = new HashSet<User>();

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    @Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createdTime;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    @Column(name = "MODIFIED_TIME", nullable = false)
    private Date modifiedTime;

    @JsonManagedReference
    @ManyToMany
    @JoinTable(name = "SM_ORG_ROLE", joinColumns = {@JoinColumn(name = "ORG_ID")}, inverseJoinColumns = {@JoinColumn(name = "ROLE_ID")})
    private Set<Role> roles = new HashSet<Role>();

    @JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_ORG_ID")
    private Organization parent;

    @JsonBackReference
    @OneToMany(mappedBy = "parent")
    private List<Organization> children = new ArrayList<Organization>();

    public Organization() {
    }

    public Organization(Long id) {
        this.id = id;
    }

    @Override
    public Organization clone() throws CloneNotSupportedException {
        return (Organization) super.clone();
    }

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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Boolean getIsLeaf() {
        return isLeaf;
    }

    public void setIsLeaf(Boolean isLeaf) {
        this.isLeaf = isLeaf;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWebSite() {
        return webSite;
    }

    public void setWebSite(String webSite) {
        this.webSite = webSite;
    }

    public Dictionary getType() {
        return type;
    }

    public void setType(Dictionary type) {
        this.type = type;
    }

    public Long getOrder() {
        return order;
    }

    public void setOrder(Long order) {
        this.order = order;
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

    public Boolean getIsInitialized() {
        return isInitialized;
    }

    public void setIsInitialized(Boolean isInitialized) {
        this.isInitialized = isInitialized;
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

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Organization getParent() {
        return parent;
    }

    public void setParent(Organization parent) {
        this.parent = parent;
    }

    public List<Organization> getChildren() {
        return children;
    }

    public void setChildren(List<Organization> children) {
        this.children = children;
    }
}
