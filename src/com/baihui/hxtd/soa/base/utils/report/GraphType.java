package com.baihui.hxtd.soa.base.utils.report;

import com.baihui.hxtd.soa.system.DictionaryConstant;

/**
 * 图表类型
 */
public enum GraphType {

    pie(DictionaryConstant.REPORT_CHART_PIE),
    bar(DictionaryConstant.REPORT_CHART_BAR),
    line(DictionaryConstant.REPORT_CHART_LINE);

    private String dictionary;

    GraphType(String dictionary) {
        this.dictionary = dictionary;
    }

    /**
     * 获取图表类型
     */
    public static GraphType findByValue(String value) {
        GraphType[] values = GraphType.values();
        for (int i = 0; i < values.length; i++) {
            GraphType graphType = values[i];
            if (graphType.getDictionary().equals(value)) {
                return graphType;
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