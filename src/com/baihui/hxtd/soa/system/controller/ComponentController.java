package com.baihui.hxtd.soa.system.controller;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.ComponentService;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.util.JsonDto;

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
public class ComponentController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    /**
     * 注入service
     */
    @Resource
    private ComponentService componentService;
    @Resource
    private DictionaryService dictionaryService;

    /**
     * query(分页查询)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return ModelAndView    返回类型
     * @throws NoSuchFieldException 
     * @throws
     * @Title: query
     */
    @RequestMapping(value = "/query.do", produces = "text/text;charset=UTF-8")
    @ResponseBody
    public String query(HibernatePage<Component> page,//
                        HttpServletRequest request) throws NoSuchFieldException {
        logger.info("ComponentController.query查询组件列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Search.clearBlankValue(searchParams);
		Search.toRangeDate(searchParams, "modifiedTime");
		Search.toRangeDate(searchParams, "createdTime");
		page = componentService.findPage(searchParams, page);
		JsonDto json = new JsonDto();
		json.setResult(page);
        return json.toString();
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
        model.addAttribute("page",new HibernatePage<Component>().order("desc").orderBy("modifiedTime"));
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
        Component com  = componentService.get(id);
        model.addAttribute("com", com);
        return "/system/component/view";
    }

    /**
     * toModifyPage
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
        Component com  = componentService.get(id);
        model.addAttribute("com", com);
        List<Dictionary> dict = dictionaryService.findChildren("010601");
        model.addAttribute("dict", dict);
        model.addAttribute("funcUrl", "/system/component/modify.do");
        return "/system/component/edit";
    }
    /**
     * toAddPage
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
        List<Dictionary> dict = dictionaryService.findChildren("010601");
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
    @RequestMapping(value = "/modify.do")
    public String modify(Component component,
                         HttpServletRequest request,
                         String type) {
        logger.info("ComponentController.modify修改组件信息");
        component.setCreatedTime(new Date(new java.util.Date().getTime()));
        component.setModifiedTime(new Date(new java.util.Date().getTime()));
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        logger.info("获得当前操作用户{}", u.getName());
        component.setModifier(u);
        componentService.save(component);
        String redStr = "/system/component/toViewPage.do?id="+component.getId();
        if ("add".equals(type)) {
            redStr = "/system/component/toAddPage.do";
        }
        return "redirect:" + redStr;
    }

    /**
     * add(保存：新建)
     *
     * @param component组件实体类对象
     * @return String    返回类型
     * @throws
     * @Title: add
     */
    @RequestMapping(value = "/add.do")
    public String add(Component component, HttpServletRequest request, String type) {
        logger.info("ComponentController.query查询组件列表");
        //临时代码，时间类型应从数据库中取
        component.setCreatedTime(new Date(new java.util.Date().getTime()));
        component.setModifiedTime(new Date(new java.util.Date().getTime()));
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        logger.info("ComponentController.query 获得当前操作的用户{}", u.getName());
        component.setCreator(u);
        component.setModifier(u);
        componentService.save(component);
        String redStr = "/system/component/toViewPage.do?id="+component.getId();
        if ("add".equals(type)) {
            redStr = "/system/component/toAddPage.do";
        }
        return "redirect:" + redStr;
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
    public String delete(long[] id) {
        logger.info("ComponentController.delete删除组件id={}", id);
        componentService.delete(id);
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
