package com.baihui.hxtd.soa.system.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.ComponentService;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;

/**
 * 功能描述： 组件管理控制器
 *
 * @author ruisong.luan
 * @version (版本) 1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.system.controller.ComponentController.java
 * @date 2014-5-6 下午04:06:55
 * @since (该版本支持的 JDK 版本) ：1.6
 */
@Controller
@RequestMapping(value = "/system/component")
@SessionAttributes(value = {Constant.VS_USER})
public class ComponentController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    /**
     * 注入service
     */
    @Resource
    private ComponentService componentService;

    @Resource
    private CommonService commonService;

    @Resource
    private DictionaryService dictionaryService;

    /**
     * query(分页查询)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return ModelAndView    返回类型
     * @throws NoSuchFieldException
     * @throws IOException 
     * @throws JsonMappingException 
     * @throws JsonGenerationException 
     * @throws
     * @Title: query
     */
    @RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
    @ResponseBody
    public void query(HibernatePage<Component> page,//
                        HttpServletRequest request,PrintWriter out) throws NoSuchFieldException, JsonGenerationException, JsonMappingException, IOException {
        logger.info("ComponentController.query查询组件列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        Search.toRangeDate(searchParams, "createdTime");
        page = componentService.findPage(searchParams, page);
        JsonDto json = new JsonDto();
        json.setResult(page);
        HibernateAwareObjectMapper.DEFAULT.writeValue(out, json);
    }

    /**
     * toQueryPage(跳转列表页)
     *
     * @param @param
     * @param @return 参数类型
     * @return ModelAndView    返回类型
     * @throws
     * @Title: toQueryPage
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String toQueryPage(Model model) {
        logger.info("ComponentController.toQueryPage跳转列表页");
        model.addAttribute("page", new HibernatePage<Component>().order(HibernatePage.DESC).orderBy("modifiedTime"));
        return "/system/component/list";
    }

    /**
     * view(查询单个组件信息)
     *
     * @param @param  type
     * @param @param  id
     * @param @param  model
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: view
     */
    @RequestMapping(value = "/toViewPage.do")
    public String view(@RequestParam(required = false) String type,
                       @RequestParam(required = false) Long id,
                       Model model) {
        logger.info("ComponentController.view查询组件");
        Component com = componentService.get(id);
        model.addAttribute("com", com);
        return "/system/component/view";
    }

    /**
     * toModifyPage
     *
     * @param @param  type
     * @param @param  id
     * @param @param  model
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: view
     */
    @RequestMapping(value = "/toModifyPage.do")
    public String toModifyPage(Long id,
                               Model model) {
        logger.info("ComponentController.view查询组件");
        Component com = componentService.get(id);
        model.addAttribute("com", com);
        List<Dictionary> dict = dictionaryService.findChildren(DictionaryConstant.FUNCTION_PRIVILEGELEVEL);
        model.addAttribute("dict", dict);
        model.addAttribute("funcUrl", "/system/component/modify.do");
        return "/system/component/edit";
    }

    /**
     * toAddPage
     *
     * @param @param  type
     * @param @param  id
     * @param @param  model
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: view
     */
    @RequestMapping(value = "/toAddPage.do")
    public String toAddPage(Model model) {
        logger.info("ComponentController.view查询组件");
        String funcUrl = "/system/component/add.do";
        List<Dictionary> dict = dictionaryService.findChildren(DictionaryConstant.FUNCTION_PRIVILEGELEVEL);
        model.addAttribute("dict", dict);
        model.addAttribute("funcUrl", funcUrl);
        return "/system/component/edit";
    }

    /**
     * modify(保存：修改)
     *
     * @param component组件实体类对象
     * @return String    返回类型
     * @throws
     * @Title: modify
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do")
    public String modify(Component component,
                         HttpServletRequest request,
                         String type, ModelMap modelMap) {
        logger.info("ComponentController.modify修改组件信息");

        if (commonService.isInitialized(Component.class, component.getId())) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        User user = (User)modelMap.get(Constant.VS_USER);
        logger.info("获得当前操作用户{}", user.getName());
        component.setModifier(user);
        
        AuditLog auditLog = new AuditLog(EnumModule.COMPONENT.getModuleName(), 
        		component.getId(), component.getName(), EnumOperationType.MODIFY.getOperationType(), user,"修改组件");
        componentService.modify(component, auditLog);
        JsonDto json = new JsonDto(component.getId(), "保存成功!");
        return json.toString();
    }

    /**
     * add(保存：新建)
     *
     * @param component组件实体类对象
     * @return String    返回类型
     * @throws
     * @Title: add
     */
    @ResponseBody
    @RequestMapping(value = "/add.do")
    public String add(Component component, HttpServletRequest request, String type, ModelMap modelMap) {
        logger.info("ComponentController.query查询组件列表");

        //临时代码，时间类型应从数据库中取
        User user = (User)modelMap.get(Constant.VS_USER);
        logger.info("ComponentController.query 获得当前操作的用户{}", user.getName());
        component.setCreator(user);
        component.setModifier(user);
        
        AuditLog auditLog = new AuditLog(EnumModule.COMPONENT.getModuleName(), 
        		component.getId(), component.getName(), EnumOperationType.ADD.getOperationType(), user,"增加组件");
        componentService.add(component,auditLog);
        JsonDto json = new JsonDto(component.getId(), "保存成功!");
        return json.toString();
    }

    /**
     * delete(保存：新建)
     *
     * @param component组件实体类对象
     * @return String    返回类型
     * @throws
     * @Title: delete
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do", produces = "text/text;charset=UTF-8")
    public String delete(ModelMap model, Long[] id) {
        logger.info("ComponentController.delete删除组件id={}", StringUtils.join(id, ","));

        if (commonService.isInitialized(Component.class, id)) {
            return new JsonDto("系统初始化数据不允许删除！").toString();
        }
        User user = (User)model.get(Constant.VS_USER);
        AuditLog [] auditLogArr = new AuditLog [id.length];
		for(int i=0; i<id.length; i++){
			auditLogArr[i] = new AuditLog(EnumModule.COMPONENT.getModuleName(), 
					id[i], componentService.getNameById(id[i]), EnumOperationType.DELETE.getOperationType(), user);
		}
        componentService.delete(id,auditLogArr);
        JsonDto json = new JsonDto();
        json.setMessage("删除成功");
        return json.toString();
    }

    public ComponentService getComponentService() {
        return componentService;
    }

    public void setComponentService(ComponentService componentService) {
        this.componentService = componentService;
    }


}
