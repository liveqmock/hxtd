
package com.baihui.hxtd.soa.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.project.entity.Product;
import com.baihui.hxtd.soa.project.service.ProductService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 
 * 功能描述：产品(基金)控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.project.controller.ProductController.java
 * @version (版本) 1
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@RequestMapping(value = "/project/product")
@SessionAttributes(value = { Constant.VS_USER_ID, Constant.VS_USER})
public class ProductController {

	//IOC注入
	@Resource
    private ProductService productService;
	@Resource
	private DictionaryService dicService;
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
	
	/**
	  * toQueryPage(跳转列表页)
	  * @Description: 请求查看产品列表
	  * @param page 分页
	  * @param model Model
	  * @return String 产品列表页地址
	 */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(HibernatePage<Product> page, Model model) {
		model.addAttribute("page", page);
		
		return "/project/product/list";
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
    		HibernatePage<Product> page,
            PrintWriter out) throws NoSuchFieldException, IOException {
		/************获取查询条件**************/
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        
        /************分页查询*****************/
        productService.findPage(searchParams, page);
        
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
		
		Product product = new Product();
		product.setCode(new SimpleDateFormat("yyyyMMddHHmmssms").format(new Date()));
		//product.setSaleBeginTime(new Date());
		//product.setSaleEndTime(new Date());
		model.addAttribute("product", product);

		return "/project/product/edit";
	}
	
	/**
	  * add(新增产品)
	  * @Description: 新增一条产品记录
	  * @param product 产品实体
	  * @param redirectUri url地址
	  * @param userId 操作用户ID
	  * @return String 修改页地址信息
	 */
	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String add(Product product, 
			@RequestParam(defaultValue = "/project/product/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		/************设置修改者、创建者****************/
		User user = new User(userId);
		Date date = new Date();
		product.setCreator(user);
		product.setCreatedTime(date);
		product.setModifier(user);
		
		/************保存*****************************/
		productService.save(product);
		
		return "redirect:" + String.format(redirectUri, product.getId());
	}
	
	/**
	  * toModifyPage(跳转至修改页面)
	  * @Description: 请求修改产品记录页
	  * @param id 产品主键ID
	  * @param model Model
	  * @return String 编辑页地址信息
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(Long id, ModelMap model) {
		/************获取数据字典**********************/
		initPageDic(model);
		
		model.addAttribute("product", productService.get(id));
		
		return "/project/product/edit";
	}
	
	/**
	  * modify(修改产品)
	  * @Description: 保存修改后的产品信息
	  * @param activity 产品实体
	  * @param redirectUri Url地址
	  * @param userId 操作用户ID
	  * @param request HttpServletRequest
	  * @return String 编辑页地址信息
	 */
	@RequestMapping(value = "/modify.do")
	public String modify(Product product, 
			@RequestParam(defaultValue = "/project/product/toModifyPage.do?id=%s") String redirectUri,
			@ModelAttribute(Constant.VS_USER_ID) Long userId,
			HttpServletRequest request) {
		product.setModifier(new User(userId));
		productService.save(product);
		
		return String.format("redirect:" + redirectUri, product.getId());
	}
	
	/**
	  * toViewPage(查看产品记录)
	  * @Description: 查看产品记录
	  * @param id 产品主键ID
	  * @param model Model
	  * @return String 查看页地址
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String toViewPage(Long id, Model model) {
		Product activity = productService.get(id);
		model.addAttribute("product", activity);
		
		return "/project/product/view";
	}

	/**
	  * delete(删除产品记录)
	  * @Description: 删除产品记录，支持批量删除
	  * @param id 产品主键ID集合
	  * @return String Json串
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do")
	public String delete(Long[] id) {
		productService.delete(id);
		
		JsonDto json = new JsonDto("删除成功");
		json.setSuccessFlag(true);
		
		return json.toString();
	}
	
	/**
	  * initPageDic(初始化页面字典)
	  * @Description: 获取视图字典数据
	  * @param model Model
	 */
	private void initPageDic(ModelMap model){
		model.addAttribute("dicUnit", dicService.findChildren(DictionaryConstant.VC_DEADLINEUNIT, true));// 期限单位
		model.addAttribute("dicType", dicService.findChildren(DictionaryConstant.VC_PRODUCTTYPE, true));// 产品类型
	}
}
