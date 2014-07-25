package com.baihui.hxtd.soa.common.dao;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.FlowInstance;
import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.IdFlowable;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.system.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 功能描述：联系纪要持久化层
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.dao.FlowInstanceDao.java
 * @date 2014-5-26 上午11:15:52
 * @since (该版本支持的 JDK 版本) ： 1.5
 */
@Repository
public class FlowInstanceDao extends HibernateDAOImpl<FlowInstance, Long> {

    /**
     * 查找预定的执行记录
     * --启动流程后，会在执行记录中保存每个流程环节对应的执行者，这些执行记录称为是“预定的”
     */
    public List<FlowInstance> findReserve(String moduleName, Long idValue, String flowValue) {
        String hql = "select task from FlowInstance task" +
                " inner join fetch task.flowNode flowNode" +
                " inner join fetch flowNode.flow flow" +
                " inner join task.module module" +
                " where module.name=?" +
                " and task.recordId=?" +
                " and flow.value=?" +
                " and task.isPassed is null" +
                " order by flowNode.code";
        return find(hql, moduleName, idValue, flowValue);
    }

    /** 查找流程环节预定执行者 */
    public User findReserveExecutor(String moduleName, Long idValue, FlowNode flowNode) {
        String hql = "select task.approver from FlowInstance task" +
                " where task.module.name=?" +
                " and task.recordId=?" +
                " and task.flowNode=?" +
                " and task.isPassed is null";
        return findUnique(hql, moduleName, idValue, flowNode);
    }

    /** 查找已执行的执行记录 */
    public List<FlowInstance> findExecuted(String moduleName, Long idValue, String flowType) {
        String hql = "select task from FlowInstance task" +
                " inner join fetch task.flowNode flowNode" +
                " inner join fetch flowNode.flow flowType" +
                " inner join fetch task.module module" +
                " inner join fetch task.approver approver" +
                " where module.name=?" +
                " and task.recordId=?" +
                " and flowType.value=?" +
                " and task.isPassed is not null" +
                " order by task.modifiedTime";
        return find(hql, moduleName, idValue, flowType);
    }

    /** 更新预定执行者 */
    public void updateReserveExecutor(Module module, Long idValue, FlowNode flowNode) {
        String hql = "update FlowInstance task set task.approver=?" +
                " where task.module=?" +
                " and task.recordId=?" +
                " and task.flowNode=?" +
                " and task.isPassed is null";
        batchExecute(hql, flowNode.getApprover(), module, idValue, flowNode);
    }

    /** 删除预定执行记录 */
    public void deleteReserve(Module module, Long idValue, String flowValue) {
        String hql = "delete from FlowInstance task" +
                " where task.module=?" +
                " and task.recordId=?" +
                " and task.flowNode in (select flowNode from FlowNode flowNode where flowNode.flow.value=?)" +
                " and task.isPassed is null";
        batchExecute(hql, module, idValue, flowValue);
    }


    /**
     * 是否可执行的
     * 业务对象是否可被当前用户执行的
     * --业务对象涉及的当前流程环节及其后流程环节包含当前用户可执行的流程环节
     * 当前用户可 以多种流程环节方式执行时，选择优先级最高的
     */
    public boolean isExecutable(String moduleName, FlowNode flowNode, IdFlowable business) {
        String hql = "select count(task.id) from FlowInstance task" +
                " inner join task.flowNode flowNode" +
                " inner join flowNode.flow flowType" +
                " where task.module.name=?" +
                " and task.recordId=?" +
                " and flowType.value=?" +
                " and flowNode.code>=?" +
                " and flowNode=?" +
                " and task.approver=?" +
                " and task.isPassed is null";
        String flowValue = flowNode.getFlow().getValue();
        return (Long) findUnique(hql, moduleName, business.getId(), flowValue, business.getFlowNode().getCode(), flowNode, flowNode.getApprover()) > 0l;
    }

    /** 执行流程 */
    public void execute(FlowInstance execureRecord) {
        String hql = "select task from FlowInstance task" +
                " where task.module=?" +
                " and task.recordId=?" +
                " and task.flowNode=?" +
                " and task.isPassed is null";
        FlowInstance reserve = findUnique(hql, execureRecord.getModule(), execureRecord.getRecordId(), execureRecord.getFlowNode());
        reserve.setIsPassed(execureRecord.getIsPassed());
        reserve.setReason(execureRecord.getReason());
        reserve.setApprover(execureRecord.getApprover());
        reserve.setApproveTime(execureRecord.getApproveTime());
        reserve.setModifier(execureRecord.getModifier());
        save(reserve);
    }


}
