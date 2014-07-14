package com.baihui.hxtd.soa.base.utils.report;

import java.util.ArrayList;
import java.util.List;

/**
 * ReportData
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public class ReportGraph {

    protected String title;       //标题
    protected GraphType graphType;        //图表类型
    protected String xAxisTitle;  //x轴标题
    protected List xAxisLabels;   //x轴数值描述
    protected String yAxisTitle;   //y轴标题
    protected YAxisRange<Long> yAxisRange; //y轴数值描述
    protected String zAxisTitle;   //z轴标题
    protected List zAxisLabels; //z轴标题
    protected List data;            //数据

    public ReportGraph() {
        data = new ArrayList();
        yAxisRange = new YAxisRange<Long>();
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

    public String getyAxisTitle() {
        return yAxisTitle;
    }

    public void setyAxisTitle(String yAxisTitle) {
        this.yAxisTitle = yAxisTitle;
    }

    public List getxAxisLabels() {
        return xAxisLabels;
    }

    public void setxAxisLabels(List xAxisLabels) {
        this.xAxisLabels = xAxisLabels;
    }

    public YAxisRange<Long> getyAxisRange() {
        return yAxisRange;
    }

    public void setyAxisRange(YAxisRange<Long> yAxisRange) {
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

    public void setzAxisLabels(List zAxisLabels) {
        this.zAxisLabels = zAxisLabels;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }
}
