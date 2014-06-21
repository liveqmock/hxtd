
package com.baihui.hxtd.soa.project.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.project.service.SupplierService;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

@Controller
@RequestMapping(value = "/project/supplier")
public class SupplierController {
	
	 private Logger logger = LoggerFactory.getLogger(this.getClass());
	 /**
	  * 注入service
	  */
	 @Resource
	 private SupplierService supplierService;
	 
	 @Resource
	 private DictionaryService dictionaryService;
	 /**
	 * @throws NoSuchFieldException 
	   * query(分页查询)
	   * @Title: query
	   * @param @param page
	   * @param @return    参数类型
	   * @return ModelAndView    返回类型
	   * @throws
	  */
	@RequestMapping(value = "/query.do",produces = "text/text;charset=UTF-8")
	@ResponseBody
	public String query(HibernatePage<Supplier> page,
								HttpServletRequest request) throws NoSuchFieldException{
		logger.info("SupplierController.query查询组件列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		page = supplierService.findPage(searchParams, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		return json.toString();
	}
	
	 /**
	   * toQueryPage(跳转列表页)
	   * @Title: toQueryPage
	   * @param @param 
	   * @param @return    参数类型
	   * @return ModelAndView    返回类型
	   * @throws
	  */
	@RequestMapping(value = "/toQueryPage.do")
	public String toQueryPage(ModelMap model) throws NoSuchFieldException {
        logger.info("转至查询页面");

        logger.info("存储表单初始化数据");

        logger.info("存储表单默认值");
        HibernatePage<Supplier> page = new HibernatePage<Supplier>();
        model.addAttribute("page", page);
		List<Dictionary> dict = dictionaryService.findChildren("050101");
		model.addAttribute("dict",dict);
		return "/project/supplier/list";
	}
	/**
	  * view(查询单个组件信息)
	  * @Title: view
	  * @param @param type
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view( @RequestParam(required=false)String type,
							  @RequestParam(required=false)Long id,
							  Model model){
		logger.info("SupplierController.view查询组件");
		String funcUrl="";
		String returnStr="/project/supplier/view";
		Supplier com = null;
		if("edit".equals(type)){
			funcUrl="/project/supplier/modify.do";
			returnStr= "/project/supplier/edit";
		}
		com = supplierService.get(id);
		List<Dictionary> dict = dictionaryService.findChildren("050101");
		model.addAttribute("dict",dict);
		model.addAttribute("com",com);
		model.addAttribute("funcUrl", funcUrl);
		return returnStr;
	}
	
	/**
	  * toAddPage(跳转新增页面)
	  * @Title: view
	  * @param @param type
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage(Model model){
		logger.info("SupplierController.view查询组件");
		String funcUrl="/project/supplier/add.do";
		List<Dictionary> dict = dictionaryService.findChildren("050101");
		model.addAttribute("dict",dict);
		model.addAttribute("funcUrl", funcUrl);
		return "/project/supplier/edit";
	}
	/**
	 * 
	  * toModifyPage(跳转修改页面)
	  * @Title: toModifyPage
	  * @param @param id
	  * @param @param model
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/toModifyPage.do")
	public String toModifyPage(@RequestParam(required=false)Long id,
							  Model model){
		logger.info("SupplierController.toModifyPage查询组件");
		String funcUrl="/project/supplier/modify.do";
		Supplier com  = supplierService.get(id);
		List<Dictionary> dict = dictionaryService.findChildren("050101");
		model.addAttribute("dict",dict);
		model.addAttribute("com",com);
		model.addAttribute("funcUrl", funcUrl);
		return "/project/supplier/edit";
	}
	/**
	  * modify(保存：修改)
	  * @Title: modify
	  * @param  Supplier组件实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/modify.do")
	public String modify(Supplier supplier,String type,HttpServletRequest request){
		logger.info("SupplierController.modify修改组件信息");
		supplier.setCreatedTime(new java.util.Date());
		supplier.setModifiedTime(new java.util.Date());
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}",u.getName());
		supplier.setModifier(u);
		supplierService.save(supplier);
		if("add".equals(type)){
			return "redirect:/project/supplier/toAddPage.do";
		}
		return "redirect:/project/supplier/toViewPage.do?id="+supplier.getId();
	}
	/**
	 * 
	  * add(保存：新建)
	  * @Title: add
	  * @param  Supplier组件实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/add.do")
	public String add(Supplier supplier,String type,HttpServletRequest request){
		logger.info("SupplierController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		supplier.setCreatedTime(new java.util.Date());
		supplier.setModifiedTime(new java.util.Date());
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("SupplierController.query 获得当前操作的用户{}",u.getName());
		supplier.setCreator(u);
		supplier.setModifier(u);
		supplierService.save(supplier);
		if("add".equals(type)){
			return "redirect:/project/supplier/toAddPage.do";
		}
		return "redirect:/project/supplier/toViewPage.do?id="+supplier.getId();
	}
	/**
	 * 
	  * delete(保存：新建)
	  * @Title: delete
	  * @param  Supplier组件实体类对象
	  * @return  view  
	  * @return String    返回类型
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(Long[] id){
		logger.info("SupplierController.delete删除组件");
		supplierService.delete(id);
		JsonDto json = new JsonDto();
		json.setMessage("删除成功");
		return json.toString();
	}
	
	/**
     * toSupplierLstPage(跳转至供应商组件列表界面)
     * todo: lihua 2014-05-22
     */
    @RequestMapping(value = "/toQueryPage.comp")
    public String toSupplierLstPage(
            @RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "createdTime") String orderBy,
            @RequestParam(value = "order", defaultValue = "asc") String order,
            HttpServletRequest request, Model model) throws NoSuchFieldException {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Search.clearBlankValue(searchParams);
        
        HibernatePage<Supplier> page=new HibernatePage<Supplier>(pageNumber, pageSize);
        page.setHibernateOrderBy(orderBy);
        page.setHibernateOrder(order);
        supplierService.findPage(searchParams, page);
        
        JsonDto jsonDto = new JsonDto();
        jsonDto.setResult(page);
        model.addAttribute("jsondata", jsonDto.toString());
        
        return "/project/supplier/listcomp";
    }
}
