package com.baihui.hxtd.soa.common.entity;

import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 功能描述：流程环节实体类
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.entity.FlowNode.java
 * @date 2014-5-26 上午09:47:36
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Entity
@Table(name = "wf_node")
public class FlowNode implements Serializable, Orderable {

    /** 主键ID */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    /** 节点代码 */
    @Column(name = "CODE")
    private String code;

    /** 节点名称 */
    @Column(name = "NAME")
    private String name;

    /** 节点类型 */
    @Column(name = "TYPE_ID")
    private Integer type;

    /** 所属流程 */
    @ManyToOne
    @JoinColumn(name = "FLOW_ID")
    private Dictionary flow;

    /** 执行流程的角色 */
    @ManyToOne
    @JoinColumn(name = "ROLE_ID")
    private Role role;

    /** 节点类型 */
    @Column(name = "`ORDER`")
    private Long order;

    /** 审批组织 */
    @Transient
    private Organization organization;

    /** 待选审批人 */
    @Transient
    private List<User> approvers = new ArrayList<User>();

    /** 执行审批人 */
    @Transient
    private User approver;

    /** 执行流程环节 */
    @Transient
    private FlowNode executeFlowNode;


    public FlowNode() {
    }

    public FlowNode(Long id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object obj) {
        return obj == null ? false : (((FlowNode) obj).getId().equals(getId()));
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Dictionary getFlow() {
        return flow;
    }

    public void setFlow(Dictionary flow) {
        this.flow = flow;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public List<User> getApprovers() {
        return approvers;
    }

    public void setApprovers(List<User> approvers) {
        this.approvers = approvers;
    }

    public User getApprover() {
        return approver;
    }

    public void setApprover(User approver) {
        this.approver = approver;
    }

    @Override
    public Long getOrder() {
        return order;
    }

    @Override
    public void setOrder(Long order) {
        this.order = order;
    }

    public FlowNode getExecuteFlowNode() {
        return executeFlowNode;
    }

    public void setExecuteFlowNode(FlowNode executeFlowNode) {
        this.executeFlowNode = executeFlowNode;
    }

    @Override
    public int compareTo(Orderable orderable) {
        return (int) (getOrder() - orderable.getOrder());
    }
}
