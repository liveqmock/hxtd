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
@Table(name = "SM_ROLE")
@SuppressWarnings("serial")
public class Role implements Serializable, Comparable<Role>, Initialized {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "CODE", length = 32, updatable = false, unique = true)
    private String code;

    @Column(name = "NAME", length = 255, unique = true)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TYPE")
    private Dictionary type;

    @Column(name = "REMARK", length = 255)
    private String remark;

    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted;

    @Column(name = "IS_INITIALIZED", nullable = false, updatable = false)
    private Boolean isInitialized;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", nullable = false, updatable = false)
    private User creator;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createdTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME")
    private Date modifiedTime;

    @JsonManagedReference
    @ManyToMany
    @JoinTable(name = "SM_ROLE_FUNC", joinColumns = {@JoinColumn(name = "ROLE_ID")}, inverseJoinColumns = {@JoinColumn(name = "FUNC_ID")})
    private Set<Function> functions = new HashSet<Function>();

    @JsonManagedReference
    @ManyToMany
    @JoinTable(name = "SM_ROLE_COM", joinColumns = {@JoinColumn(name = "ROLE_ID")}, inverseJoinColumns = {@JoinColumn(name = "COM_ID")})
    private Set<Component> components = new HashSet<Component>();

    @JsonManagedReference
    @ManyToMany
    @JoinTable(name = "SM_ORG_ROLE", joinColumns = {@JoinColumn(name = "ROLE_ID")}, inverseJoinColumns = {@JoinColumn(name = "ORG_ID")})
    private Set<Organization> organizations = new HashSet<Organization>();

    @JsonBackReference
    @ManyToMany(mappedBy = "roles")
    private Set<User> owners = new HashSet<User>();

    public Role() {
    }

    public Role(Long id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object obj) {
        return obj == null ? false : (getId().equals(((Role) obj).getId()));
    }

    @Override
    public int hashCode() {
        return id == null ? super.hashCode() : id.hashCode();
    }

    @Override
    public int compareTo(Role o) {
        return (int) (getId() - o.getId());
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Set<Organization> getOrganizations() {
        return organizations;
    }

    public void setOrganizations(Set<Organization> organizations) {
        this.organizations = organizations;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Dictionary getType() {
        return type;
    }

    public void setType(Dictionary type) {
        this.type = type;
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

    public Set<Component> getComponents() {
        return components;
    }

    public void setComponents(Set<Component> components) {
        this.components = components;
    }

    public Set<Function> getFunctions() {
        return functions;
    }

    public void setFunctions(Set<Function> functions) {
        this.functions = functions;
    }

    public Set<User> getOwners() {
        return owners;
    }

    public void setOwners(Set<User> owners) {
        this.owners = owners;
    }
}
