package com.baihui.hxtd.soa.common.controller;

import com.baihui.common.util.Dates;
import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.utils.report.ChartModel;
import com.baihui.hxtd.soa.common.service.WarningService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.Range;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import java.util.*;

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
        Date date = new Date();
        Range<Date> monthRange = Dates.differExactRange(date, Calendar.DATE, 30);
        List rows = warningService.findOrderPayment(monthRange);

        Map<String, ChartModel> chartModelMap = new LinkedHashMap<String, ChartModel>();
        ChartModel monthChart = warningService.generateChartModel(monthRange, rows);
        chartModelMap.put("monthChart", monthChart);

        Range<Date> halfMonthRange = Dates.differExactRange(date, Calendar.DATE, 15);
        rows = warningService.filterOrderPayment(rows, halfMonthRange);
        ChartModel halfMonthChart = warningService.generateChartModel(halfMonthRange, rows);
        chartModelMap.put("halfMonthChart", halfMonthChart);

        Range<Date> weekRange = Dates.differExactRange(date, Calendar.DATE, 7);
        rows = warningService.filterOrderPayment(rows, weekRange);
        ChartModel weekChart = warningService.generateChartModel(weekRange, rows);
        chartModelMap.put("weekChart", weekChart);

        modelMap.addAttribute("charts", chartModelMap);
        return "/common/warning/view";
    }


}
