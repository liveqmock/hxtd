package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.common.service.ModuleTypeService;
import com.baihui.hxtd.soa.common.service.ReportService;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.util.JsonDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springside.modules.web.Servlets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 报表控制类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Controller
@RequestMapping("/common/report")
@SessionAttributes(value = {Constant.VS_USER_ID, Constant.VS_USER_NAME, Constant.VS_USER,
        Constant.VS_ORG_ID, Constant.VS_ORG, Constant.VS_DATASHIFT,
        Constant.VS_MENUS, Constant.VS_ROLES, Constant.VS_FUNCTIONS, Constant.VS_COMPONENTS})
public class ReportController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ReportService reportService;

    @Resource
    private ModuleTypeService moduleTypeService;

    @RequestMapping("/toQueryPage")
    public String toQueryPage(HibernatePage<Report> page, ModelMap modelMap) {

        page.setHibernateOrderBy("modifiedTime");
        page.setHibernateOrder("desc");
        modelMap.addAttribute("page", page);

        modelMap.addAttribute("modules", moduleTypeService.findByTypeValue(DictionaryConstant.MODULE_TYPE_REPORT));

        return "/common/report/list";
    }

    @ResponseBody
    @RequestMapping(value = "/query.do")
    public String query(HttpServletRequest request, HibernatePage<Report> page, ModelMap modelMap) throws NoSuchFieldException, JsonProcessingException {
        logger.info("查询");

        logger.info("解析页面查询条件");
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Search.clearBlankValue(searchParams);
        Search.trimValue(searchParams);
        logger.debug("查询条件数目“{}”", searchParams.size());

        logger.info("查询分页列表信息");
        DataShift dataShift = (DataShift) modelMap.get(Constant.VS_DATASHIFT);
        page = reportService.findPage(searchParams, page, dataShift.renameUserFieldName("creator"));
        logger.debug("列表信息数目“{}”", page.getResult().size());

        logger.info("转换为TDO格式");
        JsonDto jsonDto = new JsonDto();
        jsonDto.setSuccessFlag(true);
        jsonDto.setResult(page);

        return HibernateAwareObjectMapper.DEFAULT.writeValueAsString(jsonDto);
    }


    @RequestMapping("/toGeneratePage")
    public String toGeneratePage(ModelMap modelMap) {
        String data = reportService.generate();
        modelMap.put("data", data);
        return "/common/report/report";
    }


}
