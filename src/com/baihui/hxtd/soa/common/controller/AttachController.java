package com.baihui.hxtd.soa.common.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.entity.Attachment;
import com.baihui.hxtd.soa.common.service.AttachmentService;
import com.baihui.hxtd.soa.system.entity.Notice;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
/**
 * 
 * 功能描述：附件控制器
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.controller.AttachmentController.java
 * @version (版本) 1
 * @date 2014-5-26 上午11:17:53
 */
@Controller
@RequestMapping(value = "/common/attach")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_DATASHIFT, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class AttachController {
	
	 private Logger logger = LoggerFactory.getLogger(AttachController.class);
	 
	 @Resource
	 private AttachmentService attachmentService;
	/**
	 * 查询附件列表(从功能按钮跳转)
	 * @param page
	 * @param request
	 * @throws NoSuchFieldException
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 */
	@ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public void query(HttpServletRequest request, HibernatePage<Attachment> page, ModelMap model,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
		logger.info("查询信息");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "createdTime");
        logger.debug("查询条件数目“{}”", searchParams.size());
        logger.info("添加默认的查询条件");
        logger.info("获取分页数据");
        page = attachmentService.findPage(searchParams, page);
        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setMessage("请求数据成功！");
        jsonDto.setResult(page);

        HibernateAwareObjectMapper.DEFAULT.writeValue(out, jsonDto);
	}

	/**
	 * toQueryPage(从菜单跳转,跳转附件列表页)
	 * @param model
	 * @return
	 */
	@RequestMapping("/toQueryPage.do")
	public String toQueryPage(@RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "createdTime") String orderBy,
            @RequestParam(value = "pageOrder", defaultValue = "desc") String order,
            Model model) {
		logger.info("AttachmentController.toQueryPage跳转附件列表页");
		HibernatePage<Attachment> page = new HibernatePage<Attachment>(pageNumber, pageSize);
        page.setHibernateOrderBy(orderBy);
        page.setHibernateOrder(order);
        model.addAttribute("page", page);
		return "/common/attachment/list";
	}
	
	
	
	/**
	 * 查看附件
	 * 
	 * @param type
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required = false) String type,
			@RequestParam(required = false) Long id, Model model) {
		logger.info("AttachmentController.view查询组件");
		Attachment attachment = null;
		attachment= attachmentService.getById(id);
		model.addAttribute("attachment",attachment);
		return "/common/attachment/detail";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
