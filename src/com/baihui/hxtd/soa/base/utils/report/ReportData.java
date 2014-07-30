package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * 报表原始数据
 *
 * @author xiayouxue
 * @date 2014/7/11
 */
public class ReportData {

    /** x轴 */
    private List<AxisInfo> xAxis;

    /** y轴数值区间 */
    private YAxisRange<Number> yAxisRange;

    /** 数值类型 */
    private Class<? extends Number> numberType;

    /** z轴值 */
    private List<AxisInfo> zAxis;

    /** 数据行 */
    private List<Object[]> rows;

    public ReportData() {
        yAxisRange = new YAxisRange<Number>();
    }

    public List<AxisInfo> getxAxis() {
        return xAxis;
    }

    public void setxAxis(List<AxisInfo> xAxis) {
        this.xAxis = xAxis;
    }

    public YAxisRange<Number> getyAxisRange() {
        return yAxisRange;
    }

    public void setyAxisRange(YAxisRange<Number> yAxisRange) {
        this.yAxisRange = yAxisRange;
    }

    public List<AxisInfo> getzAxis() {
        return zAxis;
    }

    public void setzAxis(List<AxisInfo> zAxis) {
        this.zAxis = zAxis;
    }

    public List<Object[]> getRows() {
        return rows;
    }

    public void setRows(List<Object[]> rows) {
        this.rows = rows;
    }

    public Class<? extends Number> getNumberType() {
        return numberType;
    }

    public void setNumberType(Class<? extends Number> numberType) {
        this.numberType = numberType;
    }
}
