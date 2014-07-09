package com.baihui.hxtd.soa.base.utils.report;

/**
 * GraphReport
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public interface GraphReport {

    public final static String TYPE_PIE = "pie";
    public final static String TYPE_BAR = "bar";
    public final static String TYPE_LINE = "line";

    /**
     * 生成二维报表
     */
    public String generateTwoDimensionChart(String type, TwoDimensionReportData reportData);

    /**
     * 生成三维报表
     */
    public String generateThreeDimensionChart(String type, ThreeDimensionReportData reportData);


}
