package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.common.dao.ModuleDao;
import com.baihui.hxtd.soa.common.entity.Module;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.util.ArrayList;
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


}
