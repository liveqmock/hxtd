package com.baihui.hxtd.soa.customer.controller;

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

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.customer.service.CustomerService;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

/**
 * 客户控制器
 * 
 * @author luoxiaoli
 * @version 1.0
 * @date 2014/5/20
 */
@Controller
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_ORG_ORDER_MIN, Constant.VS_ORG_ORDER_MAX, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
@RequestMapping(value = "/customer/customer")
public class CustomerController {

    private Logger logger = LoggerFactory.getLogger(CustomerController.class);
	
	/** 注入CustomerService */
	@Resource
	private CustomerService customerService;
	
	@Resource
	 private DictionaryService dictionaryService;
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
	
	/**
	 * 查询客户列表(从功能按钮跳转)
	 * @param page
	 * @param request
	 * @return
	 * @throws NoSuchFieldException
	 */
	@ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public String query(HttpServletRequest request, HibernatePage<Customer> page, ModelMap model, PrintWriter out) throws NoSuchFieldException {
		logger.info("CustomerController.query查询客户列表");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		logger.info("添加默认的查询条件");
		page = customerService.findPage(searchParams, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
		return json.toString();
	}

	/**
	 * toQueryPage(从菜单跳转,跳转客户列表页)
	 * @param model
	 * @return
	 */
	@RequestMapping("/toQueryPage.do")
	public String toQueryPage(ModelMap  model) {
		logger.info("CustomerController.toQueryPage跳转客户列表页");
		List<Dictionary> dict = dictionaryService.findChildren("040301");
		//HibernatePage<Customer> page = new HibernatePage<Customer>(pageNumber, pageSize);
		StringBuffer sb = new StringBuffer("[");
		for(Dictionary d:dict){
			sb.append("{");
			sb.append("id:"+d.getId()+",");
			//sb.append("pid:"+d.getParent().getId()+",");
			sb.append("name:'"+d.getKey()+"',");
			sb.append("open:false");
			sb.append("},");
		}
		sb.deleteCharAt(sb.length()-1); 
		sb.append("]");
		model.addAttribute("page",new HibernatePage<Customer>().order("desc").orderBy("modifiedTime"));
		model.addAttribute("dict",sb.toString());
		model.addAttribute("type", dict);
		return "/customer/customer/list";
	}

	/**
	 * 查看或编辑客户
	 * 
	 * @param type
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required = false) String type,
			@RequestParam(required = false) Long id, Model model) {
		logger.info("CustomerController.view查询组件");
		String funcUrl="";
		String returnStr="/customer/customer/view";
		Customer customer = null;
		if("edit".equals(type)){
			funcUrl="/customer/customer/modify.do";
			returnStr= "/customer/customer/edit";
		}
		customer = customerService.getById(id);
		//获取所有数据字典类型
		getDictionary(model);
		model.addAttribute("customer",customer);
		model.addAttribute("funcUrl", funcUrl);
		return returnStr;
	}
	
	/**
	 * 修改客户信息
	 * @param customer
	 * @param request
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/modify.do")
	public String modify(Customer customer, HttpServletRequest request,String type) {
		logger.info("CustomerController.modify修改客户信息");
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}", u.getName());
		customer.setModifiedTime(new Date(new java.util.Date().getTime()));
		customer.setModifier(u);
		customer.setIsDeleted(false);
		customer.setCreator(u);
		customerService.save(customer);
		String redStr = "/customer/customer/toViewPage.do?id="+customer.getId();
		if("add".equals(type)){
			redStr = "/customer/customer/toAddPage.do";
		}
		return "redirect:"+redStr;
	}
	
	@ResponseBody//表示该方法的返回结果直接写入HTTP response body中
	@RequestMapping(value = "/modify.do",
					params={"type=modifyOwner"}, //只有type=modifyOwner的请求才调这个方法
					produces = "text/text;charset=UTF-8")
	public String modify(Long[] id, Long ownerId) {

		
		customerService.modifyOwner(ownerId, id);
		JsonDto json = new JsonDto();
		json.setMessage("转换成功");
		return json.toString();
	}
	
	/**
	 * view(跳转到系新增页面)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage( Model model){
		logger.info("CustomerController.toAddPage新建客户");
		String funcUrl="/customer/customer/add.do";
		model.addAttribute("funcUrl", funcUrl);
		//获取所有数据字典类型
		getDictionary(model);
		return "/customer/customer/edit";
	}
	
	
	/**
	 * add(保存：新建)
	 * @param customer
	 * @param request
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/add.do")
	public String add(Customer customer,HttpServletRequest request,String type){
		logger.info("ComponentController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("ComponentController.query 获得当前操作的用户{}",u.getName());
		customer.setCreator(u);
		customer.setOwner(u);
		customer.setModifier(u);
		customer.setCreatedTime(new Date(new java.util.Date().getTime()));
		customer.setModifiedTime(new Date(new java.util.Date().getTime()));
		customerService.save(customer);
		String redStr = "/customer/customer/toQueryPage.do";
		if("add".equals(type)){
			redStr = "/customer/customer/toAddPage.do";
		}
		return "redirect:"+redStr;
	}
	
	/**
	 *  delete(删除客户)
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(Long... id){
		logger.info("CustomerController.delete删除客户id={}",StringUtils.join(id,","));
		customerService.delete(id);
		JsonDto json = new JsonDto();
		json.setMessage("删除成功");
		return json.toString();
	}
	
	
	/**
     * toCustomerLstPage(跳转至客户组件列表界面)
     * todo: lihua 2014-05-22
     */
    @RequestMapping(value = "/toQueryPage.comp")
    public String toCustomerLstPage(
            @RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "createdTime") String orderBy,
            @RequestParam(value = "order", defaultValue = "asc") String order,
            HttpServletRequest request, Model model) throws NoSuchFieldException {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        
        HibernatePage<Customer> page=new HibernatePage<Customer>(pageNumber, pageSize);
        page.setHibernateOrderBy(orderBy);
        page.setHibernateOrder(order);
        customerService.findPage(searchParams, page);
        
        JsonDto jsonDto = new JsonDto();
        jsonDto.setResult(page);
        model.addAttribute("jsondata", jsonDto.toString());
        
        return "/customer/customer/listcomp";
    }

