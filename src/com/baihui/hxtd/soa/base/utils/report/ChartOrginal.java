package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * @author xiayouxue
 * @date 2014/7/11
 */
public class ChartOrginal {

    private List xAxisValues;
    private List xAxisDescs;
    private List zAxisValues;
    private List zAxisDescs;
    private List table;

    public ChartOrginal() {
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

    public List getTable() {
        return table;
    }

    public void setTable(List table) {
        this.table = table;
    }
}
