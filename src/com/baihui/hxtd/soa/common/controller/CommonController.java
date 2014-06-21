package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.common.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 基础公用的控制器
 *
 * @author xiayouxue
 * @date 2014/6/20
 */
@Controller
@RequestMapping("/common/common")
public class CommonController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private CommonService commonService;

    /**
     * 唯一性验证
     */
    @ResponseBody
    @RequestMapping("/unique.docomp")
    public Boolean checkUnique(String entityName, String fieldName, String fieldValue) {
        logger.info("唯一性验证");
        fieldValue = fieldValue.trim();
        logger.debug("实体“{}”字段“{}”值“{}”", entityName, fieldName, fieldValue);
        return commonService.checkUnique(entityName, fieldName, fieldValue);
    }
}
