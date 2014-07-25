package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.ServiceException;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.base.utils.serial.TierSerials;
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Menu;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.*;
import com.baihui.hxtd.soa.util.Constants;
import org.apache.commons.collections.BidiMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 身份认证控制器
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Controller
@RequestMapping
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_DATASHIFT, Constant.VS_ORG,
        Constant.VS_MENUBAR_FIRST_MENUS, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class IdentityAuthenticationController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value(value = "${application.login_url}")
    private String loginUrl = "/login.doself";

    @Resource
    private UserService userService;
    @Resource
    private MenuService menuService;
    @Resource
    private RoleService roleService;
    @Resource
    private FunctionService functionService;
    @Resource
    private ComponentService componentService;

    /**
     * 转至登录页面
     */
    @RequestMapping(value = "/login.doself", method = RequestMethod.GET)
    public String loginForm(Model model) {
        User user = new User();
        user.setName("admin");
        user.setPassword("123456");
        model.addAttribute("user", user);
        return "/system/user/login";
    }

    /**
     * 登录
     * 1.验证用户身份
     * 2.验证用户是否激活
     * 3.session中存储用户编号、用户名、组织编号、菜单、功能、组件
     * 4.重置用户数据存储状态
     */
    @RequestMapping(value = "/login.doself", method = RequestMethod.POST)
    public String login(HttpServletRequest request, User user, RedirectAttributes model) throws IOException, CloneNotSupportedException {
        Long startTime = System.currentTimeMillis();

        logger.info("登录系统");

        logger.debug("用户名“{}”", user.getName());
        HttpSession session = request.getSession();
        logger.info("清除用户名前后空格");
        String name = user.getName();
        user.setName(name.trim());
        logger.debug("“{}”->“{}”", name, user.getName());

        //验证用户身份
        User persistUser = userService.getByName(name);
        try {
            userService.check(user, persistUser);
        } catch (ServiceException e) {
            logger.info(e.getMessage(), e);
            String[] split = e.getMessage().split(" - ");
            model.addFlashAttribute(Constant.VM_ERROR, split[split.length - 1]);
            logger.info("重定向至登录页面“{}”", loginUrl);
            return "redirect:" + loginUrl;
        }

        logger.info("检查激活性");
        if (!persistUser.getIsActive()) {
            logger.debug("尚未激活");
            model.addFlashAttribute(Constant.VM_ERROR, "用户尚未激活");
            logger.debug("重定向至登录页面“{}”", loginUrl);
            return "redirect:" + loginUrl;
        }
        logger.debug("已激活");

        logger.info("session中存储信息");
        //用户、组织
        session.setAttribute(Constant.VS_USER_ID, persistUser.getId());
        session.setAttribute(Constant.VS_USER_NAME, persistUser.getName());
        session.setAttribute(Constant.VS_USER, persistUser);
        session.setAttribute(Constant.VS_ORG_ID, persistUser.getOrganization().getId());
        session.setAttribute(Constant.VS_ORG, persistUser.getOrganization());
        //数据筛选
        Long order = persistUser.getOrganization().getOrder();
        DataShift dataShift = new DataShift(roleService.isSysDataManager(persistUser), roleService.isOrgDataManager(persistUser), persistUser.getId(), TierSerials.getYoungerRange(order, Constant.ORG_ORDER_TIER_LENGTH));
        session.setAttribute(Constant.VS_DATASHIFT, dataShift);

        //菜单
        List<Menu> menus = menuService.findById(InitApplicationConstant.MENUS, menuService.findValidId(persistUser));
        menus = menuService.fullParent(menus);
        session.setAttribute(Constant.VS_MENUS, menus);
        List<Function> functions = functionService.findById(InitApplicationConstant.FUNCTIONS, functionService.findValidId(persistUser));
        session.setAttribute(Constant.VS_FUNCTIONS, functions);
        List<Component> components = componentService.findById(InitApplicationConstant.COMPONENTS, componentService.findValidId(persistUser));
        session.setAttribute(Constant.VS_COMPONENTS, components);

        //功能判断
        BidiMap functionNameCodes = (BidiMap) session.getServletContext().getAttribute(Constant.VC_FUNCTION_CODES);
        List<String> functionCodes = ReflectionUtils.invokeGetterMethod(functions, "code");
        Map<String, Boolean> hasFunctions = new HashMap<String, Boolean>();
        for (Object key : functionNameCodes.keySet()) {
            String value = (String) functionNameCodes.get(key);
            hasFunctions.put((String) key, functionCodes.contains(String.valueOf(value)));
        }
        session.setAttribute(Constant.VS_HAS_FUNCTIONS, hasFunctions);

        //组件判断
        BidiMap componentNameCodes = (BidiMap) session.getServletContext().getAttribute(Constant.VC_COMPONENT_CODES);
        List<String> componentCodes = ReflectionUtils.invokeGetterMethod(components, "code");
        Map<String, Boolean> hasComponents = new HashMap<String, Boolean>();
        for (Object key : componentNameCodes.keySet()) {
            String value = (String) componentNameCodes.get(key);
            hasComponents.put((String) key, componentCodes.contains(String.valueOf(value)));
        }
        session.setAttribute(Constant.VS_HAS_COMPONENTS, hasFunctions);

        //激活的菜单
        List<Menu> activeMenus = menuService.findActive(menus);
        //菜单栏菜单
        List<Menu> menubarMenus = menuService.findByShowlocation(activeMenus, Constants.SHOW_LOCATION_TYPE_MENUBAR);
        session.setAttribute(Constant.VS_MENUBAR_MENUS, menubarMenus);
        List<Menu> menubarFirstMenus = menuService.findByLevel(menubarMenus, 1);
        session.setAttribute(Constant.VS_MENUBAR_FIRST_MENUS, menubarFirstMenus);
        List<Menu> menubarSecoundMenus = menuService.findByLevel(menubarMenus, 2);
        session.setAttribute(Constant.VS_MENUBAR_SECOUND_MENUS, menuService.groupByParentId(menubarSecoundMenus));
        //设置页菜单
        List<Menu> setPageMenus = menuService.findByShowlocation(activeMenus, Constants.SHOW_LOCATION_TYPE_SETPAGE);
        session.setAttribute(Constant.VS_SETPAGE_MENUS, setPageMenus);

        logger.info("session中存储脚本信息");
        Map<String, Object> jsInfo = new HashMap<String, Object>();
        jsInfo.put("ctx", request.getContextPath());
        String jsInfoStr = String.format("$.extend(window,%s)", HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsInfo));
        session.setAttribute(Constant.VS_JS_GLOBALINFO, jsInfoStr);
        logger.debug("基本脚本信息“{}”->“{}”", Constant.VS_JS_GLOBALINFO, jsInfoStr);

        userService.resetDataStoreStatus(persistUser.getId());

        logger.info("初始化系统首页");
        String url = menuService.findDefaultShow(activeMenus).getUrl();
        long timeDiffer = System.currentTimeMillis() - startTime;
        logger.info("登录耗时“{}.{}”", timeDiffer / 1000, timeDiffer % 1000);
        return "redirect:" + url;
    }

    /**
     * 退出
     */
    @RequestMapping(value = "/logout.doself")
    public String logout(SessionStatus sessionStatus, ModelMap modelMap) {
        logger.info("用户“{}”退出系统", modelMap.get(Constant.VS_USER_NAME));
        sessionStatus.setComplete();
        logger.info("清空session中存储的数据");
        modelMap.clear();
        return "redirect:/login.doself";
    }
}
