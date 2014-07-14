package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * 报表表格
 * @author xiayx
 * @date 14-7-11
 */
public class ChartTable {

    /**标题*/
    private String title;
    /**X轴表头*/
    private List xAxisHeader;
    /**Z轴表头*/
    private List yAxisHeader;
    /**数据行*/
    private List rows;

    public ChartTable() {
    }

    public ChartTable(List xAxisHeader, List rows) {
        this.xAxisHeader = xAxisHeader;
        this.rows = rows;
    }

    public ChartTable(List xAxisHeader, List yAxisHeader, List rows) {
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

    public List getxAxisHeader() {
        return xAxisHeader;
    }

    public void setxAxisHeader(List xAxisHeader) {
        this.xAxisHeader = xAxisHeader;
    }

    public List getyAxisHeader() {
        return yAxisHeader;
    }

    public void setyAxisHeader(List yAxisHeader) {
        this.yAxisHeader = yAxisHeader;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }
}
