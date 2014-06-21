package com.baihui.hxtd.soa.system.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户实体类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Entity
@Table(name = "SM_USER")
@SuppressWarnings("serial")
public class User implements Serializable, Cloneable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "CODE", length = 32, nullable = false)
    private String code;

    @Column(name = "LOGIN_NAME", length = 32, nullable = false, unique = true, updatable = false)
    private String name;

    @Column(name = "PASSWORD", length = 64, nullable = false, updatable = false)
    private String password;

    @Column(name = "IS_MANAGER")
    private Boolean isManager;

    @Column(name = "IS_ACTIVE", nullable = false, updatable = false)
    private Boolean isActive;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "STORE_STATUS")
    private Dictionary storeStatus;

    @Column(name = "USER_NAME", length = 32, nullable = false)
    private String realName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SEX_ID")
    private Dictionary sex;

    @Column(name = "PHONE", length = 32, nullable = false)
    private String phone;

    @Column(name = "MOBILE", length = 32, nullable = false)
    private String mobile;

    @Column(name = "EMAIL", length = 32, nullable = false)
    private String email;

    @Column(name = "QQ", length = 16, nullable = false)
    private String qq;

    @Column(name = "JOB_NAME", length = 64, nullable = false)
    private String jobName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "JOB_SITUATION")
    private Dictionary jobSituation;

    @Column(name = "REMARK", length = 512)
    private String remark;

    //TODO 暂时无用
    @Column(name = "`ORDER`")
    private Long order;

    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    @Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createTime;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    @Column(name = "MODIFIED_TIME")
    private Date modifiedTime;

    @JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ORGANIZATION_ID")
    private Organization organization;

    @JsonManagedReference
    @ManyToMany
    @JoinTable(name = "SM_USER_FUNC", joinColumns = {@JoinColumn(name = "USER_ID")}, inverseJoinColumns = {@JoinColumn(name = "FUNC_ID")})
    private Set<Function> functions = new HashSet<Function>();

    @JsonManagedReference
    @ManyToMany
    @JoinTable(name = "SM_USER_COM", joinColumns = {@JoinColumn(name = "USER_ID")}, inverseJoinColumns = {@JoinColumn(name = "COM_ID")})
    private Set<Component> components = new HashSet<Component>();

    @JsonManagedReference
    @ManyToMany
    @JoinTable(name = "SM_USER_ROLE", joinColumns = {@JoinColumn(name = "USER_ID")}, inverseJoinColumns = {@JoinColumn(name = "ROLE_ID")})
    private Set<Role> roles = new HashSet<Role>();


    public User() {
    }

    public User(Long id) {
        this.id = id;
    }

    @Override
    public User clone() throws CloneNotSupportedException {
        return (User) super.clone();
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getIsManager() {
        return isManager;
    }

    public void setIsManager(Boolean isManager) {
        this.isManager = isManager;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public Dictionary getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(Dictionary storeStatus) {
        this.storeStatus = storeStatus;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Dictionary getSex() {
        return sex;
    }

    public void setSex(Dictionary sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public Dictionary getJobSituation() {
        return jobSituation;
    }

    public void setJobSituation(Dictionary jobSituation) {
        this.jobSituation = jobSituation;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Long getOrder() {
        return order;
    }

    public void setOrder(Long order) {
        this.order = order;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
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

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public Set<Function> getFunctions() {
        return functions;
    }

    public void setFunctions(Set<Function> functions) {
        this.functions = functions;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Set<Component> getComponents() {
        return components;
    }

    public void setComponents(Set<Component> components) {
        this.components = components;
    }
}
