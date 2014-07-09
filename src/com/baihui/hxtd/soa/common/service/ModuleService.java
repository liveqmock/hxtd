package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.Desc;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.common.dao.ModuleDao;
import com.baihui.hxtd.soa.common.entity.Module;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.lang.reflect.Field;
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
     * 获取字段描述
     */
    public String getDesc(Class clazz, String fieldName) {
        Field[] fields = InitApplicationConstant.FIELDS.get(clazz);
        for (int i = 0; i < fields.length; i++) {
            if (fields[i].getName().equals(fieldName)) {
                Desc annotation = fields[i].getAnnotation(Desc.class);
                return annotation.value();
            }
        }
        return null;
    }


}
