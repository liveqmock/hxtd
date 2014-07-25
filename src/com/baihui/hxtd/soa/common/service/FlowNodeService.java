package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.common.dao.FlowNodeDao;
import com.baihui.hxtd.soa.common.dao.FlowInstanceDao;
import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.IdFlowable;
import com.baihui.hxtd.soa.common.entity.NodeType;
import com.baihui.hxtd.soa.system.dao.OrganizationDao;
import com.baihui.hxtd.soa.system.dao.RoleDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * 功能描述：联系纪要service层
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.service.ApproveService.java
 * @date 2014-5-26 上午11:16:20
 * @since (该版本支持的 JDK 版本) ： 1.5
 */
@Service
@Transactional
public class FlowNodeService {

    private Logger logger = LoggerFactory.getLogger(MemoirService.class);

    @Resource
    private FlowNodeDao flowNodeDao;

    @Resource
    private FlowInstanceDao flowInstanceDao;

    @Resource
    private UserDao userDao;

    @Resource
    private RoleDao roleDao;

    @Resource
    private OrganizationDao organizationDao;

    @Transactional(readOnly = true)
    public FlowNode get(Long id) {
        return flowNodeDao.get(id);
    }

    /** 查找一个流程中所有流程环节 */
    @Transactional(readOnly = true)
    public List<FlowNode> findAllOfFlow(String flowValue) {
        return flowNodeDao.findAllOfFlow(flowValue);
    }

    /** 查找一个流程的开始流程环节 */
    @Transactional(readOnly = true)
    public FlowNode findStartOfFlow(String flowValue) {
        return flowNodeDao.findStartOfFlow(flowValue);
    }

    /** 查找一个流程的结束流程环节 */
    @Transactional(readOnly = true)
    public List<FlowNode> findEndOfFlow(String flowValue) {
        return flowNodeDao.findEndOfFlow(flowValue);
    }

    /** 查找一个流程中当前流程环节之后的流程环节 */
    @Transactional(readOnly = true)
    public static List<FlowNode> findAfter(List<FlowNode> flowNodes, FlowNode currentFlowNode) {
        List<FlowNode> afters = new ArrayList<FlowNode>();

        int index = flowNodes.indexOf(currentFlowNode);
        for (int i = index + 1; i < flowNodes.size(); i++) {
            afters.add(flowNodes.get(i));
        }

        return afters;
    }


    /**
     * 查找一个流程中开始和结束流程环节之间的流程环节
     * 1.包含开始流程
     * 2.不包含结束流程
     */
    public static List<FlowNode> findBetween(List<FlowNode> all, FlowNode start, FlowNode end) {
        List<FlowNode> between = new ArrayList<FlowNode>();

        int min = all.indexOf(start);
        int max = all.indexOf(end);
        for (int i = min; i < max; i++) {
            between.add(all.get(i));
        }

        return between;
    }


    /**
     * 填充审批者
     * 根据角色查找对应的审批人员
     */
    @Transactional(readOnly = true)
    public List<FlowNode> fullPreselectionApprover(List<FlowNode> nodes, User user) {

        //设置业务节点
        Organization organization = user.getOrganization();
        Map<String, List<User>> approvers = new HashMap<String, List<User>>();
        approvers.put(Constant.ROLE_CEO, userDao.findByRoleCode(Constant.ROLE_CEO));
        approvers.put(Constant.ROLE_VICECEO, userDao.findByRoleCode(Constant.ROLE_VICECEO));
        approvers.put(Constant.ROLE_FINANCER, userDao.findByRoleCode(Constant.ROLE_FINANCER));
        approvers.put(Constant.ROLE_INVESTMENTDIRECTOR, userDao.findByOrgIdRoleCode(organizationDao.getParentIdById(organization.getId()), Constant.ROLE_INVESTMENTDIRECTOR));
        approvers.put(Constant.ROLE_INVESTMENTMANAGER, userDao.findByOrgIdRoleCode(organization.getId(), Constant.ROLE_INVESTMENTMANAGER));
        approvers.put(Constant.ROLE_FINANCIALMANAGER, userDao.findByOrgIdRoleCode(organization.getId(), Constant.ROLE_FINANCIALMANAGER));

        for (int i = 0; i < nodes.size(); i++) {
            FlowNode node = nodes.get(i);
            //设置开始节点
            if (node.getType().equals(NodeType.start.getValue())) {
                nodes.get(0).setApprovers(Arrays.asList(user));
            }
            //设置业务节点
            else if (node.getType().equals(NodeType.business.getValue())) {
                Role role = node.getRole();
                if (role != null) {
                    String roleCode = role.getCode();
                    node.setApprovers(approvers.get(roleCode));
                }
            }
        }

        return nodes;
    }

