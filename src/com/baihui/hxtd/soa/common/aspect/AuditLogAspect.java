package com.baihui.hxtd.soa.common.aspect;

import javax.annotation.Resource;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.RecycleBin;
import com.baihui.hxtd.soa.system.service.AuditLogService;
import com.baihui.hxtd.soa.system.service.RecycleBinService;

/**
 * 审计日志切面
 */
@Component
@Aspect
public class AuditLogAspect {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private AuditLogService auditLogService;

    /** 回收站 */
    @Resource
    private RecycleBinService recycleBinService;

    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..add*(..))")
    public void add(){}

    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..modify*(..))")
    public void modify(){}

    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..authorization*(..))")
    public void authorization(){}

    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..delete*(..))")
    public void delete(){}

    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..export*(..))")
    public void exportFile(){}

    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..import*(..))")
    public void importFile() {}

    @Pointcut("add() || modify() ||  authorization()|| delete() || exportFile() || importFile()")
    public void anyOperation(){}

    @AfterReturning("anyOperation() && args(.., auditLog)")
    public void doAfterReturnAudit(JoinPoint jp, AuditLog auditLog) {
    	logger.debug("==========进入doAfterReturnAudit=========== \n");
    	auditLogService.save(auditLog);
    	logger.debug("切入点方法doAfterReturnAudit执行完了 \n");
    }


    /**
      * doBeforeAuditBatch 批量操作
      * @Title: doBeforeAuditBatch
      * @Description: 批量操作
      * @param @param jp
      * @param @param auditLogArr
      * @return void
      * @throws
     */
    @AfterReturning("anyOperation() && args(.., auditLogArr[])")
    public void doAfterReturnAuditBatch(JoinPoint jp, AuditLog [] auditLogArr) {
    	logger.debug("==========进入doAfterReturnAuditBatch=========== \n");
    	for(AuditLog auditLog : auditLogArr){
    		auditLogService.save(auditLog);
    	}
    	logger.debug("切入点方法doAfterReturnAuditBatch执行完了 \n");
    }

    @AfterReturning("delete() && args(.., auditLog)")
    public void doAfterDeleteAudit(JoinPoint jp, AuditLog auditLog) {
    	logger.debug("==========进入doAfterDeleteAudit=========== \n");
    	recycleBinService.save(convertRecyclebinByAuditLog(auditLog));
    	logger.debug("切入点方法doAfterDeleteAudit执行完了 \n");
    }

    @AfterReturning("delete() && args(.., auditLogArr[])")
    public void doAfterDeleteAuditBatch(JoinPoint jp, AuditLog [] auditLogArr) {
    	logger.debug("==========进入doAfterDeleteAuditBatch=========== \n");
    	for(AuditLog auditLog : auditLogArr){
    		recycleBinService.save(convertRecyclebinByAuditLog(auditLog));
    	}
    	logger.debug("切入点方法doAfterDeleteAuditBatch执行完了 \n");
    }

    /**
      * convertRecyclebinByAuditLog
      * @Title convertRecyclebinByAuditLog
      * @Description 通过审计日志构造回收站对象
      * @param auditLog
      * @param 参数类型
      * @return RecycleBin
     */
    private RecycleBin convertRecyclebinByAuditLog(AuditLog auditLog){
    	return new RecycleBin(auditLog.getModuleName(), auditLog.getRecordId(), auditLog.getRecordName(),
    			auditLog.getCreator(), auditLog.getRemark());

    }
}
