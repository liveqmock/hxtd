package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * 报表原始数据
 *
 * @author xiayouxue
 * @date 2014/7/11
 */
public class ReportOrginal {

    /**
     * X轴描述
     */
    private List xAxisDescs;
    /**
     * X轴值
     */
    private List xAxisValues;
    /**
     * Y轴数值区间
     */
    private YAxisRange<Long> yAxisRange;
    /**
     * Z轴描述
     */
    private List zAxisDescs;
    /**
     * Z轴值
     */
    private List zAxisValues;
    /**
     * 数据行
     */
    private List rows;

    public ReportOrginal() {
        yAxisRange = new YAxisRange<Long>();
    }

    public List getxAxisValues() {
        return xAxisValues;
    }

    public void setxAxisValues(List xAxisValues) {
        this.xAxisValues = xAxisValues;
    }

    public List getxAxisDescs() {
        return xAxisDescs;
    }

    public void setxAxisDescs(List xAxisDescs) {
        this.xAxisDescs = xAxisDescs;
    }

    public YAxisRange<Long> getyAxisRange() {
        return yAxisRange;
    }

    public void setyAxisRange(YAxisRange<Long> yAxisRange) {
        this.yAxisRange = yAxisRange;
    }

    public List getzAxisValues() {
        return zAxisValues;
    }

    public void setzAxisValues(List zAxisValues) {
        this.zAxisValues = zAxisValues;
    }

    public List getzAxisDescs() {
        return zAxisDescs;
    }

    public void setzAxisDescs(List zAxisDescs) {
        this.zAxisDescs = zAxisDescs;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }
}
