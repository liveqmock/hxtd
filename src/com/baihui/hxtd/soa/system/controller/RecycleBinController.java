package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.RecycleBin;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.RecycleBinService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 
 * 功能描述：回收站控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author huizijing
 * @company 北京百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.setting.controller.RecycleBinController.java
 * @version (版本) 1
 * @date 2014-7-7 
 */
@Controller
@RequestMapping(value = "/system/recyclebin")
@SessionAttributes(value = { Constant.VS_USER_ID, Constant.VS_USER, Constant.VS_DATASHIFT})
public class RecycleBinController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
    private RecycleBinService recycleBinService;
	
	@RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(@RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "createdTime") String orderBy,
            @RequestParam(value = "pageOrder", defaultValue = "desc") String order,
            Model model) {
        logger.info("RecycleBinController.query.do跳转列表页");
       
        HibernatePage<RecycleBin> page = new HibernatePage<RecycleBin>(pageNumber, pageSize);;
        page.setHibernateOrderBy(orderBy);
        page.setHibernateOrder(order);
        model.addAttribute("page", page);
        model.addAttribute("moduleNames", EnumModule.values());//模块名称
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
	public void query(HttpServletRequest request,HibernatePage<RecycleBin>  page,ModelMap model,
           PrintWriter out) throws NoSuchFieldException, IOException {
		logger.info("获取查询条件");

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "createdTime");
		logger.debug("查询条件数目“{}”", searchParams.size());
		logger.info("添加默认的查询条件");
		logger.info("获取分页数据");
		DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
		page=recycleBinService.findPage(searchParams, page,dataShift);
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
    public String delete(Long[] id,HttpServletRequest request) {
		logger.info("RecycleBinController.delete删除回收站数据id={}", StringUtils.join(id,","));
		List<Long> recordIds = new ArrayList<Long>();
		List<Long> ids = new ArrayList<Long>();
		List<String> entityName = new ArrayList<String>();
	    List<RecycleBin> recycleBinList = recycleBinService.getByIds(id);
	    for(int i=0;i<recycleBinList.size();i++){
	    	recordIds.add(recycleBinList.get(i).getRecordId());
	    	ids.add(recycleBinList.get(i).getId());
	    	entityName.add(recycleBinList.get(i).getModuleName());
	    }
	    User user = (User) request.getSession().getAttribute(Constant.VS_USER);
	    //得到RecycleBin.id
	    Long[] idArr=(Long[]) ids.toArray(new Long[0]);
	    for(int i=0;i<entityName.size();i++){
	    	AuditLog [] auditLogArr = new AuditLog [idArr.length];
    		for(int j=0; j<idArr.length; j++){
    			auditLogArr[j] = new AuditLog(EnumModule.RECYCLEBIN.getModuleName(), 
   					idArr[j], recycleBinList.get(i).getRecordName(), EnumOperationType.DELETEREAL.getOperationType(), user,"真实删除数据");
    		}
    		recycleBinService.realDelete(entityName.get(i), (Long[]) recordIds.toArray(new Long[0]), auditLogArr);
	    }
	    recycleBinService.delete(idArr);
        return JsonDto.delete(id).toString();
    }
	
	/**
     * 还原回收站中的数据
     */
	@ResponseBody
    @RequestMapping(value = "/recovery.do", produces = "text/text;charset=UTF-8")
    public String recovery(Long[] id,HttpServletRequest request) {
		logger.info("RecycleBinController.recovery还原回收站数据id={}", StringUtils.join(id,","));
		List<Long> recordIds = new ArrayList<Long>();
		List<Long> ids = new ArrayList<Long>();
		List<String> entityName=new ArrayList<String>();
	    List<RecycleBin> recycleBinList=recycleBinService.getByIds(id);
	    for(int i=0;i<recycleBinList.size();i++){
	    	recordIds.add(recycleBinList.get(i).getRecordId());
	    	ids.add(recycleBinList.get(i).getId());
	    	entityName.add(recycleBinList.get(i).getModuleName());
	    }
	    User user = (User) request.getSession().getAttribute(Constant.VS_USER);
	    //得到RecycleBin.id
	    Long[] idArr=(Long[]) ids.toArray(new Long[0]);
	    for(int i=0;i<entityName.size();i++){
	    	AuditLog [] auditLogArr = new AuditLog [idArr.length];
    		for(int j=0; j<idArr.length; j++){
    			auditLogArr[j] = new AuditLog(EnumModule.RECYCLEBIN.getModuleName(), 
   					idArr[j], recycleBinList.get(i).getRecordName(), EnumOperationType.RECOVERY.getOperationType(), user,"还原删除数据");
    		}
	    	recycleBinService.recovery((Long[]) recordIds.toArray(new Long[0]),entityName.get(i),auditLogArr);
	    }
	    recycleBinService.delete(idArr);
        JsonDto json = new JsonDto();
        json.setMessage("恢复数据成功!");
        return json.toString();
    }
	
	
}
