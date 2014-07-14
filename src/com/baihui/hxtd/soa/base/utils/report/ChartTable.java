package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * 报表表格
 *
 * @author xiayouxue
 * @date 14-7-11
 */
public class ChartTable {

    /** 标题 */
    private String title;

    /** x轴标题 */
    private String xAxisTitle;

    /** x轴表头 */
    private List<String> xAxisHeader;

    /** y轴标题 */
    private String yAxisTitle;

    /** y轴表头 */
    private List<String> yAxisHeader;

    /** 数据行 */
    private List<List<Number>> rows;

    public ChartTable() {
    }

    public ChartTable(List<String> xAxisHeader, List<List<Number>> rows) {
        this.xAxisHeader = xAxisHeader;
        this.rows = rows;
    }

    public ChartTable(List<String> xAxisHeader, List<String> yAxisHeader, List<List<Number>> rows) {
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

    public String getxAxisTitle() {
        return xAxisTitle;
    }

    public void setxAxisTitle(String xAxisTitle) {
        this.xAxisTitle = xAxisTitle;
    }

    public String getyAxisTitle() {
        return yAxisTitle;
    }

    public void setyAxisTitle(String yAxisTitle) {
        this.yAxisTitle = yAxisTitle;
    }

    public List<List<Number>> getRows() {
        return rows;
    }

    public void setRows(List<List<Number>> rows) {
        this.rows = rows;
    }
}
