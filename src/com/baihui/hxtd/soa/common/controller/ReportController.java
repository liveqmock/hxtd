package com.baihui.hxtd.soa.common.controller;

import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.common.service.ReportService;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * 报表控制类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Controller
@RequestMapping("/common/report")
public class ReportController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ReportService reportService;

    @RequestMapping("/toQueryPage")
    public String toQueryPage(ModelMap modelMap) {
        return "/common/report/list";
    }


    @RequestMapping("/toGeneratePage")
    public String toGeneratePage(ModelMap modelMap) {
        String data = reportService.generate();
        return "/common/report/report";
    }


}
