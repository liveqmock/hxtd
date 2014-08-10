package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.report.ChartModel;
import com.baihui.hxtd.soa.common.service.WarningService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;

/**
 * 预警管理
 *
 * @author xiayouxue
 * @date 2014/8/7
 */
@Controller
@RequestMapping("/common/warning")
@SessionAttributes(value = {Constant.VS_USER, Constant.VS_ORG_ID, Constant.VS_ORG, Constant.VS_DATASHIFT})
public class WarningController {

    @Resource
    private WarningService warningService;

    @RequestMapping("/toViewPage")
    public String toViewPage(ModelMap modelMap) {
        ChartModel weekChart = warningService.countOrderPaymentInWeek();
        modelMap.addAttribute("weekChart", weekChart);
        ChartModel monthChart = warningService.countOrderPaymentInMonth();
        modelMap.addAttribute("monthChart", monthChart);
        return "/common/warning/view";
    }


}
