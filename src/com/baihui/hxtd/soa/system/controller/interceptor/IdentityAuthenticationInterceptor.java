package com.baihui.hxtd.soa.system.controller.interceptor;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.RequestUtil;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 身份认证拦截器
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
public class IdentityAuthenticationInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value(value = "${application.login_url}")
    private String loginUrl = "/login.doself";
    //    @Value(value = "${system.function.privilegelevel.public}")
    private String privilegeLevelIdentityValue = "01060102";


    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("身份认证");
        logger.debug("客户端请求“{}”", request.getRequestURI());

        logger.info("检查请求URL权限级别");
        Dictionary privilegeLevel = (Dictionary) request.getAttribute("privilegeLevel");
        if (Integer.parseInt(privilegeLevel.getValue()) < Integer.parseInt(privilegeLevelIdentityValue)) {
            logger.info("身份认证级别以上，无需进行身份认证");
            return super.preHandle(request, response, handler);
        }
        logger.info("身份认证级别或者其下，需要进行身份认证");

        logger.debug("检查session中是否存储变量“{}”", Constant.VS_SESSION_CHECK);
        if (request.getSession().getAttribute(Constant.VS_SESSION_CHECK) == null) {
            if (RequestUtil.isAjax(request)) {
                JsonDto jsonDto = new JsonDto("您太长时间没有操作，请重新登录！");
                jsonDto.setSessionIsTimeOut(true);
                String result = jsonDto.toString();
                logger.debug("是一个Ajax请求，返回JSON对象“{}”", result);
                response.getWriter().write(result);
            } else {
                String loginUrl = request.getContextPath() + this.loginUrl;
                logger.debug("未存储，认证未通过，重定向至登录页面“{}”", loginUrl);
                request.getSession().setAttribute(Constant.VM_ERROR, "用户未登录或已过期，请重新登录");
                response.sendRedirect(loginUrl);
            }
            return false;
        }
        logger.debug("已存储，认证通过");

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
