package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.common.controller.model.FlowModel;
import com.baihui.hxtd.soa.common.dao.FlowInstanceDao;
import com.baihui.hxtd.soa.common.dao.FlowNodeDao;
import com.baihui.hxtd.soa.common.entity.*;
import com.baihui.hxtd.soa.system.dao.MessageDao;
import com.baihui.hxtd.soa.system.dao.OrganizationDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.dao.UserMessageDao;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 流程实例服务类
 *
 * @author xiayouxue
 * @date 2014/7/20
 */
@Service
@Transactional
public class FlowInstanceService {

    /*
    开始            所有者
    理财经理审核    属于流程启动者所属组织 并且 具有理财经理角色
    投资经理审核    属于流程启动者所属组织 并且 具有投资经理角色
    投资总监审核    属于流程启动者所属组织的上一级组织 并且 具有投资总监角色
    副总裁审核      具有副总裁角色
    总裁审核        具有总裁角色
    财务审核        具有财务角色
    结束

    可以跨级审批
    */

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private FlowInstanceDao flowInstanceDao;

    @Resource
    private FlowNodeDao flowNodeDao;

    @Resource
    private UserDao userDao;

    @Resource
    private OrganizationDao organizationDao;

    @Resource
    private UserMessageDao userMessageDao;

    @Resource
    private MessageDao messageDao;

    /**
     * 填充审批者
     * 根据角色查找对应的审批人员
     */
    @Transactional(readOnly = true)
    public List<FlowInstance> fullPreselectionExecutor(List<FlowInstance> flowInstances, User user) {

        //设置业务节点
        Organization organization = user.getOrganization();
        Map<String, List<User>> approvers = new HashMap<String, List<User>>();
        approvers.put(Constant.ROLE_CEO, userDao.findByRoleCode(Constant.ROLE_CEO));
        approvers.put(Constant.ROLE_VICECEO, userDao.findByRoleCode(Constant.ROLE_VICECEO));
        approvers.put(Constant.ROLE_FINANCER, userDao.findByRoleCode(Constant.ROLE_FINANCER));
        approvers.put(Constant.ROLE_INVESTMENTDIRECTOR, userDao.findByOrgIdRoleCode(organizationDao.getParentIdById(organization.getId()), Constant.ROLE_INVESTMENTDIRECTOR));
        approvers.put(Constant.ROLE_INVESTMENTMANAGER, userDao.findByOrgIdRoleCode(organization.getId(), Constant.ROLE_INVESTMENTMANAGER));
        approvers.put(Constant.ROLE_FINANCIALMANAGER, userDao.findByOrgIdRoleCode(organization.getId(), Constant.ROLE_FINANCIALMANAGER));

        for (int i = 0; i < flowInstances.size(); i++) {
            FlowInstance flowInstance = flowInstances.get(i);
            FlowNode flowNode = flowInstance.getFlowNode();
            //设置开始节点
            if (flowNode.getType().equals(NodeType.start.getValue())) {
                flowInstances.get(0).setExecutors(Arrays.asList(user));
            }
            //设置业务节点
            else if (flowNode.getType().equals(NodeType.business.getValue())) {
                Role role = flowNode.getRole();
                if (role != null) {
                    String roleCode = role.getCode();
                    flowNode.setApprovers(approvers.get(roleCode));
                }
            }
        }

        return flowInstances;
    }

    /**
     * 填充预选执行者
     */
    @Transactional(readOnly = true)
    public FlowInstance fullPreselectionExecutor(FlowInstance flowInstance, User user) {

        Organization organization = user.getOrganization();
        FlowNode flowNode = flowInstance.getFlowNode();
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
        return flowInstance;
    }

    /** 查找预定的 */
    @Transactional(readOnly = true)
    public List<FlowInstance> findReserve(String moduleName, Long idValue, String flowType) {
        String hql = "select instance from FlowInstance instance" +
                " inner join fetch instance.flowNode flowNode" +
                " inner join fetch flowNode.flow flowType" +
                " inner join fetch instance.module module" +
                " left join fetch instance.approver approver" +
                " where module.name=?" +
                " and instance.recordId=?" +
                " and flowType.value=?" +
                " and instance.isPassed is null" +
                " order by flowNode.order";
        return flowInstanceDao.find(hql, moduleName, idValue, flowType);
    }

