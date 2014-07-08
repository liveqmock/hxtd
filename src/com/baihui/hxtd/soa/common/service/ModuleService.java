package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.common.dao.ModuleDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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


}
