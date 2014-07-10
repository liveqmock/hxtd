package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.service.ModuleService;
import com.baihui.hxtd.soa.util.BusinessResult;
import com.baihui.hxtd.soa.util.JsonDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import java.util.List;

/**
 * 模块控制类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Controller
@RequestMapping("/common/module")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_ORG, Constant.VS_DATASHIFT,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class ModuleController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ModuleService moduleService;

    /**
     * 查找模块字段通过模块主键编号
     */
    @ResponseBody
    @RequestMapping("/findModuleFields.docomp")
    public String findModuleFields(Long id) {
        logger.info("查找模块字段通过模块主键编号");
        logger.debug("模块主键编号=“{}”", id);

        List<Module> listModules = moduleService.findModuleAndAssociation(id);

        JsonDto jsonDto = new JsonDto();
        jsonDto.setResult(new BusinessResult<List<Module>>(listModules));
        String result = jsonDto.toString();
        logger.debug("result={}", result);
        return result;
    }


}
