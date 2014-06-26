
package com.baihui.hxtd.soa.market.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.market.entity.MarketActivity;
import com.baihui.hxtd.soa.market.service.MarketActivityService;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 
 * 功能描述：市场活动控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.MarketActivityController.java
 * @version (版本) 1
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@RequestMapping(value = "/market/marketactivity")
@SessionAttributes(value = { Constant.VS_USER_ID, Constant.VS_USER, Constant.VS_DATASHIFT})
public class MarketActivityController {

	//IOC注入
	@Resource
    private MarketActivityService marketActivityService;
	@Resource
	private DictionaryService dicService;
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
	
	/**
	  * toQueryPage(跳转列表页)
	  * @Description: 请求查看活动列表
	  * @param page 分页
	  * @param model Model
	  * @return String 活动列表页地址
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(HibernatePage<MarketActivity> page, ModelMap model) {
		model.addAttribute("page", page);
		initPageDic(model);
		
		return "/market/marketactivity/list";
	}
	
	/**
	  * anscyQuery(异步加载数据列表)
	  * @Description: 分页异步加载数据
	  * @param request HttpServletRequest
	  * @param page 分页
	  * @throws NoSuchFieldException 字段异常
	 */
    @RequestMapping(value = "/query.do")
    public void anscyQuery(HttpServletRequest request,
    		HibernatePage<MarketActivity> page,
    		ModelMap model,
            PrintWriter out) throws NoSuchFieldException, IOException {
		/************获取查询条件**************/
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "createdTime");
        Search.toMinDate(searchParams, "beginDate");
        Search.toMaxDate(searchParams, "endDate");
        Search.toRangeDate(searchParams, "modifiedTime");
        DataShift dataShift = (DataShift) model.get(Constant.VS_DATASHIFT);
        
        /************分页查询*****************/
        marketActivityService.findPage(searchParams, dataShift, page);
        
        /************json转换****************/
        JsonDto json = new JsonDto();
		json.setResult(page);
        
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	
	/**
	  * toAddPage(跳转至新增活动页)
	  * @Description: 请求新增活动页
	  * @param model ModelMap
	  * @return String 新增活动地址页
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage(ModelMap model) {
		/************获取数据字典**********************/
		initPageDic(model);
		
		/************初始化活动(发起者)****************/
		User user = (User) model.get(Constant.VS_USER);
		Date date = new Date();
		MarketActivity entity = new MarketActivity();
		entity.setSponsor(user);
		entity.setTimes(Long.parseLong("1"));
		entity.setBeginDate(date);
		entity.setEndDate(date);
		model.addAttribute("activity", entity);

		return "/market/marketactivity/edit";
	}
	
	/**
	  * add(新增市场活动)
	  * @Description: 新增一条市场活动记录
	  * @param activity 市场活动实体
	  * @param redirectUri url地址
	  * @param userId 操作用户ID
	  * @return String 修改页地址信息
	 */
	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String add(MarketActivity activity, 
			@RequestParam(defaultValue = "/market/marketactivity/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		/************设置修改者、创建者****************/
		User user = new User(userId);
		Date date = new Date();
		activity.setSponsor(user);
		activity.setCreator(user);
		activity.setCreatedTime(date);
		activity.setModifier(user);
		if(activity.getStatus().getId() == null){
			activity.setStatus(null);
		}
		if(activity.getDic().getId() == null){
			activity.setDic(null);
		}
		
		/************保存*****************************/
		marketActivityService.save(activity);
		
		return "redirect:" + String.format(redirectUri, activity.getId());
	}
	
	/**
	  * toModifyPage(跳转至修改页面)
	  * @Description: 请求修改活动记录页
	  * @param id 活动主键ID
	  * @param model Model
	  * @return String 编辑页地址信息
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(Long id, ModelMap model) {
		/************获取数据字典**********************/
		initPageDic(model);
		
		model.addAttribute("activity", marketActivityService.get(id));
		
		return "/market/marketactivity/edit";
	}
	
	/**
	  * modify(修改活动)
	  * @Description: 保存修改后的活动信息
	  * @param activity 活动实体
	  * @param redirectUri Url地址
	  * @param userId 操作用户ID
	  * @param request HttpServletRequest
	  * @return String 编辑页地址信息
	 */
	@RequestMapping(value = "/modify.do")
	public String modify(MarketActivity activity, 
			@RequestParam(defaultValue = "/market/marketactivity/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId,
			HttpServletRequest request) {
		activity.setModifier(new User(userId));
		marketActivityService.save(activity);
		
		return String.format("redirect:" + redirectUri, activity.getId());
	}
	
	/**
	  * toViewPage(查看活动记录)
	  * @Description: 查看活动记录
	  * @param id 活动主键ID
	  * @param model Model
	  * @return String 查看页地址
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String toViewPage(Long id, Model model) {
		MarketActivity activity = marketActivityService.get(id);
		model.addAttribute("activity", activity);
		
		return "/market/marketactivity/view";
	}

	/**
	  * delete(删除活动记录)
	  * @Description: 删除活动记录，支持批量删除
	  * @param id 活动主键ID集合
	  * @return String Json串
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do")
	public String delete(long[] id) {
		marketActivityService.delete(id);
		
		JsonDto json = new JsonDto("删除成功");
		json.setSuccessFlag(true);
		
		return json.toString();
	}
	
	/**
	  * exportPagination(列表页导出数据)
	  * @Description: 导出3000条市场活动记录
	  * @param request HttpServletRequest
	  * @param response HttpServletResponse
	  * @param modelMap ModelMap
	  * @throws NoSuchFieldException,IOException
	 */
	@RequestMapping(value = "/export.do", params = "TYPE=pagination")
	public void exportPagination(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap modelMap) throws NoSuchFieldException, IOException{
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        
        DataShift dataShift = (DataShift) modelMap.get(Constant.VS_DATASHIFT);
        List<MarketActivity> marketActivityLst = marketActivityService.export(searchParams, dataShift);
        
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "marketactivity", marketActivityLst).write(response.getOutputStream());
	}
	
	/**
	  * initPageDic(初始化页面字典)
	  * @Description: 获取视图字典数据
	  * @param model Model
	 */
	private void initPageDic(ModelMap model){
		model.addAttribute("dicStatus", dicService.findChildren("030102"));// 活动状态
		model.addAttribute("dicType", dicService.findChildren("030101"));// 活动类型
	}
}