    /**
     * 填充预存的审批者
     */
    @Transactional(readOnly = true)
    public FlowNode fullPreselectionApprover(FlowNode flowNode, User user) {

        Organization organization = user.getOrganization();
        //设置开始节点
        if (flowNode.getType().equals(NodeType.start.getValue())) {
            flowNode.setApprovers(Arrays.asList(user));
        }
        //设置业务节点
        else if (flowNode.getType().equals(NodeType.business.getValue())) {
            String roleCode = flowNode.getRole().getCode();
            if (roleCode.equals(Constant.ROLE_CEO) || roleCode.equals(Constant.ROLE_VICECEO) || roleCode.equals(Constant.ROLE_FINANCER)) {
                flowNode.setApprovers(userDao.findByRoleCode(roleCode));
            } else if (roleCode.equals(Constant.ROLE_INVESTMENTDIRECTOR)) {
                flowNode.setApprovers(userDao.findByOrgIdRoleCode(organizationDao.getParentIdById(organization.getId()), roleCode));
            } else {
                flowNode.setApprovers(userDao.findByOrgIdRoleCode(organization.getId(), roleCode));
            }
        }
        return flowNode;
    }

    /**
     * 填充流程环节预定的执行者
     * 1.预定的，是指在启动流程时为各个流程环节指派的执行者
     */
    @Transactional(readOnly = true)
    public <T extends IdFlowable> T fullReserveExecutor(T business, String moduleName) {
        FlowNode flowNode = business.getFlowNode();
        flowNode.setApprover(flowInstanceDao.findReserveExecutor(moduleName, business.getId(), flowNode));
        return business;
    }

    /**
     * 填充流程环节预定的执行者
     *
     * @see #fullReserveExecutor(com.baihui.hxtd.soa.common.entity.IdFlowable, String)
     */
    @Transactional(readOnly = true)
    public <T extends IdFlowable> List<T> fullReserveExecutor(List<T> flowBusinesses, String moduleName) {
        for (int i = 0; i < flowBusinesses.size(); i++) {
            fullReserveExecutor(flowBusinesses.get(i), moduleName);
        }
        return flowBusinesses;
    }

    /** 填充流程环节的执行者 */
    @Transactional(readOnly = true)
    public FlowNode fullReserveExecutor(String moduleName, Long idValue, FlowNode flowNode) {
        User reserveExecutor = flowInstanceDao.findReserveExecutor(moduleName, idValue, flowNode);
        flowNode.setApprover(reserveExecutor);
        return flowNode;
    }

    /** 填充流程环节的执行者 */
    @Transactional(readOnly = true)
    public List<FlowNode> fullReserveExecutor(String moduleName, Long idValue, List<FlowNode> flowNodes) {
        for (int i = 0; i < flowNodes.size(); i++) {
            fullReserveExecutor(moduleName, idValue, flowNodes.get(i));
        }
        return flowNodes;
    }

    /** 查找用户可执行的流程环节 */
    @Transactional(readOnly = true)
    public List<FlowNode> findExecuteable(User user, String flowType) {
        List<FlowNode> executes = new ArrayList<FlowNode>();
        List<Role> roles = roleDao.findValid(user);
        List<FlowNode> allFlowNodes = findAllOfFlow(flowType);
        for (int i = 0; i < allFlowNodes.size(); i++) {
            FlowNode flowNode = allFlowNodes.get(i);
            if (roles.contains(flowNode.getRole())) {
                executes.add(allFlowNodes.get(i));
            }
        }
        return executes;
    }

    /** 查找用户可执行的最优先的流程环节 */
    @Transactional(readOnly = true)
    public FlowNode findExecutablePrepreerence(User user, String flowType) {
        List<FlowNode> flowNodes = findExecuteable(user, flowType);
        if (flowNodes.size() == 0) {
            return null;
        }
        Collections.sort(flowNodes);
        return flowNodes.get(flowNodes.size() - 1);
    }

    /** 获取上一个节点 */
    public static FlowNode findPrev(List<FlowNode> flowNodes, FlowNode flowNode) {
        if (flowNode.getType().equals(NodeType.start.getValue())) {
            throw new RuntimeException("已经是开始节点了！");
        }
        int index = flowNodes.indexOf(flowNode);
        return flowNodes.get(index - 1);
    }

    /** 获取下一个节点 */
    public static FlowNode findNext(List<FlowNode> flowNodes, FlowNode flowNode) {
        if (flowNode.getType().equals(NodeType.end.getValue())) {
            throw new RuntimeException("已经是结束节点了！");
        }
        int index = flowNodes.indexOf(flowNode);
        return flowNodes.get(index + 1);
    }

}
