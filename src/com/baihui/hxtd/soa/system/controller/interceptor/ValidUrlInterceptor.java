package com.baihui.hxtd.soa.system.controller.interceptor;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.RequestUtil;
import com.baihui.hxtd.soa.base.utils.UrlUtil;
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.service.ComponentService;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 有效URL拦截器
 * 1.功能和组件表中包含的URL是有效的，其他一律视为无效，跳转至404页面
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
public class ValidUrlInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private FunctionService functionService;
    @Resource
    private ComponentService componentService;


    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.setAttribute("interceptorStartTime", System.currentTimeMillis());

        logger.info("请求URL认证");
        logger.debug("客户端请求“{}”", request.getRequestURI());

        logger.info("查找对应功能或组件");
        Dictionary dictionary;
        String uri = request.getRequestURI().replaceFirst(request.getContextPath(), "");
        uri = UrlUtil.filterJsessionid(uri);
        uri = UrlUtil.exec(uri);
        logger.debug("执行URI“{}”", uri);
        Function function = functionService.getRequest(uri);
        if (function == null) {
            logger.info("未找到对应功能，查找对应组件");
            Component component = componentService.getRequest(uri);
            if (component == null) {
                if (RequestUtil.isAjax(request)) {
                    JsonDto jsonDto = new JsonDto("未找到对应功能或者组件");
                    String result = jsonDto.toString();
                    response.getWriter().write(result);
                    logger.debug("是一个Ajax请求，返回JSON对象“{}”", result);
                } else {
                    logger.info("未找到对应组件，转至404页面");
                    request.getRequestDispatcher("/error/404.do").forward(request, response);
                }
                return false;
            }
            logger.info("找到对应组件，存储组件");
            request.setAttribute(Constant.VR_COMPONENT, component);
            dictionary = component.getPrivilegeLevel();
        } else {
            logger.info("找到对应功能，存储功能");
            request.setAttribute(Constant.VR_FUNCTION, function);
            dictionary = function.getPrivilegeLevel();
        }
        request.setAttribute("privilegeLevel", dictionary);

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
