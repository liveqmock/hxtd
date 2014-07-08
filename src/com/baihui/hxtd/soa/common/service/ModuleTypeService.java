package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.common.dao.ModuleTypeDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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


}
