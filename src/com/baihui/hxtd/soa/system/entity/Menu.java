package com.baihui.hxtd.soa.system.entity;


import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.common.entity.Initialized;
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
public class Menu implements Serializable, Cloneable, TreeNode<Menu>, Initialized {

    /**设置虚拟菜单，显示当前位置时，需要使用*/
    public final static Menu SETTING = new Menu();

    /**根虚拟菜单，在菜单列表页显示*/
    public final static Menu ROOT = new Menu();

    static {
        SETTING.setName("设置");
        SETTING.setUrl("/system/toViewPage.do");
        Function function = new Function();
        function.setUrl("/system/toViewPage.do");
        SETTING.setTrigger(function);

        ROOT.setId(0l);
        ROOT.setName("华兴控股");
        ROOT.setParent(null);
    }

    @FieldInfo(desc = "主键编号")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @FieldInfo(desc = "名称")
    @Column(name = "NAME", length = 32, nullable = false, unique = true)
    private String name;

    @FieldInfo(desc = "链接")
    @Column(name = "URL", length = 32)
    private String url;

    @FieldInfo(desc = "级别")
    @Column(name = "LEVEL", nullable = false)
    private Integer level;

    @FieldInfo(desc = "叶子节点")
    @Column(name = "IS_LEAF", nullable = false)
    private Boolean isLeaf;

    @FieldInfo(desc = "显示位置")
    @Column(name = "SHOW_LOCATION_TYPE")
    private Integer showLocationType;

    @FieldInfo(desc = "初始化的")
    @Column(name = "IS_INITIALIZED", nullable = false, updatable = false)
    private Boolean isInitialized;

    @FieldInfo(desc = "备注")
    @Column(name = "REMARK", length = 512)
    private String remark;

    @FieldInfo(desc = "序号")
    @Column(name = "`ORDER`", nullable = false, unique = true)
    private Long order;

    @FieldInfo(desc = "默认显示")
    @Column(name = "DEFAULT_SHOW", nullable = false)
    private Boolean defaultShow;

    @FieldInfo(desc = "启用")
    @Column(name = "IS_ACTIVE", nullable = false)
    private Boolean isActive;

    @FieldInfo(desc = "已被删除")
    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted;

    @FieldInfo(desc = "创建者")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    @FieldInfo(desc = "创建时间")
    @Column(name = "CREATED_TIME", nullable = false, updatable = false)
    private Date createdTime;

    @FieldInfo(desc = "修改者")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    @FieldInfo(desc = "修改时间")
    @Column(name = "MODIFIED_TIME", nullable = false, insertable = false, updatable = false)
    private Date modifiedTime;

    @FieldInfo(desc = "上级菜单")
    @JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_MENU_ID")
    private Menu parent;

    @FieldInfo(desc = "下级菜单")
    @JsonBackReference
    @OneToMany(mappedBy = "parent", cascade = CascadeType.REMOVE)
    private List<Menu> children = new ArrayList<Menu>();

    @FieldInfo(desc = "执行功能")
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TRIGGER_ID")
    private Function trigger;

    @FieldInfo(desc = "包含功能")
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

    public Boolean getDefaultShow() {
        return defaultShow;
    }

    public void setDefaultShow(Boolean defaultShow) {
        this.defaultShow = defaultShow;
    }

    public Boolean getIsInitialized() {
        return isInitialized;
    }

    public void setIsInitialized(Boolean isInitialized) {
        this.isInitialized = isInitialized;
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
    
    public Integer getShowLocationType() {
		return showLocationType;
	}

	public void setShowLocationType(Integer showLocationType) {
		this.showLocationType = showLocationType;
	}
}