    /**
     * 获取所有数据字典类型
     * @author huizijing
     */
	public void getDictionary(Model model){
		//设置客户类型
		List<Dictionary> cType = dictionaryService.findChildren("040301");
		model.addAttribute("cType",cType);
		//设置客户来源
		List<Dictionary> source = dictionaryService.findChildren("040302");
		model.addAttribute("source", source);
		//设置证件类型
		List<Dictionary> cardType = dictionaryService.findChildren("040303");
		model.addAttribute("cardType", cardType);
		//设置风险等级
		List<Dictionary> riskGrade = dictionaryService.findChildren("040304");
		model.addAttribute("riskGrade", riskGrade);
		//设置行业
		List<Dictionary> industry = dictionaryService.findChildren("040305");
		model.addAttribute("industry", industry);
		//设置所有权
		List<Dictionary> ownerShip = dictionaryService.findChildren("040306");
		model.addAttribute("ownerShip", ownerShip);
		//设置开户行
		List<Dictionary> openBank = dictionaryService.findChildren("040307");
		model.addAttribute("openBank", openBank);
		
	}
	
	
	  /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request, Long organizationId, HibernatePage<Customer> page, ModelMap modelMap, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
        logger.debug("查询条件数目“{}”", searchParams.size());

        List<Customer> customers= customerService.find(searchParams);
        logger.debug("列表信息数目“{}”", customers.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "customer", customers).write(response.getOutputStream());
    }

    /**
     * 导出限制数据
     * 1.指定最大条数的
     */
    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        logger.info("导出excel文件");

        List<Customer> customers = customerService.find();
        logger.debug("列表信息数目“{}”", customers.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "customer", customers).write(response.getOutputStream());
    }


}
