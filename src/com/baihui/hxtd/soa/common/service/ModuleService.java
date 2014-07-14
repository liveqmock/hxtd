package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.common.dao.ModuleDao;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.ModuleField;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

/**
 * 模块服务类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Service
public class ModuleService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ModuleDao moduleDao;

    /**
     * 查找所有模块
     */
    @Transactional(readOnly = true)
    public List<Module> findAll() {
        return moduleDao.getAll();
    }

    /**
     * 查找模块的关联模块
     * 1.通过主键编号获取模块
     * 2.通过模块entityClass获取字段
     * 3.从字段中过滤出关联模块字段
     * 3.1.根据字段的class是否存在于模块列表中
     */
    public List<Module> findAssociation(Module sourceModule, List<Module> filterModules) {
        logger.info("查找模块的关联模块");
        logger.debug("模块=“{}”", sourceModule.getDesc());

        List<Module> targetModules = new ArrayList<Module>();

        Field[] sourceFields = sourceModule.getFields();
        for (int i = 0; i < sourceFields.length; i++) {
            Field field = sourceFields[i];
            Class fieldType = getFieldType(field);
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

    /**
     * 获取字段类型
     */
    @SuppressWarnings("unchecked")
    public static Class getFieldType(Field field) {
        Class fieldType = field.getType();
        if (fieldType.isAssignableFrom(Collection.class)) {
            ParameterizedType pt = (ParameterizedType) field.getGenericType();
            fieldType = (Class) pt.getActualTypeArguments()[0];
        }
        return fieldType;
    }

    /**
     * 是否关联模块
     */
    public static boolean isAssociation(Field field, List<Module> allModules) {
        Class fieldType = getFieldType(field);
        for (int i = 0; i < allModules.size(); i++) {
            Module module = allModules.get(i);
            if (fieldType.equals(module.getEntityClazz())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 获取模块通过主键编号
     */
    public static Module findById(Long id) {
        return ReflectionUtils.findNameValueMatched(InitApplicationConstant.MODULES, "id", id);
    }

    /**
     * 获取字段通过字段名
     */
    public static Field findFieldByName(Field[] fields, String name) {
        return ReflectionUtils.findNameValueMatched(Arrays.asList(fields), "name", name);
    }

    /**
     * 查找模块及其关联模块
     */
    public List<Module> findModuleAndAssociation(Long id) {
//        Module sourceModule = ReflectionUtils.findNameValueMatched(InitApplicationConstant.MODULES, "id", id);
//        List<Module> referModules = findAssociation(sourceModule, InitApplicationConstant.MODULES);
//        List<Module> listModules = new ArrayList<Module>();
//        listModules.add(sourceModule);
//        listModules.addAll(referModules);
        List<Module> listModules = ReflectionUtils.findNameValueMatcheds(InitApplicationConstant.MODULES, "id", id);
        return listModules;
    }

    /**
     * 转换为ModuleField
     */
    public static List<ModuleField> toModuleField(Field[] fields) {
        List<ModuleField> moduleFields = new ArrayList<ModuleField>();
        for (int i = 0; i < fields.length; i++) {
            moduleFields.add(toModuleField(fields[i]));
        }
        return moduleFields;
    }

    /**
     * 转换为ModuleField
     */
    public static ModuleField toModuleField(Field field) {
        String value = "";
        FieldInfo annotation = field.getAnnotation(FieldInfo.class);
        if (annotation != null) {
            value = annotation.desc();
        }
        return new ModuleField(field.getName(), value);
    }


}
