package com.baihui.hxtd.soa.base.utils.report;

import ro.nextreports.jofc2.model.Chart;

/**
 * 报表生成器
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public interface ChartGenerate {

    /**
     * 生成二维报表
     */
    public Chart generateTwoDimensionChart(ReportChart reportChart);

    /**
     * 生成三维报表
     */
    public Chart generateThreeDimensionChart(ReportChart reportChart);


}
