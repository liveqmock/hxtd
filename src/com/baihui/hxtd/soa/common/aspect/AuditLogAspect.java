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
import com.baihui.hxtd.soa.system.service.AuditLogService;

/**
 * 审计日志切面
 */
@Component
@Aspect
public class AuditLogAspect {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private AuditLogService auditLogService;
    
    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..add*(..))")
    public void add(){}
    
    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..modify*(..))")
    public void modify(){}
    
    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..delete*(..))")
    public void delete(){}
    
    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..export*(..))")
    public void exportFile(){}
    
    @Pointcut("execution(public * com.baihui.hxtd.soa.*.service..import*(..))")
    public void importFile() {}
    
    @Pointcut("add() || modify() || delete() || exportFile() || importFile()")
    public void anyOperation(){}
    
    @AfterReturning("anyOperation() && args(.., auditLog)")
    public void doBeforeAudit(JoinPoint jp, AuditLog auditLog) {
    	logger.debug("==========进入after advice=========== \n");
    	auditLogService.save(auditLog);
    	logger.debug("切入点方法执行完了 \n");
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
    public void doBeforeAuditBatch(JoinPoint jp, AuditLog [] auditLogArr) {
    	logger.debug("==========进入after advice=========== \n");
    	for(AuditLog auditLog : auditLogArr){
    		auditLogService.save(auditLog);
    	}
    	logger.debug("切入点方法执行完了 \n");
    }
    
}
