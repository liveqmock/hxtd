package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.ModuleField;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 模块工具类
 *
 * @author xiayouxue
 * @date 2014/7/17
 */
public class ModuleUtil {

    private static Logger logger = LoggerFactory.getLogger(ModuleUtil.class);


    /** 获取字段通过字段名 */
    public static Field findFieldByName(Field[] fields, String name) {
        return ReflectionUtils.findNameValueMatched(Arrays.asList(fields), "name", name);
    }

    /** 获取模块字段通过字段名 */
    public static ModuleField findModuleFieldByName(ModuleField[] moduleFields, String name) {
        return ReflectionUtils.findNameValueMatched(Arrays.asList(moduleFields), "name", name);
    }

    /** 是否关联模块 */
    public static boolean isAssociation(Field field, List<Module> allModules) {
        Class fieldType = ReflectionUtils.getEntityFieldType(field);
        for (int i = 0; i < allModules.size(); i++) {
            Module module = allModules.get(i);
            if (fieldType.equals(module.getEntityClazz())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 查找模块的关联模块
     * 1.通过主键编号获取模块
     * 2.通过模块entityClass获取字段
     * 3.从字段中过滤出关联模块字段
     * 3.1.根据字段的class是否存在于模块列表中
     */
    public static List<Module> findAssociation(Module sourceModule, List<Module> filterModules) {
        logger.info("查找模块的关联模块");
        logger.debug("模块=“{}”", sourceModule.getDesc());

        List<Module> targetModules = new ArrayList<Module>();

        Field[] sourceFields = sourceModule.getFields();
        for (int i = 0; i < sourceFields.length; i++) {
            Field field = sourceFields[i];
            Class fieldType = ReflectionUtils.getEntityFieldType(field);
            for (int j = 0; j < filterModules.size(); j++) {
                Module module = filterModules.get(j);
                if (fieldType.equals(module.getEntityClazz())) {
                    targetModules.add(module);
                    break;
                }
            }
        }

        return targetModules;
    }
}
