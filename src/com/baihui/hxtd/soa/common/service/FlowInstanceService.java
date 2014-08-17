package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.common.controller.model.FlowModel;
import com.baihui.hxtd.soa.common.dao.FlowInstanceDao;
import com.baihui.hxtd.soa.common.dao.FlowNodeDao;
import com.baihui.hxtd.soa.common.entity.*;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.dao.MessageDao;
import com.baihui.hxtd.soa.system.dao.UserMessageDao;
import com.baihui.hxtd.soa.system.entity.Message;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.entity.UserMessage;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
    private UserMessageDao userMessageDao;
    @Resource
    private MessageDao messageDao;
    @Resource
    private DictionaryDao dictionaryDao;


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

    /** 填充流程业务实体 */
    public List<FlowInstance> fullFlowBusiness(List<FlowInstance> flowInstances) {
        for (int i = 0; i < flowInstances.size(); i++) {
            FlowInstance flowInstance = flowInstances.get(i);
            flowInstance.setFlowBusiness((IdFlowable) findBusiness(flowInstance));
        }
        return flowInstances;
    }

    /** 查找业务实体 */
    @SuppressWarnings("unchecked")
    public <T> T findBusiness(FlowInstance flowInstance) {
        String hql = "select entity from %s entity inner join fetch entity.flowNode where entity.id=?";
        hql = String.format(hql, flowInstance.getModule().getEntityClass());
        return (T) (Object) flowInstanceDao.findUnique(hql, flowInstance.getRecordId());
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
        FlowInstance flowInstance = flowModel.getExecuteRecord();
        String hql = String.format("update %s entity set entity.flowNode=? where id=?", flowInstance.getModule().getEntityClass());
        List<FlowNode> flowNodes = flowNodeDao.findAllOfFlow(flowModel.getFlowValue());
        flowInstanceDao.batchExecute(hql, FlowNodeService.findNext(flowNodes, flowInstance.getFlowNode()), flowInstance.getRecordId());

        //保存当前流程实例
        Date now = new Date();
        flowInstance.setIsPassed(true);
        flowInstance.setApproveTime(now);
        flowInstance.setCreatedTime(now);
        flowInstance.setModifiedTime(now);
        flowInstanceDao.save(flowInstance);

        //删除预存的流程实例（退回到开始时，需要进行）
        flowInstanceDao.deleteReserve(flowInstance.getModule(), flowInstance.getRecordId(), flowModel.getFlowValue());
        //保存预存的流程实例
        List<FlowInstance> reserveExecuteRecoreds = flowModel.getReserveExecuteRecoreds();
        for (int i = 0; i < reserveExecuteRecoreds.size(); i++) {
            FlowInstance reserveExecuteRecored = reserveExecuteRecoreds.get(i);
            reserveExecuteRecored.setModule(flowInstance.getModule());
            reserveExecuteRecored.setRecordId(flowInstance.getRecordId());
        }
        flowInstanceDao.save(reserveExecuteRecoreds);

        //保存系统消息
        Message message = new Message();
        IdFlowable idFlowable = findBusiness(flowInstance);
        String flowValue = idFlowable.getFlowNode().getFlow().getKey();
        String title = String.format("%s-%s(%s)", flowValue, idFlowable.getFlowNode().getName(), idFlowable.getSketch());
        message.setTitle(title);
        String url = String.format("<a href='../..%s/toStartApprovePage.do?id=%s'>审批链接</a>", flowInstance.getModule().getUrl(), flowInstance.getRecordId());
        String personName = flowInstance.getApprover().getRealName();
        message.setContent(String.format("%s于%s启动%s，特发此系统消息提醒您及时进行审批！%s", personName, format.format(flowInstance.getApproveTime()), message.getTitle(), url));
        message.setCreator(flowInstance.getApprover());
        message.setCreatedTime(flowInstance.getApproveTime());
        message.setModifier(flowInstance.getApprover());
        message.setIsDeleted(false);
        messageDao.save(message);

        UserMessage userMessage = new UserMessage();
        userMessage.setMessage(message);
        userMessage.setUser(reserveExecuteRecoreds.get(0).getApprover());
        userMessage.setCreatedTime(flowInstance.getApproveTime());
        userMessage.setType(false);
        userMessage.setStatus(false);
        userMessage.setIsDeleted(false);
        userMessageDao.saveUserMessage(userMessage);
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
        FlowInstance flowInstance = flowModel.getExecuteRecord();
        Module module = flowInstance.getModule();

        //更新订单流程环节
        List<FlowNode> allFlowNodes = flowNodeDao.findAllOfFlow(flowModel.getFlowValue());
        String hql = String.format("update %s entity set entity.flowNode=? where id=?", module.getEntityClass());
        FlowNode updateFlowNode;
        //通过，更新流程环节为当前用户执行流程环节的下一个
        if (flowInstance.getIsPassed()) {
            updateFlowNode = FlowNodeService.findNext(allFlowNodes, flowInstance.getFlowNode());
        }
        //不通过，更新流程环节为业务对象流程环节的上一个
        else {
            updateFlowNode = FlowNodeService.findPrev(allFlowNodes, flowModel.getCurrentFlowNode());
        }
        flowInstanceDao.batchExecute(hql, updateFlowNode, flowInstance.getRecordId());

        if (flowInstance.getIsPassed()) {
            //保存跳过执行记录
            List<FlowNode> skipFlowNodes = FlowNodeService.findBetween(allFlowNodes, flowModel.getCurrentFlowNode(), flowInstance.getFlowNode());
            List<FlowInstance> skipExecuteRecords = new ArrayList<FlowInstance>(skipFlowNodes.size());
            for (int i = 0; i < skipFlowNodes.size(); i++) {
                FlowInstance skipExecuteRecord = new FlowInstance();
                skipExecuteRecord.setModule(flowInstance.getModule());
                skipExecuteRecord.setRecordId(flowInstance.getRecordId());
                skipExecuteRecord.setFlowNode(skipFlowNodes.get(i));
                skipExecuteRecord.setIsPassed(true);
                skipExecuteRecord.setReason(String.format("直接%s", flowInstance.getFlowNode().getName()));
                skipExecuteRecord.setApprover(flowInstanceDao.findReserveExecutor(module.getName(), flowInstance.getRecordId(), skipExecuteRecord.getFlowNode()));
                skipExecuteRecord.setApproveTime(now);
                skipExecuteRecord.setCreator(flowInstance.getCreator());
                skipExecuteRecord.setCreatedTime(now);
                skipExecuteRecord.setModifier(flowInstance.getModifier());
                skipExecuteRecords.add(skipExecuteRecord);
            }
            flowInstanceDao.save(skipExecuteRecords);
        }

        //保存当前执行记录
        flowInstance.setApproveTime(now);
        flowInstance.setCreatedTime(now);
        flowInstanceDao.save(flowInstance);


        if (flowInstance.getIsPassed()) {
            //更新下一个流程环节执行者
            flowInstanceDao.updateReserveExecutor(flowInstance.getModule(), flowInstance.getRecordId(), flowModel.getNextFlowNode());

            //清除预定执行记录
            if (flowModel.getNextFlowNode().getType().equals(NodeType.end.getValue())) {
                flowInstanceDao.deleteReserve(flowInstance.getModule(), flowInstance.getRecordId(), flowModel.getFlowValue());
            }
        }

        //保存系统消息，如果不是结束节点
        if (!updateFlowNode.getType().equals(NodeType.end.getValue())) {

            Message message = new Message();
            IdFlowable idFlowable = findBusiness(flowInstance);
            message.setTitle(String.format("%s-%s(%s)", updateFlowNode.getFlow().getKey(), idFlowable.getFlowNode().getName(), idFlowable.getSketch()));
            String personName = flowInstance.getApprover().getRealName();
            String timeStr = format.format(flowInstance.getApproveTime());
            String isPassed = flowInstance.getIsPassed() ? "审核通过" : "审核未通过";
            String url = String.format("<a href='../..%s/toExecuteApprovePage.do?id=%s'>审批链接</a>", flowInstance.getModule().getUrl(), flowInstance.getRecordId());
            message.setContent(String.format("%s于%s执行%s，%s，特发此系统消息提醒您及时进行审批！%s", personName, timeStr, message.getTitle(), isPassed, url));
            message.setCreator(flowInstance.getApprover());
            message.setCreatedTime(flowInstance.getApproveTime());
            message.setModifier(flowInstance.getApprover());
            message.setIsDeleted(false);
            messageDao.save(message);

            UserMessage userMessage = new UserMessage();
            userMessage.setMessage(message);
            User reserveExecutor;
            if (flowInstance.getIsPassed()) {
                reserveExecutor = flowInstanceDao.findReserveExecutor(flowInstance.getModule().getName(), flowInstance.getRecordId(), updateFlowNode);
            } else {
                reserveExecutor = flowInstanceDao.findLastExecutedExecutor(flowInstance.getModule().getName(), flowInstance.getRecordId(), updateFlowNode);
            }
            userMessage.setUser(reserveExecutor);
            userMessage.setCreatedTime(flowInstance.getApproveTime());
            userMessage.setType(false);
            userMessage.setStatus(false);
            userMessage.setIsDeleted(false);
            userMessageDao.saveUserMessage(userMessage);
        }

    }


}
