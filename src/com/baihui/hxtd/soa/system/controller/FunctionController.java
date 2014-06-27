package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.system.service.MenuService;
import com.baihui.hxtd.soa.util.JsonDto;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.util.Map;

@Controller
@RequestMapping(value = "/system/function")
public class FunctionController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    /**
     * 注入service
     */
    @Resource
    private FunctionService functionService;

    @Resource
    private CommonService commonService;

    /**
     * 注入菜单表service
     */
    @Resource
    private MenuService menuService;

    @Resource
    private DictionaryService dictionaryService;

    /**
     * view(查询单个菜单信息)
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
        logger.info("functionController.view查询组件");
        String returnStr = "/system/function/view";
        Function func = functionService.get(id);
        model.addAttribute("zNode", menuService.getMenuJsonData());
        model.addAttribute("func", func);
        return returnStr;
    }

    /**
     * toModifyPage(查询单个菜单信息)
     *
     * @param @param  id
     * @param @param  model
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: view
     */
    @RequestMapping(value = "/toModifyPage.do")
    public String toModifyPage(@RequestParam(required = false) Long id,
                               Model model) {
        logger.info("functionController.view查询组件");
        Function func = functionService.get(id);
        model.addAttribute("zNode", menuService.getMenuJsonData());
        model.addAttribute("func", func);
        model.addAttribute("funcUrl", "/system/function/modify.do");
        model.addAttribute("level", dictionaryService.findChildren("010601"));
        return "/system/function/edit";
    }

    /**
     * toAddPage(跳转新增页面)
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
        logger.info("functionController.view查询组件");
        String funcUrl = "/system/function/add.do";
        model.addAttribute("zNode", menuService.getMenuJsonData());
        model.addAttribute("funcUrl", funcUrl);
        model.addAttribute("level", dictionaryService.findChildren("010601"));
        return "/system/function/edit";
    }

    /**
     * query(分页查询)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return ModelAndView    返回类型
     * @throws
     * @Title: query
     */
    @RequestMapping(value = "/toQueryPage.do")
    public String query(Model model) {
        logger.info("FunctionController.query跳转列表页");
        model.addAttribute("tree", menuService.getMenuJsonData());
        model.addAttribute("page", new HibernatePage<Function>().order("desc").orderBy("modifiedTime"));
        return "/system/function/list";
    }

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
    public String query(HibernatePage<Function> page,//
                        HttpServletRequest request) throws NoSuchFieldException {
        logger.info("ComponentController.query查询组件列表");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(
                request, "search_");
        Search.clearBlankValue(searchParams);
        Search.toRangeDate(searchParams, "modifiedTime");
        Search.toRangeDate(searchParams, "createdTime");
        page = functionService.findPage(searchParams, page);
        JsonDto json = new JsonDto();
        json.setResult(page);
        return json.toString();
    }


    /**
     * modify(保存：修改)
     *
     * @param Function组件实体类对象
     * @return String    返回类型
     * @throws
     * @Title: modify
     */
    @ResponseBody
    @RequestMapping(value = "/modify.do")
    public String modify(Function function, String type, HttpServletRequest request) {
        logger.info("FunctionController.modify修改组件信息");
        if (commonService.isInitialized(Function.class, function.getId())) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        function.setCreatedTime(new Date(new java.util.Date().getTime()));
        function.setModifiedTime(new Date(new java.util.Date().getTime()));
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        logger.info("获得当前操作用户{}", u.getName());
        function.setModifier(u);
        functionService.save(function);
        JsonDto json = new JsonDto(function.getId(), "保存成功!");
        return json.toString();
    }

    /**
     * add(保存：新建)
     *
     * @param Function组件实体类对象
     * @return String    返回类型
     * @throws
     * @Title: add
     */
    @ResponseBody
    @RequestMapping(value = "/add.do")
    public String add(Function function,
                      String type,
                      HttpServletRequest request) {
        logger.info("FunctionController.query查询组件列表");
        //临时代码，时间类型应从数据库中取
        function.setCreatedTime(new Date(new java.util.Date().getTime()));
        function.setModifiedTime(new Date(new java.util.Date().getTime()));
        User u = (User) request.getSession().getAttribute(Constant.VS_USER);
        logger.info("FunctionController.query 获得当前操作的用户{}", u.getName());
        function.setCreator(u);
        function.setModifier(u);
        functionService.save(function);
        JsonDto json = new JsonDto(function.getId(), "保存成功!");
        return json.toString();
    }

    /**
     * delete(保存：新建)
     *
     * @param Function组件实体类对象
     * @return String    返回类型
     * @throws
     * @Title: delete
     */
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public String delete(Long[] id) {
        logger.info("FunctionController.delete删除组件id={}", StringUtils.join(id, ","));
        if (commonService.isInitialized(Function.class, id)) {
            return new JsonDto("系统初始化数据不允许修改！").toString();
        }

        functionService.delete(id);
        JsonDto json = new JsonDto();
        json.setMessage("删除成功");
        return json.toString();
    }

    public Logger getLogger() {
        return logger;
    }

    public void setLogger(Logger logger) {
        this.logger = logger;
    }

    public FunctionService getFunctionService() {
        return functionService;
    }

    public void setFunctionService(FunctionService functionService) {
        this.functionService = functionService;
    }

    public MenuService getMenuService() {
        return menuService;
    }

    public void setMenuService(MenuService menuService) {
        this.menuService = menuService;
    }
}
