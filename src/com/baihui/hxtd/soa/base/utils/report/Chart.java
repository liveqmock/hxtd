package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * 报表数据
 *
 * @author xiayx
 * @date 14-7-13
 */
public class Chart {

    private String title;
    private ChartTable chartTable;
    private List<ChartGraph> chartGraphs;

    public Chart() {
    }

    public Chart(String title) {
        this.title = title;
    }

    public Chart(String title, ChartTable chartTable) {
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

    public List<ChartGraph> getChartGraphs() {
        return chartGraphs;
    }

    public void setChartGraphs(List<ChartGraph> chartGraphs) {
        this.chartGraphs = chartGraphs;
    }
}
