package com.baihui.hxtd.soa.setting.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.baihui.hxtd.soa.setting.entity.AuditLog;
import com.baihui.hxtd.soa.setting.service.AuditLogService;
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
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@RequestMapping(value = "/setting/auditlog")
public class AuditLogController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private AuditLogService auditLogService;
	
	
	/*@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(HibernatePage<T> page, Model model) {
		model.addAttribute("page", page);
		
		return "/setting/auditlog/list";
	}*/
	@RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(@RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            Model model) {
        logger.info("FunctionController.query跳转列表页");
        HibernatePage<AuditLog> page = new HibernatePage<AuditLog>(pageNumber, pageSize);
        //page.setHibernateOrderBy(orderBy);
        //page.setHibernateOrder(order);
        model.addAttribute("page", page);
        return "/setting/auditlog/list";
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
}
