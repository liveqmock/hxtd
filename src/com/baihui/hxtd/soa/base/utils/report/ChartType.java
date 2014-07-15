package com.baihui.hxtd.soa.base.utils.report;

import com.baihui.hxtd.soa.system.DictionaryConstant;

/**
 * 图表类型
 */
public enum ChartType {

    pie(DictionaryConstant.REPORT_CHART_PIE),
    bar(DictionaryConstant.REPORT_CHART_BAR),
    line(DictionaryConstant.REPORT_CHART_LINE);

    private String dictionary;

    ChartType(String dictionary) {
        this.dictionary = dictionary;
    }

    /**
     * 获取图表类型
     */
    public static ChartType findByValue(String value) {
        ChartType[] values = ChartType.values();
        for (int i = 0; i < values.length; i++) {
            ChartType chartType = values[i];
            if (chartType.getDictionary().equals(value)) {
                return chartType;
            }
        }
        return null;
    }

    public String getDictionary() {
        return dictionary;
    }

    public void setDictionary(String dictionary) {
        this.dictionary = dictionary;
    }
}