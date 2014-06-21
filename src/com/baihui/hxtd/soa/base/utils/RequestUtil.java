package com.baihui.hxtd.soa.base.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * 请求工具类
 *
 * @author xiayouxue
 * @date 2014/6/20
 */
public class RequestUtil {

    /**
     * 是否ajax请求
     */
    public static boolean isAjax(HttpServletRequest request) {
        String requestType = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equals(requestType);
    }

}
