package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.common.dao.WFNodeDao;
import com.baihui.hxtd.soa.common.entity.NodeType;
import com.baihui.hxtd.soa.common.entity.WFNode;
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
public class WFNodeService {

    private Logger logger = LoggerFactory.getLogger(MemoirService.class);

    @Resource
    private WFNodeDao wfNodeDao;

    @Resource
    private UserDao userDao;

    @Resource
    private RoleDao roleDao;

    @Resource
    private OrganizationDao organizationDao;

//    public List<WFNode>

    /** 查找流程节点通过流程类型值 */
    @Transactional(readOnly = true)
    public List<WFNode> findByFlowValue(String flowValue) {
        return wfNodeDao.findByFlowValue(flowValue);
    }

    /** 查找开始流程节点通过流程类型值 */
    @Transactional(readOnly = true)
    public WFNode findStartByFlowValue(String flowValue) {
        return wfNodeDao.findStartByFlowValue(flowValue);
    }

    /** 查找结束流程节点通过流程类型值 */
    @Transactional(readOnly = true)
    public List<WFNode> findEndByFlowValue(String flowValue) {
        return wfNodeDao.findEndByFlowValue(flowValue);
    }


    /**
     * 填充审批者
     * 根据角色查找对应的审批人员
     */
    @Transactional(readOnly = true)
    public List<WFNode> fullApprover(User user, List<WFNode> nodes) {

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
            WFNode node = nodes.get(i);
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

    /** 查找用户可执行的节点 */
    @Transactional(readOnly = true)
    public List<WFNode> findExecuteable(User user, String flowType) {
        List<WFNode> executes = new ArrayList<WFNode>();
        List<Role> roles = roleDao.findValid(user);
        List<WFNode> nodes = findByFlowValue(flowType);
        for (int i = 0; i < nodes.size(); i++) {
            WFNode node = nodes.get(i);
            if (roles.contains(node.getRole())) {
                executes.add(nodes.get(i - 1));
            }
        }
        return executes;
    }


    /** 获取下一个节点 */
    @Transactional(readOnly = true)
    public WFNode getNextWFNode(String flowValue, Long id) {
        List<WFNode> wfNodes = findByFlowValue(flowValue);
        //id为null，返回第一个节点
        if (id == null) {
            return wfNodes.get(0);
        }

        int index = wfNodes.indexOf(new WFNode(id));
        //当前节点为末位节点，抛出异常
        if (index == wfNodes.size() - 1) {
            throw new RuntimeException("已经是结束节点了！");
        }

        return wfNodes.get(index + 1);
    }

}