    /** 查找流程环节的执行者 */
    @Transactional(readOnly = true)
    public User findReserveExecutor(String moduleName, Long idValue, FlowNode flowNode) {
        return flowInstanceDao.findReserveExecutor(moduleName, idValue, flowNode);
    }

    /** 查找预定的流程环节 */
    public static List<FlowNode> findReserveFlowNode(List<FlowInstance> reserveExecuteRecords) {
        List<FlowNode> flowNodes = new ArrayList<FlowNode>();
        for (int i = 0; i < reserveExecuteRecords.size(); i++) {
            FlowInstance reserveExecuteRecord = reserveExecuteRecords.get(i);
            reserveExecuteRecord.getFlowNode().setApprover(reserveExecuteRecord.getApprover());
            flowNodes.add(reserveExecuteRecord.getFlowNode());
        }
        return flowNodes;
    }

    /** 查找已执行的instance */
    @Transactional(readOnly = true)
    public List<FlowInstance> findExecuted(String moduleName, Long idValue, String flowType) {
        return flowInstanceDao.findExecuted(moduleName, idValue, flowType);
    }


    /** 填充是否可执行的 */
    @Transactional(readOnly = true)
    public <T extends IdFlowable> List<T> fullExecutable(String moduleName, FlowNode flowNode, List<T> businesses) {
        for (int i = 0; i < businesses.size(); i++) {
            T business = businesses.get(i);
            //排除财务
            boolean isExecutable = !flowNode.getRole().getCode().equals(Constant.ROLE_FINANCER);
            isExecutable = isExecutable && flowInstanceDao.isExecutable(moduleName, flowNode, business);
            if (isExecutable) {
                business.getFlowNode().setExecuteFlowNode(flowNode);
            }
        }
        return businesses;
    }

    /**
     * 查找已执行的流程实例
     * 1.自己参与过的
     * 2.不考虑重复参与的情况
     */
    public HibernatePage<FlowInstance> findParticipantPagination(HibernatePage<FlowInstance> page, Map<String, Object> conditions) {
        //固定的条件数目，user=1
        int fixConditionLength = 1;
        List<String> conditionExps = new ArrayList<String>();

        String lastHql = "select max(instance.id) from FlowInstance instance where instance.approver=:user and instance.isPassed is not null"
                + StringUtils.repeat(" %s", conditions.size() - fixConditionLength)
                + " group by instance.module,instance.recordId,instance.flowNode.flow";

        if (conditions.containsKey("moduleId")) {
            conditionExps.add("and instance.module.id=:moduleId");
            conditions.put("moduleId", Long.parseLong(conditions.get("moduleId").toString()));
        }
        if (conditions.containsKey("flowId")) {
            conditionExps.add("and instance.flowNode.flow.id=:flowId");
            conditions.put("flowId", Long.parseLong(conditions.get("flowId").toString()));
        }
        lastHql = String.format(lastHql, conditionExps.toArray());

        String hql = "select instance from FlowInstance instance" +
                " where instance.id in (%s)";
        hql = String.format(hql, lastHql);
        flowInstanceDao.findPage(page, hql, conditions);
        logger.info("数目={}", page.getResult().size());
        return page;
    }

