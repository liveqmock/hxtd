package com.baihui.hxtd.soa.common.entity;

import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 功能描述：流程节点实体类
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.entity.WFNode.java
 * @date 2014-5-26 上午09:47:36
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Entity
@Table(name = "wf_node")
@SuppressWarnings("serial")
public class WFNode implements Serializable {

    /**
     * 主键ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    /**
     * 节点代码
     */
    @Column(name = "CODE")
    private String code;

    /**
     * 节点名称
     */
    @Column(name = "NAME")
    private String name;

    /**
     * 流程所属模块
     */
    @ManyToOne
    @JoinColumn(name = "MODULE_ID")
    private Module module;

    /** 执行流程的角色 */
    @ManyToOne
    @JoinColumn(name = "ROLE_ID")
    private Role role;

    @Transient
    private List<User> approvers = new ArrayList<User>();

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

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public List<User> getApprovers() {
        return approvers;
    }

    public void setApprovers(List<User> approvers) {
        this.approvers = approvers;
    }
}
