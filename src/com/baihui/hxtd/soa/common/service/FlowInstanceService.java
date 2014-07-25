package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.common.controller.model.FlowModel;
import com.baihui.hxtd.soa.common.dao.FlowInstanceDao;
import com.baihui.hxtd.soa.common.dao.FlowNodeDao;
import com.baihui.hxtd.soa.common.entity.*;
import com.baihui.hxtd.soa.system.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 功能描述：联系纪要service层
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.service.FlowInstanceService.java
 * @date 2014-5-26 上午11:16:20
 * @since (该版本支持的 JDK 版本) ： 1.5
 */
@Service
@Transactional
public class FlowInstanceService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private FlowInstanceDao flowInstanceDao;

    @Resource
    private FlowNodeDao flowNodeDao;

    /** 查找流程环节的执行者 */
    @Transactional(readOnly = true)
    public User findReserveExecuter(String moduleName, Long idValue, FlowNode flowNode) {
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

    /** 查找预存储未执行的task */
    @Transactional(readOnly = true)
    public List<FlowInstance> findFuture(String moduleName, Long idValue, String flowType) {
        String hql = "select task from FlowInstance task" +
                " inner join fetch task.wfNode flowNode" +
                " inner join fetch flowNode.flow flowType" +
                " inner join fetch task.module module" +
                " inner join fetch task.approver approver" +
                " where module.name=?" +
                " and task.recordId=?" +
                " and flowType.value=?" +
                " and task.isPassed is null" +
                " order by flowNode.code";
        return flowInstanceDao.find(hql, moduleName, idValue, flowType);
    }

    /** 查找已执行的task */
    @Transactional(readOnly = true)
    public List<FlowInstance> findExecuted(String moduleName, Long idValue, String flowType) {
        return flowInstanceDao.findExecuted(moduleName, idValue, flowType);
    }


    /** 填充是否可执行的 */
    @Transactional(readOnly = true)
    public <T extends IdFlowable> List<T> fullExecutable(String moduleName, FlowNode flowNode, List<T> businesses) {
        for (int i = 0; i < businesses.size(); i++) {
            T business = businesses.get(i);
            boolean isExecutable = flowInstanceDao.isExecutable(moduleName, flowNode, business);
            if (isExecutable) {
                business.getFlowNode().setExecuteFlowNode(flowNode);
            }
        }
        return businesses;
    }

    /**
     * 查找可执行的流程实例
     * 1.流程实例行进至当前流程环节的上一个流程环节
     */
    public List<FlowInstance> findExecutable(String roleCode) {
        String lastInstanceHql = "select max(instance.id) from FlowInstance instance" +
                " where instance.isPassed is not null" +
                " group by instance.module,instance.recordId,instance.flowNode.flow";
        String hql = "select instance from FlowInstance instance,FlowNode flowNode" +
                " inner join fetch instance.module" +
                " inner join fetch instance.flowNode" +
                " where instance.id in (%s)" +
                " and instance.flowNode.flow=flowNode.flow" +
                " and instance.flowNode.order+1=flowNode.order" +
                " and flowNode.role.code=?";
        hql = String.format(hql, lastInstanceHql);
        List<FlowInstance> flowInstances = flowInstanceDao.find(hql, roleCode);
        logger.info("flowInstances.size={}", flowInstances);
        return flowInstances;
    }

    /** 填充流程业务实体 */
    public List<FlowInstance> fullFlowBusiness(List<FlowInstance> flowInstances) {
        String hql = "select entity from %s entity where entity.id=?";
        for (int i = 0; i < flowInstances.size(); i++) {
            FlowInstance flowInstance = flowInstances.get(i);
            String hqlInstance = String.format(hql, flowInstance.getModule().getEntityClass());
            flowInstance.setFlowBusiness((IdFlowable) flowInstanceDao.findUnique(hqlInstance, flowInstance.getRecordId()));
        }
        return flowInstances;
    }

    /**
     * 启动流程
     * 1.设置流程归属对象的环节为开始
     * 2.保存流程环节到审批记录中
     * 3.更新开始流程记录
     */
    @Transactional
    public void start(FlowModel flowModel) {
        FlowInstance executeRecord = flowModel.getExecuteRecord();
        String hql = String.format("update %s entity set entity.status=? where id=?", executeRecord.getModule().getEntityClass());
        List<FlowNode> flowNodes = flowNodeDao.findAllOfFlow(flowModel.getFlowValue());
        flowInstanceDao.batchExecute(hql, FlowNodeService.findNext(flowNodes, executeRecord.getFlowNode()), executeRecord.getRecordId());

        Date now = new Date();
        executeRecord.setIsPassed(true);
        executeRecord.setApproveTime(now);
        executeRecord.setCreatedTime(now);
        executeRecord.setModifiedTime(now);
        flowInstanceDao.save(executeRecord);

        List<FlowInstance> reserveExecuteRecoreds = flowModel.getReserveExecuteRecoreds();
        for (int i = 0; i < reserveExecuteRecoreds.size(); i++) {
            FlowInstance reserveExecuteRecored = reserveExecuteRecoreds.get(i);
            reserveExecuteRecored.setModule(executeRecord.getModule());
            reserveExecuteRecored.setRecordId(executeRecord.getRecordId());
        }
        flowInstanceDao.save(reserveExecuteRecoreds);

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
        String hql = String.format("update %s entity set entity.status=? where id=?", module.getEntityClass());
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
