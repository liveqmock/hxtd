package com.baihui.hxtd.soa.system.controller;

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
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.system.entity.Message;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.entity.UserMessage;
import com.baihui.hxtd.soa.system.service.MessageService;
import com.baihui.hxtd.soa.system.service.UserService;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

/**
 * 系统消息控制器
 * 
 * @author huizijing
 * @version 1.0
 * @date 2014/6/3
 */
@Controller
@RequestMapping(value = "/system/message")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_DATASHIFT, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class MessageController {

    private Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	/** 注入MessageService */
	@Resource
	private MessageService messageService;
	
	@Resource
	private UserService userService;
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
	
	/**
	 * 查询系统消息列表(从功能按钮跳转)
	 * @param page
	 * @param request
	 * @throws NoSuchFieldException
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 */
	@ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public void query(HttpServletRequest request,HibernatePage<UserMessage> page,ModelMap model,String type, PrintWriter out)
	throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
		logger.info("查询信息");

        logger.info("解析页面查询条件");
        User user = (User) request.getSession().getAttribute(Constant.VS_USER);
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "createdTime");
        logger.debug("查询条件数目“{}”", searchParams.size());
        logger.info("添加默认的查询条件");
        logger.info("获取分页数据");
        
         if("recived".contains(type)){
        	page.setHibernateOrderBy("status");
         	page.setHibernateOrder("asc");
            page = messageService.findRecivePage(searchParams, page,user);
        }else{
        	page.setHibernateOrderBy("createdTime");
        	page.setHibernateOrder("desc");
        	page = messageService.findSendPage(searchParams, page,user);
        }
        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setMessage("请求数据成功！");
        jsonDto.setResult(page);
        HibernateAwareObjectMapper.DEFAULT.writeValue(out, jsonDto);
        
	}

	/**
	 * toQueryPage(从菜单跳转,跳转系统消息列表页)
	 * @param model
	 * @return
	 */
	@RequestMapping("/toQueryPage.do")
	public String toQueryPage(@RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "createdTime") String orderBy,
            @RequestParam(value = "pageOrder", defaultValue = "desc") String order,
            Model model) {
		logger.info("MessageController.toQueryPage跳转系统消息列表页");
		HibernatePage<UserMessage> page = new HibernatePage<UserMessage>(pageNumber, pageSize);
        model.addAttribute("page", page);
       	return "/system/message/list";
	}
	
	
	/**
	 * 查看或编辑系统消息
	 * 
	 * @param type
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required = false) String type,
			@RequestParam(required = false) Long id, Model model) {
		logger.info("MessageController.view查询组件");
		String funcUrl="";
		String returnStr="/system/message/view";
		UserMessage userMessage = null;
		userMessage = messageService.getById(id);
		if("edit".equals(type)){
			funcUrl="/system/message/modify.do";
			returnStr= "/system/message/reply";
		}
		if("add".equals(type)){
			funcUrl="/system/message/add.do";
			returnStr= "/system/message/edit";
		}else{
			Message message=userMessage.getMessage();
			message.setContent(message.getContent().replaceAll("\r", "<br>"));
			userMessage.setMessage(message);
		}
		model.addAttribute("userMessage",userMessage);
		model.addAttribute("funcUrl", funcUrl);
		return returnStr;
	}
	
	/**
	 * 修改系统消息信息
	 * @param Message
	 * @param request
	 * @param type
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/modify.do")
	public String modify(Message message,long userId, HttpServletRequest request,String type) {
		logger.info("MessageController.modify修改系统消息信息");
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}", u.getName());
		message.setCreatedTime(new Date());
		message.setModifier(u);
		message.setModifiedTime(new Date());
		message.setCreater(u);
		messageService.save(message);
		User user=userService.getById(userId);
		messageService.saveShip(message,user);
		JsonDto json = JsonDto.modify(message.getId());
		return json.toString();
	}
	
	
	/**
	 * view(跳转到系新增页面)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage( Model model){
		logger.info("MessageController.toAddPage新建系统消息");
		String funcUrl="/system/message/add.do";
		model.addAttribute("funcUrl", funcUrl);
		return "/system/message/edit";
	}
	
	
	/**
	 * add(保存：新建)
	 * @param Message
	 * @param request
	 * @param type
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/add.do")
	public String add(Message message,HttpServletRequest request,String type,String userId){
		logger.info("ComponentController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("ComponentController.query 获得当前操作的用户{}",u.getName());
		message.setCreater(u);
		message.setModifier(u);
		message=messageService.save(message);
		//批量发送消息
		String[] userstr=userId.split(",");
		for(int i=0;i<userstr.length;i++){
			User user=userService.getById(Long.parseLong(userstr[i]));
			messageService.saveShip(message,user);
		}
		JsonDto json = JsonDto.add(message.getId());
		return json.toString();
	}
	
	/**
	 *  delete(删除系统消息)
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(Long... id){
		logger.info("MessageController.delete删除系统消息id={}",StringUtils.join(id,","));
		messageService.delete(id);
		JsonDto json = JsonDto.delete(id);
		return json.toString();
	}
	

    /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request, String ty,
    		HibernatePage<UserMessage> page, ModelMap modelMap, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        User user = (User) request.getSession().getAttribute(Constant.VS_USER);
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
       
        logger.debug("查询条件数目“{}”", searchParams.size());

        List<UserMessage> userMessages=messageService.find(searchParams,ty,user);
        logger.debug("列表信息数目“{}”", userMessages.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "userMessage", userMessages).write(response.getOutputStream());
    }

    /**
     * 导出限制数据
     * 1.指定最大条数的
     */
    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        logger.info("导出excel文件");

        List<UserMessage> userMessages = messageService.find();
        logger.debug("列表信息数目“{}”", userMessages.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "userMessage", userMessages).write(response.getOutputStream());
    }

}
