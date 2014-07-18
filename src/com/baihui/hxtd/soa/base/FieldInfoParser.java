package com.baihui.hxtd.soa.base;

import com.baihui.hxtd.soa.common.entity.ModuleField;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * 字段信息注解解析器
 *
 * @author xiayouxue
 * @date 2014/7/17
 */
public class FieldInfoParser {

    /** 转换为ModuleField */
    public static ModuleField toModuleField(Field field) {
        FieldInfo annotation = field.getAnnotation(FieldInfo.class);
        if (annotation != null) {
            return new ModuleField(field.getName(), annotation.desc(), annotation.dictionary());
        }
        return new ModuleField(field.getName(), "", "");
    }

    /** 转换为ModuleField */
    public static List<ModuleField> toModuleField(Field[] fields) {
        List<ModuleField> moduleFields = new ArrayList<ModuleField>();
        for (int i = 0; i < fields.length; i++) {
            moduleFields.add(toModuleField(fields[i]));
        }
        return moduleFields;
    }

}
