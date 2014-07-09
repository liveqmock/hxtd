package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.common.dao.ModuleTypeDao;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 模块类型服务类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Service
public class ModuleTypeService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ModuleTypeDao moduleTypeDao;

    @Resource
    private DictionaryDao dictionaryDao;

    /**
     * 查找模块通过类型主键编号
     */
    @Transactional(readOnly = true)
    public List<Module> findByTypeId(Long typeId) {
        logger.info("查找模块通过类型主键编号");
        String hql = "select moduleType.module from ModuleType moduleType inner join moduleType.type type where type.id=?";
        return moduleTypeDao.find(hql, typeId);
    }

    /**
     * 查找模块通过类型值
     */
    @Transactional(readOnly = true)
    public List<Module> findByTypeValue(String typeValue) {
        logger.info("查找模块通过类型值");
        return findByTypeId(dictionaryDao.getIdByValue(typeValue));
    }


}
