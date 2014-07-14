package com.baihui.hxtd.soa.base.utils.report;

import java.util.ArrayList;
import java.util.List;

/**
 * 报表图表转换数据
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public class ReportChart {

    /** 标题 */
    protected String title;

    /** 图表类型 */
    protected GraphType graphType;

    /** x轴标题 */
    protected String xAxisTitle;

    /** x轴数值描述 */
    protected List<String> xAxisLabels;

    /** y轴标题 */
    protected String yAxisTitle;

    /** y轴数值描述 */
    protected YAxisRange<Number> yAxisRange;

    /** z轴标题 */
    protected String zAxisTitle;

    /** z轴标题 */
    protected List<String> zAxisLabels;

    /** 数据 */
    protected List<List<Number>> data;

    public ReportChart() {
        data = new ArrayList<List<Number>>();
        yAxisRange = new YAxisRange<Number>();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public GraphType getGraphType() {
        return graphType;
    }

    public void setGraphType(GraphType graphType) {
        this.graphType = graphType;
    }

    public String getxAxisTitle() {
        return xAxisTitle;
    }

    public void setxAxisTitle(String xAxisTitle) {
        this.xAxisTitle = xAxisTitle;
    }

    public List<String> getxAxisLabels() {
        return xAxisLabels;
    }

    public void setxAxisLabels(List<String> xAxisLabels) {
        this.xAxisLabels = xAxisLabels;
    }

    public String getyAxisTitle() {
        return yAxisTitle;
    }

    public void setyAxisTitle(String yAxisTitle) {
        this.yAxisTitle = yAxisTitle;
    }

    public YAxisRange<Number> getyAxisRange() {
        return yAxisRange;
    }

    public void setyAxisRange(YAxisRange<Number> yAxisRange) {
        this.yAxisRange = yAxisRange;
    }

    public String getzAxisTitle() {
        return zAxisTitle;
    }

    public void setzAxisTitle(String zAxisTitle) {
        this.zAxisTitle = zAxisTitle;
    }

    public List getzAxisLabels() {
        return zAxisLabels;
    }

    public void setzAxisLabels(List<String> zAxisLabels) {
        this.zAxisLabels = zAxisLabels;
    }

    public List<List<Number>> getData() {
        return data;
    }

    public void setData(List<List<Number>> data) {
        this.data = data;
    }
}
