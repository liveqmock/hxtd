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
 * 1.新增
 * 2.修改
 * 3.逻辑删除
 * 4.物理删除 AuditLogController.delete
 * 忽略查询、查看
 */
@Component
@Aspect
public class AuditLogAspect {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private AuditLogService auditLogService;
    
    @Pointcut("execution(* com.baihui.hxtd.soa.*.service..delete(..))")
    public void delete() {
    	
    }
    
    @Pointcut("execution(* com.baihui.hxtd.soa.*.service..add(..))")
    public void add(){
    	System.out.println("AuditLogAspect add");
    }
    
    @Pointcut("execution(* com.baihui.hxtd.soa.*.service..modify(..))")
    public void modify(){
    	System.out.println("AuditLogAspect modify");
    }


    /**
     * 为逻辑删除功能添加审计日志
     * @param jp
     * @param result
     */
    @AfterReturning(pointcut = "(delete() || add() || modify()) && args(.., auditLog)")
    public void doAfter(JoinPoint jp, AuditLog auditLog) {
    	logger.debug("==========进入after advice=========== \n");
    	auditLogService.save(auditLog);
    	logger.debug("切入点方法执行完了 \n");
    }
    
}
