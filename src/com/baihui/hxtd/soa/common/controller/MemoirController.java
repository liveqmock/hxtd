package com.baihui.hxtd.soa.common.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

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

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.entity.Memoir;
import com.baihui.hxtd.soa.common.service.MemoirService;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.util.JsonDto;
/**
 * 
 * 功能描述：联系纪要控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.MemoirController.java
 * @version (版本) 1
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@SessionAttributes(value = {Constant.VS_USER_ID})
@RequestMapping(value = "/common/memoir")
public class MemoirController {

	@Resource
	private MemoirService memoirService; 
	//@Resource
	//private DictionaryService dictionaryService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }

	/**
	  * findPage(查询模块相关联系纪要)
	  * @Description: 查询模块相关联系纪要
	  * @param request HttpServletRequest
	  * @param page 分页
	  * @param moduleId 模块主键id
	  * @param moduleType 模块类型
	  * @param out PrintWriter
	  * @throws IOException 
	 */
	@RequestMapping(value = "/query.do")
	public void query(HttpServletRequest request,
			HibernatePage<Memoir> page,
			@RequestParam(value = "moduleId") Long moduleId,
			@RequestParam(value = "moduleType") Long moduleType,
			PrintWriter out) throws IOException {
        /************分页查询*****************/
		memoirService.findPage(moduleId, moduleType, page);
		
		/************json转换****************/
		JsonDto json = new JsonDto();
		json.setResult(page);
		
		HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
	}
	
	/**
	  * toAddPage(跳转至新增纪要页)
	  * @Description: 请求联系纪要页
	  * @param model ModelMap
	  * @return String 新增联系纪要地址页
	 */
	@RequestMapping(value = "/toAddPage.docomp")
	public String toAddPage(ModelMap model){
		model.addAttribute("memoir", new Memoir());
		
		return "/common/memoir/edit";
	}
	
	/**
	  * add(新增联系纪要)
	  * @Description: 新增一条联系纪要
	  * @param memoir 联系纪要实体
	  * @param moduleId 模块主键id
	  * @param moduleType 模块类型
	  * @param userId 操作用户id
	  * @return String 返回修改页视图地址
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String add(Memoir memoir, 
			//@RequestParam(value = "userIds") String userIds,
			@RequestParam(value = "moduleId") Long moduleId,
			@RequestParam(value = "moduleType") Long moduleType,
			@ModelAttribute(Constant.VS_USER_ID) Long userId) {
		Dictionary dic = new Dictionary();
		dic.setId(moduleType);
		memoir.setType(dic);//模块类型
		
		memoir.setModuleId(moduleId);//模块主键ID
		
		User user = new User(userId);
		memoir.setCreator(user);
		memoir.setModifier(user);
		memoir.setCreatedTime(new Date());
		memoir.setEmployee(user);
		
		memoirService.save(memoir);
		
		JsonDto json = new JsonDto("保存成功");
		json.setSuccessFlag(true);
		
		return json.toString();
	}
	
	/**
	  * toModifyPage(跳转至修改页面)
	  * @Description: 请求修改联系纪要页
	  * @param id 联系纪要主键ID
	  * @param model Model
	  * @return String 编辑页地址信息
	 */
	@RequestMapping(value = "/toModifyPage.docomp")
	public String toModifyPage(Long id, ModelMap model) {
		model.addAttribute("memoir", memoirService.get(id));
		
		return "/common/memoir/edit";
	}
	
	/**
	  * modify(修改联系纪要)
	  * @Description: 保存修改后的联系纪要信息
	  * @param memoir 联系纪要实体
	  * @param moduleId 模块主键ID
	  * @param moduleType 模块类型
	  * @param userId 操作用户ID
	  * @param request HttpServletRequest
	  * @return String 编辑页地址信息
	 */
	@ResponseBody
	@RequestMapping(value = "/modify.do")
	public String modify(Memoir memoir,
			@RequestParam(value = "moduleId") Long moduleId,
			@RequestParam(value = "moduleType") Long moduleType,
			@ModelAttribute(Constant.VS_USER_ID) Long userId,
			HttpServletRequest request) {
		Dictionary dic = new Dictionary();
		dic.setId(moduleType);
		memoir.setType(dic);//模块类型
		memoir.setModuleId(moduleId);//模块主键ID
		memoir.setModifier(new User(userId));
		
		memoirService.save(memoir);
		
		JsonDto json = new JsonDto("保存成功");
		json.setSuccessFlag(true);
		
		return json.toString();
	}
	
	/**
	  * toViewPage(查看联系纪要)
	  * @Description: 查看联系纪要
	  * @param id 联系纪要主键ID
	  * @param model Model
	  * @return String 查看页地址
	 */
	@RequestMapping(value = "/toViewPage.docomp")
	public String toViewPage(Long id, Model model) {
		model.addAttribute("memoir", memoirService.get(id));
		
		return "/common/memoir/view";
	}

	/**
	  * delete(删除联系纪要)
	  * @Description: 删除联系纪要
	  * @param id 联系纪要主键ID
	  * @return String Json串
	  * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do")
	public String delete(Long id) {
		memoirService.delete(id);
		
		JsonDto json = new JsonDto("删除成功");
		json.setSuccessFlag(true);
		
		return json.toString();
	}	
}
