package com.baihui.hxtd.soa.common.aspect;

import com.baihui.hxtd.soa.customer.entity.Contact;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.customer.entity.Lead;
import com.baihui.hxtd.soa.customer.service.ContactService;
import com.baihui.hxtd.soa.customer.service.CustomerService;
import com.baihui.hxtd.soa.customer.service.LeadService;
import com.baihui.hxtd.soa.market.entity.MarketActivity;
import com.baihui.hxtd.soa.market.service.MarketActivityService;
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.order.service.OrderService;
import com.baihui.hxtd.soa.project.entity.Product;
import com.baihui.hxtd.soa.project.entity.Project;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.project.service.ProductService;
import com.baihui.hxtd.soa.project.service.ProjectService;
import com.baihui.hxtd.soa.project.service.SupplierService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.AuditLogService;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.UserService;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

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
	private DictionaryService dictionaryService;

    @Resource
    private AuditLogService auditLogService;

    @Resource
    private MarketActivityService marketActivityService;
    
    @Resource
    private LeadService leadService;
    
    @Resource
    private CustomerService customerService;
    
    @Resource
    private ContactService contactService;
    
    @Resource
    private ProductService productService;
    
    @Resource
    private ProjectService projectService;
    
    @Resource
    private SupplierService supplierService;
    
    @Resource
    private UserService userService;
    
    @Resource
    private OrderService orderService;
   
    private  AuditLog auditLog = null;


    @Pointcut("execution(* com.baihui.hxtd.soa.*.service..delete(..))")
    public void delete() {
    }
    @Pointcut("execution(* com.baihui.hxtd.soa.*.service..add(..))")
    public void add(){
    }
    @Pointcut("execution(* com.baihui.hxtd.soa.*.service..modify(..))")
    public void modify(){
    }



    /**
     * 为逻辑删除功能添加审计日志
     * @param jp
     * @param result
     */
    @AfterReturning(value = "delete()")
    public void doAfterDelete(JoinPoint jp) {
    	logger.debug("==========进入after advice=========== \n");
    	logger.debug("切入点方法执行完了 \n");
        auditLog = new AuditLog();
        //获取删除的第一个参数,即获取删除的id
        Long[] ids = (Long[]) jp.getArgs()[1];
        
        //获取当前的controller类对应的entity实体类
        String entityName = getEntityName(jp);
        setAuditLogDelete(entityName,ids);
        Dictionary dc = dictionaryService.getDicEntity(10040103l);
        auditLog.setType(dc);
        User user = (User)jp.getArgs()[0];
        //设置获取操作人
        auditLog.setOperator(user);
        auditLogService.save(auditLog);

        logger.debug("id:["+jp.getArgs()[0] + "]的记录,在"+jp.getTarget().getClass() + "对象上被"+jp.getSignature().getName() + "方法删除了");
        //logger.debug("只留下：" + result + "\n\n");
    }
    
    /**
     * 为新增功能添加审计日志
     * @param jp
     * @param result
     */
    @AfterReturning(value = "add()")
    public void doAfterAdd(JoinPoint jp){
    	logger.debug("==========进入add after advice=========== \n");
    	logger.debug("切入点方法执行完了 \n");
    	 auditLog = new AuditLog();
         //获取当前的service类对应的entity实体类
         String entityName = getEntityName(jp);
         //为suditLog赋值
         setAuditLogAddOrModify(entityName,jp);
         Dictionary dc = dictionaryService.get(10040101l);
         auditLog.setType(dc);
         //设置获取操作人
         auditLog.setOperator((User)jp.getArgs()[1]);
         auditLogService.save(auditLog);

         logger.debug("id:["+jp.getArgs()[0] + "]的记录,在"+jp.getTarget().getClass() + "对象上被"+jp.getSignature().getName() + "方法删除了");
    }
    
    
    /**
     * 修改数据时,记录审计日志
     * @param jp
     * @param result
     */
    @AfterReturning(value = "modify()")
    public void doAfterModify(JoinPoint jp){
    	logger.debug("==========进入modify after advice=========== \n");
    	logger.debug("切入点方法执行完了 \n");
    	 auditLog = new AuditLog();
    	//获取当前的service类对应的entity实体类
         String entityName = getEntityName(jp);
         //setAuditLog(entityName,id);
         setAuditLogAddOrModify(entityName,jp);
         Dictionary dc = dictionaryService.get(10040102l);
         auditLog.setType(dc);
         //设置获取操作人
         auditLog.setOperator((User)jp.getArgs()[1]);
         auditLogService.save(auditLog);

         logger.debug("id:["+jp.getArgs()[0] + "]的记录,在"+jp.getTarget().getClass() + "对象上被"+jp.getSignature().getName() + "方法删除了");
    }
    

    // 环绕通知（##环绕通知的方法中一定要有ProceedingJoinPoint 参数,与
    //Filter中的  doFilter方法类似）
