package com.baihui.hxtd.soa.system.controller.interceptor;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.RequestUtil;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 组件权限认证拦截器
 *
 * @author xiayouxue
 * @date 2014/5/7
 */
public class AuthorityFilterComponentInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @SuppressWarnings("unchecked")
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("组件权限认证");
        logger.debug("客户端请求“{}”", request.getRequestURI());

        logger.info("检查请求URL权限级别");
        Dictionary privilegeLevel = (Dictionary) request.getAttribute("privilegeLevel");
        if (Integer.parseInt(privilegeLevel.getValue()) < Integer.parseInt(DictionaryConstant.FUNCTION_PRIVILEGELEVEL_AUTHORITY)) {
            logger.info("权限认证级别以上，无需进行权限认证");
            return super.preHandle(request, response, handler);
        }
        logger.info("权限认证级别或者其下，需要进行权限认证");


        logger.info("权限组件检查");
        Component component = (Component) request.getAttribute(Constant.VR_COMPONENT);
        String invalidURI = request.getContextPath() + "/error/403.do";
        List<Component> components = (List<Component>) request.getSession().getAttribute(Constant.VS_COMPONENTS);
        if (!components.contains(component)) {
            logger.debug("没有对应组件，检查不通过，重定向至没有访问权限页面“{}”", invalidURI);
            if (RequestUtil.isAjax(request)) {
                JsonDto jsonDto = new JsonDto("没有对应组件");
                String result = jsonDto.toString();
                logger.debug("是一个Ajax请求，返回JSON对象“{}”", result);
                response.getWriter().write(result);
            } else {
                response.sendRedirect(invalidURI);
            }
            return false;
        }
        logger.info("含有对应组件，检查通过");

        request.setAttribute(Constant.VR_COMPONENT, component);
        logger.info("request中缓存组件，“{}”", component.getName());

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
