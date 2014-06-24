package com.baihui.hxtd.soa.system.controller.interceptor;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.RequestUtil;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.service.UserService;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 数据存储状态拦截器
 * 1.用户数据存储状态更新后，强制退出，给予提示
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
public class DataStoreStatusInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value(value = "${application.logout_url}")
    private String logoutUrl = "/logout.doself";

    @Resource
    private UserService userService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("数据存储状态检查");
        logger.debug("客户端请求“{}”", request.getRequestURI());

        Long userId = (Long) request.getSession().getAttribute(Constant.VS_USER_ID);
        String storeStatusValue = userService.getStoreStatusById(userId);
        if (DictionaryConstant.USER_STORESTATUS_DELAYED.equals(storeStatusValue)) {
            String logoutUrl = request.getContextPath() + this.logoutUrl;
            logger.debug("延迟状态，检查未通过。重定向至退出请求“{}”", logoutUrl);
            //TODO 无法给出错误提示，退出时会清除session，重新设计接口，通过参数传参
            request.getSession().setAttribute(Constant.VM_ERROR, "权限已更新，请重新登录系统");
            if (RequestUtil.isAjax(request)) {
                JsonDto jsonDto = new JsonDto("用户权限已更新，请重新登录系统");
                String result = jsonDto.toString();
                logger.debug("是一个Ajax请求，返回JSON对象“{}”", result);
                response.getWriter().write(result);
            } else {
//                request.setAttribute(Constant.VM_GLOBAL, "用户权限已更新，请重新登录系统");
                response.sendRedirect(logoutUrl);
            }
            return false;
        }
        logger.debug("最新状态，检查通过");

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
