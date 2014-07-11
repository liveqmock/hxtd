package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * @author Administrator
 * @date 14-7-11
 */
public class ChartTabel {

    private String title;
    private List<String> xAxisHeader;
    private List<String> yAxisHeader;
    private List rows;

    public ChartTabel() {
    }

    public ChartTabel(List<String> xAxisHeader, List rows) {
        this.xAxisHeader = xAxisHeader;
        this.rows = rows;
    }

    public ChartTabel(List<String> xAxisHeader, List<String> yAxisHeader, List rows) {
        this.xAxisHeader = xAxisHeader;
        this.yAxisHeader = yAxisHeader;
        this.rows = rows;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<String> getxAxisHeader() {
        return xAxisHeader;
    }

    public void setxAxisHeader(List<String> xAxisHeader) {
        this.xAxisHeader = xAxisHeader;
    }

    public List<String> getyAxisHeader() {
        return yAxisHeader;
    }

    public void setyAxisHeader(List<String> yAxisHeader) {
        this.yAxisHeader = yAxisHeader;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }
}
