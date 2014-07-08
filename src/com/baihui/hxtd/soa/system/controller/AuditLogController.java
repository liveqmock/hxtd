package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.service.AuditLogService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 
 * 功能描述：审计日志控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo
 * @company 北京百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.setting.controller.AuditLogController.java
 * @version (版本) 1
 * @date 2014-6-20 上午11:17:53
 */
@Controller
@RequestMapping(value = "/system/auditlog")
public class AuditLogController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private AuditLogService auditLogService;
	
	@RequestMapping(value = "/toQueryPage.do")
	
    public String toQueryPage(@RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "createdTime") String orderBy,
            @RequestParam(value = "pageOrder", defaultValue = "desc") String order,
            Model model) {
        logger.info("AuditLogController.query跳转列表页");
        
        HibernatePage<AuditLog> page = new HibernatePage<AuditLog>(pageNumber, pageSize);
        page.setHibernateOrderBy(orderBy);
        page.setHibernateOrder(order);
        convertResult(model);
        model.addAttribute("page", page);
        return "/system/auditlog/list";
    }
	
	/**
	  * query(异步分页查询)
	  * @Description: 异步查询联系人数据
	  * @param page 分页查询结果集
	  * @param out PrintWriter
	  * @throws NoSuchFieldException,IOException
	 */
	@RequestMapping(value = "/query.do")
	public void query(HttpServletRequest request,
			HibernatePage<AuditLog> page,
           PrintWriter out) throws NoSuchFieldException, IOException {
		logger.info("获取查询条件");

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "createdTime");
		logger.debug("查询条件数目“{}”", searchParams.size());
		logger.info("添加默认的查询条件");
		logger.info("获取分页数据");
		page = auditLogService.findPage(searchParams, page);
		logger.info("以DTO格式返回");
		JsonDto json = new JsonDto();
		json.setSuccessFlag(true);
		json.setMessage("请求数据成功！");
		json.setResult(page);
       
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	
	/**
	 * 操作类型和模块名称转换成对应中文
	 * @param model
	 */
	private void convertResult(Model model){
		Map<Integer,String> operationTypes=new HashMap<Integer,String>();
        operationTypes.put(1,"增加");
        operationTypes.put(2,"修改");
        operationTypes.put(3,"逻辑删除");
        operationTypes.put(4,"删除");
        operationTypes.put(5,"导入");
        operationTypes.put(6,"导出");
        operationTypes.put(7,"授权");
        operationTypes.put(8,"重置密码");
        operationTypes.put(9,"启用用户");
        operationTypes.put(10,"禁用用户");
        model.addAttribute("operationTypes", operationTypes);//操作类型
        Map<EnumModule,String> moduleNames=new HashMap<EnumModule,String>();
        moduleNames.put(EnumModule.MARKETACTIVITY, "市场活动");
        moduleNames.put(EnumModule.LEAD, "线索");
        moduleNames.put(EnumModule.CONTACT, "联系人");
        moduleNames.put(EnumModule.CUSTOMER, "客户");
        moduleNames.put(EnumModule.SUPPILER, "供应商");
        moduleNames.put(EnumModule.PROJECT, "项目");
        moduleNames.put(EnumModule.PRODUCT, "产品");
        moduleNames.put(EnumModule.ORDER, "订单");
        moduleNames.put(EnumModule.USER, "用户");
        moduleNames.put(EnumModule.ROLE, "角色");
        moduleNames.put(EnumModule.MENU, "菜单");
        moduleNames.put(EnumModule.FUNCTION, "功能");
        moduleNames.put(EnumModule.COMPONENT, "组件");
        moduleNames.put(EnumModule.ORGANIZATION, "组织机构");
        moduleNames.put(EnumModule.USERMESSAGE, "系统消息");
        moduleNames.put(EnumModule.NOTICE, "系统公告");
        moduleNames.put(EnumModule.DICTIONARY, "数据字典");
        model.addAttribute("moduleNames", moduleNames);//模块名称
	}
	
}
