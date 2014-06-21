package com.baihui.hxtd.soa.base.utils;

import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.lang3.StringUtils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.*;

/**
 * 类型转换工具类
 */
public class ConvertUtils {

    static {
        registerDateConverter();
    }


    /**
     * 转换对象到Map
     */
    public static Map<String, Object> convertObjectToMap(Object object, String... includeFieldNames) {
        Map<String, Object> objectMap = new HashMap<String, Object>();
        Class clazz = object.getClass();
        try {
            for (String fieldName : includeFieldNames) {
                Method method;
                try {
                    method = clazz.getDeclaredMethod("get" + StringUtils.capitalize(fieldName));
                } catch (NoSuchMethodException e) {
                    continue;
                }
                Object invoke;
                try {
                    invoke = method.invoke(object);
                } catch (InvocationTargetException e) {
                    continue;
                }
                objectMap.put(fieldName, method.getReturnType().cast(invoke));
            }
        } catch (IllegalAccessException e) {
            throw new RuntimeException("对象转换到Map异常", e);
        }
        return objectMap;
    }

    /**
     * 转换集合
     */
    public static List<Map<String, Object>> convertCollection(List sources, String... includeFieldNames) {
        List<Map<String, Object>> targets = new ArrayList<Map<String, Object>>(sources.size());
        for (Object source : sources) {
            targets.add(convertObjectToMap(source, includeFieldNames));
        }
        return targets;
    }


    /**
     * 转换字符串到相应类型.
     *
     * @param value  待转换的字符串.
     * @param toType 转换目标类型.
     */
    public static Object convertStringToObject(String value, Class<?> toType) {
        try {
            return org.apache.commons.beanutils.ConvertUtils.convert(value, toType);
        } catch (Exception e) {
            throw ReflectionUtils.convertReflectionExceptionToUnchecked(e);
        }
    }

    /**
     * 定义日期Converter的格式: yyyy-MM-dd 或 yyyy-MM-dd HH:mm:ss
     */
    private static void registerDateConverter() {
        DateConverter dc = new DateConverter();
        dc.setUseLocaleFormat(true);
        dc.setPatterns(new String[]{"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"});
        org.apache.commons.beanutils.ConvertUtils.register(dc, Date.class);
    }

    /**
     * 对象转换为字符串
     *
     * @param obj
     * @return
     */
    public static String obj2String(Object obj) {
        if (obj == null) {
            return "";
        } else {
            return obj.toString();
        }
    }

    /**
     * 对象转换为数值
     *
     * @param obj
     * @return
     */
    public static Integer obj2Integer(Object obj) {
        if (obj == null) {
            return 0;
        } else {
            if ("".equals(obj.toString())) {
                return 0;
            } else {
                return Integer.valueOf(obj.toString());
            }
        }
    }

    /**
     * 对象转换为数值
     *
     * @param obj
     * @return
     */
    public static Long obj2Long(Object obj) {
        if (obj == null) {
            return 0L;
        } else {
            if ("".equals(obj.toString())) {
                return 0L;
            } else {
                return Long.valueOf(obj.toString());
            }
        }
    }

    /**
     * 对象转换为数值
     *
     * @param obj
     * @return
     */
    public static BigDecimal obj2BigDecimal(Object obj) {
        if (obj == null) {
            return BigDecimal.valueOf(0);
        } else {
            if ("".equals(obj.toString())) {
                return BigDecimal.valueOf(0);
            } else {
                return new BigDecimal(obj.toString());
            }
        }
    }
}
