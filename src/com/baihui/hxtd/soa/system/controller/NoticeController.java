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
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.BidiMap;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.system.entity.Notice;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.NoticeService;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

/**
 * 公告控制器
 * 
 * @author huizijing
 * @version 1.0
 * @date 2014/6/3
 */
@Controller
@RequestMapping(value = "/system/notice")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_DATASHIFT, Constant.VS_ORG,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class NoticeController {

    private Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	/** 注入NoticeService */
	@Resource
	private NoticeService noticeService;
	
	
	
	/**
	 * 查询公告列表(从功能按钮跳转)
	 * @param page
	 * @param request
	 * @throws NoSuchFieldException
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 */
	@ResponseBody
	@RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
	public void query(HttpServletRequest request, HibernatePage<Notice> page, ModelMap model,String type, PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
		logger.info("查询信息");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "sentTime");
        logger.debug("查询条件数目“{}”", searchParams.size());
        logger.info("添加默认的查询条件");
        logger.info("获取分页数据");
        page = noticeService.findPage(searchParams, page,type);
        logger.info("以DTO格式返回");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setMessage("请求数据成功！");
        jsonDto.setResult(page);

        HibernateAwareObjectMapper.DEFAULT.writeValue(out, jsonDto);
	}

	/**
	 * toQueryPage(从菜单跳转,跳转公告列表页)
	 * @param model
	 * @return
	 */
	@RequestMapping("/toQueryPage.do")
	public String toQueryPage(@RequestParam(value = "pageNo", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "pageOrderBy", defaultValue = "sentTime") String orderBy,
            @RequestParam(value = "pageOrder", defaultValue = "desc") String order,
            Model model) {
		logger.info("NoticeController.toQueryPage跳转公告列表页");
		HibernatePage<Notice> page = new HibernatePage<Notice>(pageNumber, pageSize);
        page.setHibernateOrderBy(orderBy);
        page.setHibernateOrder(order);
        model.addAttribute("page", page);
		return "/system/notice/list";
	}

	/**
	 * 查看或编辑公告
	 * 
	 * @param type
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toViewPage.do")
	public String view(@RequestParam(required = false) String type,
			@RequestParam(required = false) Long id, Model model) {
		logger.info("NoticeController.view查询组件");
		String funcUrl="";
		String returnStr="/system/notice/view";
		Notice notice = null;
		if("edit".equals(type)){
			funcUrl="/system/notice/modify.do";
			returnStr= "/system/notice/edit";
		}else 
		if("send".equals(type)){
		    funcUrl="/system/notice/toSend.do?id=id";
		    returnStr= "/system/notice/send";
			}
		notice = noticeService.getById(id);
		//SimpleDateFormat   sdformat   =   new SimpleDateFormat("yyyy-MM-dd");   
		//String sendTime=notice.getSentTime();
		//String deadTime=notice.getDeadTime();
		model.addAttribute("sendTime", notice.getSentTime());
		model.addAttribute("deadTime", notice.getDeadTime());
		model.addAttribute("notice",notice);
		model.addAttribute("funcUrl", funcUrl);
		return returnStr;
	}
	
	/**
	 * 修改公告信息
	 * @param Notice
	 * @param request
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/modify.do")
	public String modify(Notice notice, HttpServletRequest request,String type) {
		logger.info("NoticeController.modify修改公告信息");
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("获得当前操作用户{}", u.getName());
		notice.setModifieTime(new Date());
		notice.setModifier(u);
		notice.setCreater(u);
		//notice.setCreatedTime(new Date());
		//notice.setSentTime(sentTime);
		noticeService.save(notice);
		String redStr = "/system/notice/toViewPage.do?id="+notice.getId();
		if("add".equals(type)){
			redStr = "/system/notice/toAddPage.do";
		}
		return "redirect:"+redStr;
	}
	
	/**
	 * view(跳转到系新增页面)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toAddPage.do")
	public String toAddPage( Model model){
		logger.info("NoticeController.toAddPage新建公告");
		String funcUrl="/system/notice/add.do";
		model.addAttribute("funcUrl", funcUrl);
		return "/system/notice/edit";
	}
	
	
	/**
	 * add(保存：新建)
	 * @param Notice
	 * @param request
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/add.do")
	public String add(Notice notice,HttpServletRequest request,String type){
		logger.info("ComponentController.query查询组件列表");
		//临时代码，时间类型应从数据库中取
		User u = (User) request.getSession().getAttribute(Constant.VS_USER);
		logger.info("NoticeController.query 获得当前操作的用户{}",u.getName());
		notice.setCreater(u);
		notice.setModifier(u);
		notice.setCreatedTime(new Date());
		notice.setModifieTime(new Date());
		notice.setIsDeleted(false);
		noticeService.save(notice);
		String redStr = "/system/notice/toQueryPage.do";
		if("add".equals(type)){
			redStr = "/system/notice/toAddPage.do";
		}
		return "redirect:"+redStr;
	}
	
	/**
	 *  delete(删除公告)
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete.do",produces = "text/text;charset=UTF-8")
	public String delete(Long... id){
		logger.info("NoticeController.delete删除公告id={}",StringUtils.join(id,","));
		noticeService.delete(id);
		JsonDto json = new JsonDto();
		json.setMessage("删除成功");
		return json.toString();
	}
	
	@RequestMapping(value = "/toImportPage.do")
    public String toImportPage(ModelMap model) throws NoSuchFieldException {
        model.addAttribute("templateName", "notice.xls");
        return "/system/notice/import";
    }

    @RequestMapping(value = "/import.do")
    public String imports(MultipartFile file, HttpSession session,
                          @RequestParam(defaultValue = "/system/notice/toQueryPage.do") String redirectUri,
                          @ModelAttribute(Constant.VS_USER) User sessionUser,
                          @ModelAttribute(Constant.VS_ORG) Organization organization,
                          ModelMap modelMap,
                          RedirectAttributes model) throws IOException, InvalidFormatException {

        logger.info("导入excel文件");

        logger.info("检查文件是否为空");
        if (file.getSize() == 0) {
            modelMap.addAttribute(Constant.VM_BUSINESS, "未选择导入文件");
            return "forward:/system/notice/toImportPage.do";
        }

        logger.info("检查文件扩展名");
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        if (!"xls,xlsx".contains(extension)) {
            modelMap.addAttribute(Constant.VM_BUSINESS, "不支持的文件类型");
            return "forward:/system/notice/toImportPage.do";
        }

        logger.info("根据excel文件解析出对象集合");
        ServletContext servletContext = session.getServletContext();
        Map<String, BidiMap> descNames = (Map<String, BidiMap>) servletContext.getAttribute(Constant.VC_DESCNAMES);

        Workbook workbook = ImportExport.create(file.getInputStream());
        List<Notice> notices = ImportExport.imports(workbook, descNames.get("notice"), Notice.class);

        logger.info("设置默认的属性值");
//        Dictionary jobsituation = dictionaryService.getByValue(jobsituationOnValue);
//        for (User user : users) {
//            user.setCreator(sessionUser);
//            user.setModifier(sessionUser);
//            user.setOrganization(organization);
//            user.setJobSituation(jobsituation);
//        }
        logger.debug("导入信息“{}”", HibernateAwareObjectMapper.DEFAULT.writeValueAsString(notices));
        logger.debug("对象集合数目“{}”", notices.size());

        noticeService.add(notices);

        logger.info("添加操作提示");
        model.addFlashAttribute(Constant.VM_BUSINESS, "导入成功");

        logger.info("重定向至“{}”", redirectUri);
        return "redirect:" + redirectUri;
    }

    /**
     * 导出分页数据
     * 1.在分页列表上根据当前条件进行导出
     */
    @RequestMapping(value = "/export.do", params = "TYPE=pagination")
    public void exportPagination(HttpServletRequest request, Long organizationId, HibernatePage<Notice> page, ModelMap modelMap, HttpServletResponse response) throws NoSuchFieldException, IOException {
        logger.info("导出excel文件");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.decodeValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
        logger.debug("查询条件数目“{}”", searchParams.size());

        List<Notice> notices=noticeService.find(searchParams);
        logger.debug("列表信息数目“{}”", notices.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "notice", notices).write(response.getOutputStream());
    }

    /**
     * 导出限制数据
     * 1.指定最大条数的
     */
    @RequestMapping(value = "/export.do", params = "TYPE=limit")
    public void exportLimit(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        logger.info("导出excel文件");

        List<Notice> notices = noticeService.find();
        logger.debug("列表信息数目“{}”", notices.size());

        logger.info("转换成excel文件并输出");
        ServletContext servletContext = request.getSession().getServletContext();
        ImportExport.exportExcel(response, servletContext, "notice", notices).write(response.getOutputStream());
    }



}
