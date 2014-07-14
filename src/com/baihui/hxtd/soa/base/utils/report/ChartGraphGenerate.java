package com.baihui.hxtd.soa.base.utils.report;

/**
 * 报表生成器
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public interface ChartGraphGenerate {

    /**
     * 生成二维报表
     */
    public ChartGraph generateTwoDimensionChart(ReportGraph reportGraph);

    /**
     * 生成三维报表
     */
    public ChartGraph generateThreeDimensionChart(ReportGraph reportGraph);


}