//
//    @Around(value = "service()")
//    public Object doAround(ProceedingJoinPoint pjp) throws Throwable {
//        System.out.println("===========进入around环绕方法！=========== \n");
//        // 调用目标方法之前执行的动作
//        System.out.println("调用方法之前: 执行！\n");
//
//        // 调用方法的参数
////        Object[] args = pjp.getArgs();
////        // 调用的方法名
////        String method = pjp.getSignature().getName();
////        // 获取目标对象(形如：com.action.admin.LoginAction@1a2467a)
////        Object target = pjp.getTarget();
////        //获取目标对象的类名(形如：com.action.admin.LoginAction)
////        String targetName = pjp.getTarget().getClass().getName();
//        // 执行完方法的返回值：调用proceed()方法，就会触发切入点方法执行
//        Object result = pjp.proceed();//result的值就是被拦截方法的返回值
//
////        System.out.println("输出：" + args[0] + ";" + method + ";" + target + ";" + result + "\n");
//        System.out.println("调用方法结束：之后执行！\n");
//        return result;
//    }
//
//    // 异常通知
//
//    @AfterThrowing(value = "service()", throwing = "e")
//    public void doThrow(JoinPoint jp, Throwable e) {
//        System.out.println("删除出错啦");
//    }
    /**
     * 获取实体类的名称
     */
    public String getEntityName(JoinPoint jp){
    	 String entityName = ""; 
    	 String className = jp.getTarget().getClass().getName();
         String controllerName = className.substring((className.lastIndexOf(".")+1));
         if(controllerName!=null && !controllerName.isEmpty()){
         	entityName = controllerName.substring(0, controllerName.indexOf("Service"));
         }
         return entityName;
    }
    
    public void setAuditLogDelete(String entityName,Long[] ids){
		if (ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				Long id = ids[i];
				auditLog.setRecordId(id);
				if ("Contact".equals(entityName)) {
					Contact contact = contactService.get(id);
					auditLog.setModuleName("联系人");
					auditLog.setRecordName(contact.getName());
					auditLog.setOperateTime(contact.getModifiedTime());
				} else if ("MarketActivity".equals(entityName)) {
					MarketActivity marketActivity = marketActivityService
							.get(id);
					auditLog.setModuleName("市场活动");
					auditLog.setRecordName(marketActivity.getName());
					System.out.println("aaa");
					auditLog.setOperateTime(marketActivity.getModifiedTime());
				} else if ("Customer".equals(entityName)) {
					Customer customer = customerService.get(id);
					auditLog.setModuleName("客户");
					auditLog.setRecordName(customer.getName());
					auditLog.setOperateTime(customer.getModifiedTime());
				} else if ("Lead".equals(entityName)) {
					Lead lead = leadService.get(id);
					auditLog.setModuleName("线索");
					auditLog.setRecordName(lead.getName());
					auditLog.setOperateTime(lead.getModifiedTime());
				} else if ("Product".equals(entityName)) {
					Product product = productService.get(id);
					auditLog.setModuleName("产品");
					auditLog.setRecordName(product.getName());
					auditLog.setOperateTime(product.getModifiedTime());
				} else if ("Project".equals(entityName)) {
					Project project = projectService.get(id);
					auditLog.setModuleName("项目");
					auditLog.setRecordName(project.getName());
					auditLog.setOperateTime(project.getModifiedTime());
				} else if ("Supplier".equals(entityName)) {
					Supplier supplier = supplierService.get(id);
					auditLog.setModuleName("供应商");
					auditLog.setRecordName(supplier.getName());
					auditLog.setOperateTime(supplier.getModifiedTime());
				} else if ("Order".equals(entityName)) {
					Order order = orderService.get(id);
					auditLog.setModuleName("订单");
					//auditLog.setRecordName(order.getName());
					auditLog.setOperateTime(order.getModifiedTime());
				}
			}
		}
	}

    public void setAuditLogAddOrModify(String entityName,JoinPoint jp){
   	 if("Contact".equals(entityName)){
       	 Contact contact = (Contact)jp.getArgs()[0];
       	 auditLog.setModuleName("联系人");
         	 auditLog.setRecordName(contact.getName());
         	 auditLog.setOperateTime(contact.getModifiedTime());
         	 auditLog.setRecordId(contact.getId());
        }else if("MarketActivity".equals(entityName)){
        	MarketActivity marketActivity = (MarketActivity)jp.getArgs()[0];
        	auditLog.setModuleName("市场活动");
        	auditLog.setRecordName(marketActivity.getName());
        	auditLog.setOperateTime(marketActivity.getModifiedTime());
        	auditLog.setRecordId(marketActivity.getId());
        }else if("Customer".equals(entityName)){
        	Customer customer = (Customer)jp.getArgs()[0];
        	auditLog.setModuleName("客户");
        	auditLog.setRecordName(customer.getName());
        	auditLog.setOperateTime(customer.getModifiedTime());
        	auditLog.setRecordId(customer.getId());
        }else if("Lead".equals(entityName)){
        	Lead lead = (Lead)jp.getArgs()[0];
        	auditLog.setModuleName("线索");
        	auditLog.setRecordName(lead.getName());
        	auditLog.setOperateTime(lead.getModifiedTime());
        	auditLog.setRecordId(lead.getId());
        }else if("Product".equals(entityName)){
        	Product product = (Product)jp.getArgs()[0];
        	auditLog.setModuleName("产品");
        	auditLog.setRecordName(product.getName());
        	auditLog.setOperateTime(product.getModifiedTime());
        	auditLog.setRecordId(product.getId());
        }else if("Project".equals(entityName)){
        	Project project = (Project)jp.getArgs()[0];
        	auditLog.setModuleName("项目");
        	auditLog.setRecordName(project.getName());
        	auditLog.setOperateTime(project.getModifiedTime());
        	auditLog.setRecordId(project.getId());
        }else if("Supplier".equals(entityName)){
        	Supplier supplier = (Supplier)jp.getArgs()[0];
        	auditLog.setModuleName("供应商");
        	auditLog.setRecordName(supplier.getName());
        	auditLog.setOperateTime(supplier.getModifiedTime());
        	auditLog.setRecordId(supplier.getId());
        }
   }
}
