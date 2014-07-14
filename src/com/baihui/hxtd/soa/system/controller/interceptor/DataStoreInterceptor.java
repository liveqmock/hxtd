package com.baihui.hxtd.soa.system.controller.interceptor;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.RequestUtil;
import com.baihui.hxtd.soa.base.utils.UrlUtil;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Menu;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.system.service.MenuService;
import com.baihui.hxtd.soa.util.Constants;
import org.apache.commons.collections.BidiMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 数据存储拦截器
 * 1.对toPage类请求进行拦截存储数据
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
public class DataStoreInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private FunctionService functionService;
    @Resource
    private MenuService menuService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("数据存储");
        logger.debug("客户端请求“{}”", request.getRequestURI());

        if (RequestUtil.isAjax(request)) {
            logger.info("是一个ajax请求，跳过数据存储");
            return true;
        }

        String uri = request.getRequestURI().replaceFirst(request.getContextPath(), "");
        Function function = (Function) request.getAttribute(Constant.VR_FUNCTION);
        if (function == null) {
            String funcUrl = UrlUtil.exec(uri);
            function = functionService.getRequest(funcUrl);
        }
        logger.info("对应的功能URI“{}”", function.getUrl());

        logger.info("request中缓存信息");
        List<Menu> menus = new ArrayList<Menu>();
        Menu lastMenu = function.getMenu();
        Menu firstMenu = lastMenu;
        if (lastMenu.getParent() != null) {
            firstMenu = lastMenu.getParent();
            menus.add(firstMenu);
        }
        menus.add(lastMenu);
        menuService.toTriggerUrl(menus);
        request.setAttribute("isMenuFunction", function.equals(lastMenu.getTrigger()));

        if (Constants.SHOW_LOCATION_TYPE_SETPAGE.equals(lastMenu.getShowLocationType())) {
            menus.add(0, Menu.SETTING);
        }

        request.setAttribute(Constant.VR_FIRST_MENU, firstMenu);
        logger.debug("菜单栏位置对应的一级菜单“{}”->“{}”", Constant.VR_FIRST_MENU, firstMenu.getName());
        request.setAttribute(Constant.VR_TITLE_MENUS, menus);
        logger.debug("菜单集合数目“{}”", menus.size());
        request.setAttribute(Constant.VR_LAST_MENU, lastMenu);
        logger.debug("叶子节点菜单“{}”", lastMenu.getName());
        Function cloneFunction = function.clone();
        cloneFunction.setUrl(UrlUtil.toPage(function.getUrl()));
        request.setAttribute(Constant.VR_TITLE_FUNCTION, cloneFunction);
        logger.debug("标题部分功能“{}”", function.getName());
        request.setAttribute(Constant.VR_FUNCTION, function);
        logger.debug("功能“{}”", function.getName());
        logger.info("功能检查，一个页面上执行多个功能时以此判断");
        BidiMap functionNameCodes = (BidiMap) request.getSession().getServletContext().getAttribute(Constant.VC_FUNCTION_CODES);
        Object functionName = functionNameCodes.getKey(function.getCode());
        if (functionName != null) {
            request.setAttribute((String) functionName, true);
        }
        Date date = new Date();
        request.setAttribute(Constant.VR_DATE, date);
        logger.debug("当前时间“{}”", date);
        request.setAttribute(Constant.VR_PARAMS, Servlets.encodeParameterStringWithPrefix(Servlets.getParametersStartingWith(request, ""), ""));

        Map<String, Object> jsRequest = new HashMap<String, Object>();
        jsRequest.put("time", date);
        String jsRequestJson = String.format("$.extend(window,%s)", HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsRequest));
        request.setAttribute(Constant.VR_JS_GLOBALINFO, jsRequestJson);
        logger.debug("脚本信息“{}”", jsRequestJson);

        Long interceptorStartTime = (Long) request.getAttribute("interceptorStartTime");
        if (interceptorStartTime != null) {
            long timeDiffer = System.currentTimeMillis() - interceptorStartTime;
            logger.info("拦截器耗时“{}.{}”", timeDiffer / 1000, timeDiffer % 1000);
        }

        return super.preHandle(request, response, handler);
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }

    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        super.afterConcurrentHandlingStarted(request, response, handler);
    }

}
