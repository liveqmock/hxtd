package com.baihui.hxtd.soa.system.entity;


import com.baihui.hxtd.soa.common.entity.Orderable;
import com.baihui.hxtd.soa.common.entity.TreeNode;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 菜单实体类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Entity
@Table(name = "SM_MENU")
@SuppressWarnings("serial")
public class Menu implements Serializable, Cloneable, TreeNode<Menu> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "CODE", length = 32, nullable = false)
    private String code;

    @Column(name = "NAME", length = 32, nullable = false, unique = true)
    private String name;

    @Column(name = "URL", length = 32)
    private String url;

    @Column(name = "LEVEL", nullable = false)
    private Integer level;

    @Column(name = "IS_LEAF", nullable = false)
    private Boolean isLeaf;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SHOW_LOCATION_ID")
    private Dictionary showLocation;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "OPEN_TYPE")
    private Dictionary openType;

    @Column(name = "REMARK", length = 512, nullable = false)
    private String remark;

    @Column(name = "`ORDER`", nullable = false, unique = true)
    private Long order;

    @Column(name = "IS_ACTIVE", nullable = false)
    private Boolean isActive;

    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    @Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    @Column(name = "MODIFIED_TIME", nullable = false)
    private Date modifiedTime;

    @JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_MENU_ID")
    private Menu parent;

    @JsonBackReference
    @OneToMany(mappedBy = "parent", cascade = CascadeType.REMOVE)
    private List<Menu> children = new ArrayList<Menu>();

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TRIGGER_ID")
    private Function trigger;

    @JsonManagedReference
    @OneToMany(mappedBy = "menu")
    private List<Function> functions = new ArrayList<Function>();

    public Menu() {
    }

    public Menu(Long id) {
        this.id = id;
    }


    @Override
    public int compareTo(Orderable orderable) {
        return (int) (getOrder() - orderable.getOrder());
    }

    @Override
    public boolean equals(Object obj) {
        return obj == null ? false : (getId().equals(((Menu) obj).getId()));
    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }

    @Override
    public Menu clone() throws CloneNotSupportedException {
        return (Menu) super.clone();
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

    public Dictionary getShowLocation() {
        return showLocation;
    }

    public void setShowLocation(Dictionary showLocation) {
        this.showLocation = showLocation;
    }

    public Dictionary getOpenType() {
        return openType;
    }

    public void setOpenType(Dictionary openType) {
        this.openType = openType;
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

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
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

    public Menu getParent() {
        return parent;
    }

    public void setParent(Menu parent) {
        this.parent = parent;
    }

    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

    public Function getTrigger() {
        return trigger;
    }

    public void setTrigger(Function trigger) {
        this.trigger = trigger;
    }

    public List<Function> getFunctions() {
        return functions;
    }

    public void setFunctions(List<Function> functions) {
        this.functions = functions;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
}
