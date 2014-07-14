package com.baihui.hxtd.soa.base.utils.report;

import ro.nextreports.jofc2.model.Chart;

import java.util.ArrayList;
import java.util.List;

/**
 * 报表模型数据
 * 显示在报表生成页面
 *
 * @author xiayouxue
 * @date 14-7-13
 */
public class ChartModel {

    private String title;
    private ChartTable chartTable;
    private List<Chart> charts;
    private List<String> stringCharts = new ArrayList<String>();

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

    public List<Chart> getCharts() {
        return charts;
    }

    public void setCharts(List<Chart> charts) {
        this.charts = charts;
    }

    public List<String> getStringCharts() {
        return stringCharts;
    }

    public void setStringCharts(List<String> stringCharts) {
        this.stringCharts = stringCharts;
    }
}
