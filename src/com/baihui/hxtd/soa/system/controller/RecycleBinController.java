package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.market.entity.MarketActivity;
import com.baihui.hxtd.soa.market.service.MarketActivityService;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.RecycleBinService;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 
 * 功能描述：回收站控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo
 * @company 北京百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.setting.controller.RecycleBinController.java
 * @version (版本) 1
 * @date 2014-6-20 上午11:17:53
 */
@Controller
@RequestMapping(value = "/system/recyclebin")
@SessionAttributes(value = { Constant.VS_USER_ID, Constant.VS_USER, Constant.VS_DATASHIFT})
public class RecycleBinController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
    private CommonService commonService;
	
	@RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(@RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "operateTime") String orderBy,
            Model model) {
        logger.info("FunctionController.query跳转列表页");
       
        HibernatePage page = new HibernatePage(pageNumber, pageSize);;
        page.setHibernateOrderBy(orderBy);
        //page.setHibernateOrder(order);
        model.addAttribute("page", page);
        return "/system/recyclebin/list";
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
			HibernatePage page,
			ModelMap model,
           PrintWriter out,
           @RequestParam(required=true)String type,
           @RequestParam(required=false)String recordName,
           @RequestParam(required=false)Long deletorId,
           @RequestParam(required=false)Date gteModifiedTime,
           @RequestParam(required=false)Date lteModifiedTime
           ) throws NoSuchFieldException, IOException {
		logger.info("获取查询条件");

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		logger.debug("查询条件数目“{}”", searchParams.size());
		logger.info("添加默认的查询条件");
		logger.info("获取分页数据");
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
		page = commonService.getDeletedDate(page, type,recordName,deletorId,gteModifiedTime,lteModifiedTime);
		logger.info("以DTO格式返回");
		JsonDto json = new JsonDto();
		json.setSuccessFlag(true);
		json.setMessage("请求数据成功！");
		json.setResult(page);
       
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	/**
     * 物理删除回收站中的数据
     */
	@ResponseBody
    @RequestMapping(value = "/delete.do", produces = "text/text;charset=UTF-8")
    public String delete(@RequestParam(required=true)String entityName,
    		HttpServletRequest request,
    		Long... id) {
        logger.info("ComponentController.delete删除回收站数据id={}", id);
        commonService.delete(entityName, id);
        JsonDto json = new JsonDto();
        json.setMessage("删除成功");
        return json.toString();
    }
	
	/**
     * 还原回收站中的数据
     */
	@ResponseBody
    @RequestMapping(value = "/recovery.do", produces = "text/text;charset=UTF-8")
    public String recovery(@RequestParam(required=true)String entityName,
    		HttpServletRequest request,
    		Long... id) {
        logger.info("ComponentController.delete还原回收站数据id={}", id);
        commonService.recovery(entityName, id);
        JsonDto json = new JsonDto();
        json.setMessage("恢复数据成功!");
        return json.toString();
    }
	
}
