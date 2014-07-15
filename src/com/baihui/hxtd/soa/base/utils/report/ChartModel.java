package com.baihui.hxtd.soa.base.utils.report;

/**
 * 报表模型数据
 * 显示在报表生成页面
 *
 * @author xiayouxue
 * @date 14-7-13
 */
public class ChartModel {

    /** 标题 */
    private String title;

    /** 表格 */
    private ChartTable chartTable;

    /** 报表 */
    private String chart;

    public ChartModel() {
    }

    public ChartModel(String title) {
        this.title = title;
    }

    public ChartModel(String title, ChartTable chartTable) {
        this.title = title;
        this.chartTable = chartTable;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public ChartTable getChartTable() {
        return chartTable;
    }

    public void setChartTable(ChartTable chartTable) {
        this.chartTable = chartTable;
    }

    public String getChart() {
        return chart;
    }

    public void setChart(String chart) {
        this.chart = chart;
    }
}
