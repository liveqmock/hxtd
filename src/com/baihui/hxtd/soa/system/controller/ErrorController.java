package com.baihui.hxtd.soa.system.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.RequestUtil;
import com.baihui.hxtd.soa.util.JsonDto;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 错误页面控制器
 *
 * @author xiayouxue
 * @date 2014/4/25
 */
@Controller
@RequestMapping(value = "/error")
public class ErrorController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @RequestMapping(value = "/adapter.do")
    public void adapter(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        logger.info("异常适配处理{}", request.getRequestURI());
        Exception exception = (Exception) request.getAttribute(SimpleMappingExceptionResolver.DEFAULT_EXCEPTION_ATTRIBUTE);
        logger.error("捕获到异常", exception);


        logger.info("返回失败结果");
        if (RequestUtil.isAjax(request)) {
            JsonDto jsonDto = new JsonDto("操作失败");
            String result = jsonDto.toString();
            logger.debug("是一个Ajax请求，返回JSON对象“{}”", result);
            response.getWriter().write(result);
            return;
        }

        String errorForwardUri = request.getParameter("errorForwardUri");
        if (StringUtils.isBlank(errorForwardUri)) {
            errorForwardUri = "/error/500.do";
        }
        request.setAttribute(Constant.VM_BUSINESS, exception.getMessage());
        logger.debug("是一个常规请求，转至“{}”页面", errorForwardUri);

        try {
            if (!response.isCommitted()) {
                request.getRequestDispatcher(errorForwardUri).forward(request, response);
            } else {
                logger.warn("response 已经提交，不进行页面跳转！");
            }
        } catch (ServletException e) {
            logger.error("跳转异常", e);
        } catch (IOException e) {
            logger.error("跳转异常", e);
        }
    }

    @RequestMapping(value = "/{code}.do")
    public String index(@PathVariable(value = "code") String code) {
        logger.info("转发至错误页面“{}”", code);
        return "/error/" + code;
    }


}