    /**
     * 查找可执行的流程实例
     * 1.待审核
     * 轮到自己参与流程中某个流程实例
     * --查找最近执行的流程实例
     * --查找流程实例的下一个流程环节
     * --查找预定的流程执行者
     * 2.已审核
     * 自己参与了流程中某个流程实例
     */
    public HibernatePage<FlowInstance> findExecutablePagination(HibernatePage<FlowInstance> page, Map<String, Object> conditions) {

        //固定的条件数目，roleCode&&user=2
        int fixConditionLength = 2;
        List<String> conditionExps = new ArrayList<String>();
        String lastInstanceHql = "select max(lastInstance.id) from FlowInstance lastInstance" +
                " where lastInstance.isPassed is not null" +
                " and exists(select flowNode from FlowNode flowNode where flowNode.flow=lastInstance.flowNode.flow and flowNode.role.code=:roleCode)" +
                StringUtils.repeat(" %s", conditions.size() - fixConditionLength) +
                " group by lastInstance.module,lastInstance.recordId,lastInstance.flowNode.flow";
        if (conditions.containsKey("moduleId")) {
            conditionExps.add("and lastInstance.module.id=:moduleId");
            conditions.put("moduleId", Long.parseLong(conditions.get("moduleId").toString()));
        }
        if (conditions.containsKey("flowId")) {
            conditionExps.add("and lastInstance.flowNode.flow.id=:flowId");
            conditions.put("flowId", Long.parseLong(conditions.get("flowId").toString()));
        }
        lastInstanceHql = String.format(lastInstanceHql, conditionExps.toArray());


        String hql = "select instance from FlowInstance instance" +
                " where instance.id in (%s)" +
                " and exists(%s)";
        //预定的实例
        String reserveInstanceHql = "select reserve from FlowInstance reserve" +
                " where reserve.flowNode.flow=instance.flowNode.flow" +
                " and reserve.flowNode.order=instance.flowNode.order+1" +
                " and reserve.approver=:user";
        hql = String.format(hql, lastInstanceHql, reserveInstanceHql);

        flowInstanceDao.findPage(page, hql, conditions);
        logger.info("数目={}", page.getResult().size());
        return page;
    }

    /** 填充流程业务实体 */
    public List<FlowInstance> fullFlowBusiness(List<FlowInstance> flowInstances) {
        String hql = "select entity from %s entity inner join fetch entity.flowNode where entity.id=?";
        for (int i = 0; i < flowInstances.size(); i++) {
            FlowInstance flowInstance = flowInstances.get(i);
            String hqlInstance = String.format(hql, flowInstance.getModule().getEntityClass());
            flowInstance.setFlowBusiness((IdFlowable) flowInstanceDao.findUnique(hqlInstance, flowInstance.getRecordId()));
        }
        return flowInstances;
    }

    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    /**
     * 启动流程
     * 1.设置流程归属对象的环节为开始
     * 2.保存流程环节到审批记录中
     * 3.更新开始流程记录
     */
    @Transactional
    public void start(FlowModel flowModel) {
        //设置流程业务对象流程环节
        FlowInstance executeRecord = flowModel.getExecuteRecord();
        String hql = String.format("update %s entity set entity.flowNode=? where id=?", executeRecord.getModule().getEntityClass());
        List<FlowNode> flowNodes = flowNodeDao.findAllOfFlow(flowModel.getFlowValue());
        flowInstanceDao.batchExecute(hql, FlowNodeService.findNext(flowNodes, executeRecord.getFlowNode()), executeRecord.getRecordId());

        //保存当前流程实例
        Date now = new Date();
        executeRecord.setIsPassed(true);
        executeRecord.setApproveTime(now);
        executeRecord.setCreatedTime(now);
        executeRecord.setModifiedTime(now);
        flowInstanceDao.save(executeRecord);

        //删除预存的流程实例（退回到开始时，需要进行）
        flowInstanceDao.deleteReserve(executeRecord.getModule(), executeRecord.getRecordId(), flowModel.getFlowValue());
        //保存预存的流程实例
        List<FlowInstance> reserveExecuteRecoreds = flowModel.getReserveExecuteRecoreds();
        for (int i = 0; i < reserveExecuteRecoreds.size(); i++) {
            FlowInstance reserveExecuteRecored = reserveExecuteRecoreds.get(i);
            reserveExecuteRecored.setModule(executeRecord.getModule());
            reserveExecuteRecored.setRecordId(executeRecord.getRecordId());
        }
        flowInstanceDao.save(reserveExecuteRecoreds);
        /*
        //保存系统消息
        Message message = new Message();
        String flowValue = executeRecord.getFlowNode().getFlow().getKey();
        message.setTitle(String.format("%s（%s%s）", flowValue, executeRecord.getModule().getName(), executeRecord.getRecordId()));
        String personName = executeRecord.getApprover().getRealName();
        message.setContent(String.format("%s%s启动%s，特发此系统消息提醒您及时进行审批！", personName, format.format(executeRecord.getApproveTime()), message.getTitle()));
        message.setCreator(executeRecord.getApprover());
        message.setCreatedTime(executeRecord.getApproveTime());
        messageDao.save(message);

        UserMessage userMessage = new UserMessage();
        userMessage.setMessage(message);
        userMessage.setUser(reserveExecuteRecoreds.get(0).getApprover());
        userMessage.setCreatedTime(executeRecord.getApproveTime());
        userMessage.setType(true);
        userMessage.setStatus(false);
        userMessage.setCreatedTime(executeRecord.getApproveTime());
        userMessageDao.saveUserMessage(userMessage);
        */
    }


