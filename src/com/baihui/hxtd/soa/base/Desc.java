package com.baihui.hxtd.soa.base;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * 字段描述注解
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
@Retention(RetentionPolicy.RUNTIME)
public @interface Desc {
    String value() default "";
}
