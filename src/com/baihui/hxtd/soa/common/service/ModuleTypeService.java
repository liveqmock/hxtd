package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.common.dao.ModuleTypeDao;
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

    /**
     * 查找模块主键编号通过类型编号
     */
    @Transactional(readOnly = true)
    public List<Long> findModuleIdByTypeId(Long typeId) {
        logger.info("查找模块主键编号通过类型编号");
        logger.debug("类型编号=“{}”", typeId);
        return moduleTypeDao.findModuleIdByTypeId(typeId);
    }


}