    /**
     * 执行流程
     * 1.更新订单流程环节
     * 2.新增当前审批记录
     * 3.更新下一个流程环节审批人
     */
    @Transactional
    public void execute(FlowModel flowModel) {
        Date now = new Date();
        FlowInstance executeRecord = flowModel.getExecuteRecord();
        Module module = executeRecord.getModule();

        //更新订单流程环节
        List<FlowNode> allFlowNodes = flowNodeDao.findAllOfFlow(flowModel.getFlowValue());
        String hql = String.format("update %s entity set entity.flowNode=? where id=?", module.getEntityClass());
        FlowNode updateFlowNode;
        //通过，更新流程环节为当前用户执行流程环节的下一个
        if (executeRecord.getIsPassed()) {
            updateFlowNode = FlowNodeService.findNext(allFlowNodes, executeRecord.getFlowNode());
        }
        //不通过，更新流程环节为业务对象流程环节的上一个
        else {
            updateFlowNode = FlowNodeService.findPrev(allFlowNodes, flowModel.getCurrentFlowNode());
        }
        flowInstanceDao.batchExecute(hql, updateFlowNode, executeRecord.getRecordId());

        if (executeRecord.getIsPassed()) {
            //保存跳过执行记录
            List<FlowNode> skipFlowNodes = FlowNodeService.findBetween(allFlowNodes, flowModel.getCurrentFlowNode(), executeRecord.getFlowNode());
            List<FlowInstance> skipExecuteRecords = new ArrayList<FlowInstance>(skipFlowNodes.size());
            for (int i = 0; i < skipFlowNodes.size(); i++) {
                FlowInstance skipExecuteRecord = new FlowInstance();
                skipExecuteRecord.setModule(executeRecord.getModule());
                skipExecuteRecord.setRecordId(executeRecord.getRecordId());
                skipExecuteRecord.setFlowNode(skipFlowNodes.get(i));
                skipExecuteRecord.setIsPassed(true);
                skipExecuteRecord.setReason(String.format("直接%s", executeRecord.getFlowNode().getName()));
                skipExecuteRecord.setApprover(flowInstanceDao.findReserveExecutor(module.getName(), executeRecord.getRecordId(), skipExecuteRecord.getFlowNode()));
                skipExecuteRecord.setApproveTime(now);
                skipExecuteRecord.setCreator(executeRecord.getCreator());
                skipExecuteRecord.setCreatedTime(now);
                skipExecuteRecord.setModifier(executeRecord.getModifier());
                skipExecuteRecords.add(skipExecuteRecord);
            }
            flowInstanceDao.save(skipExecuteRecords);
        }

        //保存当前执行记录
        executeRecord.setApproveTime(now);
        executeRecord.setCreatedTime(now);
        flowInstanceDao.save(executeRecord);


        if (executeRecord.getIsPassed()) {
            //更新下一个流程环节执行者
            flowInstanceDao.updateReserveExecutor(executeRecord.getModule(), executeRecord.getRecordId(), flowModel.getNextFlowNode());

            //清除预定执行记录
            if (flowModel.getNextFlowNode().getType().equals(NodeType.end.getValue())) {
                flowInstanceDao.deleteReserve(executeRecord.getModule(), executeRecord.getRecordId(), flowModel.getFlowValue());
            }
        }


    }


}
