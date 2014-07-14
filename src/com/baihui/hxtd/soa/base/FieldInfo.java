package com.baihui.hxtd.soa.base;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * 字段信息注解
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
@Target({METHOD, FIELD})
@Retention(RUNTIME)
public @interface FieldInfo {
    /**字段描述*/
    String desc();

    /**对应字典值*/
    String dictionary() default "";
}
