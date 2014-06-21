package com.baihui.hxtd.soa.system.controller.interceptor;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.RequestUtil;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.service.FunctionService;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 功能权限认证拦截器
 * 1.根据已分配功能权限来验证
 * 1.1.对于从菜单链接的请求，菜单下有任一功能，该请求成立
 * 1.2.对于从功能链接的请求，用户要含有该功能权限
 * 2.每个请求必须对应一个功能，否则跳转至没有权限页面
 * 3.要求菜单的URL必须能匹配到一个含有相同URL的功能
 * .根据session中存储的功能来验证
 * .一个功能的请求包括页面跳转和功能执行
 * .页面跳转时，需要在request中存储数据
 *
 * @author xiayouxue
 * @date 2014/5/7
 */
public class AuthorityFilterFunctionInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value(value = "${system.function.privilegelevel.identity}")
    private String privilegeLevelAuthorityValue = "01060103";

    @Resource
    private FunctionService functionService;

    @SuppressWarnings("unchecked")
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("功能权限认证");
        logger.debug("客户端请求“{}”", request.getRequestURI());

        logger.info("检查请求URL权限级别");
        Dictionary privilegeLevel = (Dictionary) request.getAttribute("privilegeLevel");
        if (Integer.parseInt(privilegeLevel.getValue()) < Integer.parseInt(privilegeLevelAuthorityValue)) {
            logger.info("权限认证级别以上，无需进行权限认证");
            return super.preHandle(request, response, handler);
        }
        logger.info("权限认证级别或者其下，需要进行权限认证");

        Function function = (Function) request.getAttribute(Constant.VR_FUNCTION);
        String invalidURI = request.getContextPath() + "/error/403.do";
        List<Function> functions = (List<Function>) request.getSession().getAttribute(Constant.VS_FUNCTIONS);
        if (!functions.contains(function)) {
            logger.debug("没有对应功能，检查不通过，重定向至没有访问权限页面“{}”", invalidURI);
            if (RequestUtil.isAjax(request)) {
                JsonDto jsonDto = new JsonDto("没有对应功能");
                String result = jsonDto.toString();
                logger.debug("是一个Ajax请求，返回JSON对象“{}”", result);
                response.getWriter().write(result);
            } else {
                response.sendRedirect(invalidURI);
            }
            return false;
        }
        logger.debug("含有对应功能，检查通过");

        request.setAttribute(Constant.VR_FUNCTION, function);
        logger.info("request中缓存功能“{}”", function.getName());

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
