package com.baihui.hxtd.soa.base.utils.report;

import java.util.List;

/**
 * TwoDimensionReportData
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public class TwoDimensionReportData extends ReportData {

    public TwoDimensionReportData() {
        super();
    }

    /**
     * 创建空表格
     * 1.数据全部填充0
     */
    public void fullEmptyData() {
        for (int i = 0; i < xAxises.size(); i++) {
            data.add(0);
        }
    }

    /**
     * 填充数据
     * 1.生成数据索引
     * 2.填充数据
     */
    public void fullValidData(List data) {
        for (int i = 0; i < data.size(); i++) {
            Object[] row = (Object[]) data.get(i);
            this.data.set(xAxisIndexs.get(row[0]), row[1]);
        }
    }

    /**
     * 设置Y轴数值
     */
    public void setYAxises(List data) {
        for (int i = 0; i < data.size(); i++) {
            Object[] row = (Object[]) data.get(i);
            yAxises.add(row[1]);
        }
    }


}
