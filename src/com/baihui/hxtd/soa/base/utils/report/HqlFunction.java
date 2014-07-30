package com.baihui.hxtd.soa.base.utils.report;

import com.baihui.hxtd.soa.system.DictionaryConstant;

import java.util.HashMap;
import java.util.Map;

/**
 * Hql 函数
 *
 * @author xiayouxue
 * @date 2014/7/14
 */
public class HqlFunction {

    /*聚合函数*/
    /** 总计 */
    public final static HqlFunction AGGREGATE_COUNT = new HqlFunction("COUNT", "总计", Long.class);
    /** 总数 */
    public final static HqlFunction AGGREGATE_SUM = new HqlFunction("SUM", "总数", Long.class);
    /** 平均 */
    public final static HqlFunction AGGREGATE_AVG = new HqlFunction("AVG", "平均", Double.class);
    /** 最大 */
    public final static HqlFunction AGGREGATE_MAX = new HqlFunction("MAX", "最大", Long.class);
    /** 最小 */
    public final static HqlFunction AGGREGATE_MIN = new HqlFunction("MIN", "最小", Long.class);

    /** 聚合函数映射 */
    public final static Map<String, HqlFunction> AGGREGATES = new HashMap<String, HqlFunction>();

    static {
        AGGREGATES.put(DictionaryConstant.REPORT_AGGREGATE_COUNT, AGGREGATE_COUNT);
        AGGREGATES.put(DictionaryConstant.REPORT_AGGREGATE_SUM, AGGREGATE_SUM);
        AGGREGATES.put(DictionaryConstant.REPORT_AGGREGATE_AVG, AGGREGATE_AVG);
        AGGREGATES.put(DictionaryConstant.REPORT_AGGREGATE_MAX, AGGREGATE_MAX);
        AGGREGATES.put(DictionaryConstant.REPORT_AGGREGATE_MIN, AGGREGATE_MIN);
    }

    /*时间函数*/
    /** 年 */
    public final static HqlFunction TIME_YEAR = new HqlFunction("YEAR", "年", Long.class);
    /** 月 */
    public final static HqlFunction TIME_MONTH = new HqlFunction("MONTH", "月", Long.class);
    /** 日 */
    public final static HqlFunction TIME_DAY = new HqlFunction("DAY", "日", Long.class);
    /** 时 */
    public final static HqlFunction TIME_HOUR = new HqlFunction("HOUR", "时", Long.class);
    /** 分 */
    public final static HqlFunction TIME_MINUTE = new HqlFunction("MINUTE", "分", Long.class);
    /** 秒 */
    public final static HqlFunction TIME_SECOND = new HqlFunction("SECOND", "秒", Long.class);

    /** 时间分组函数映射 */
    public final static Map<String, HqlFunction> TIME_GROUPS = new HashMap<String, HqlFunction>();

    static {
        TIME_GROUPS.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, TIME_YEAR);
        TIME_GROUPS.put(DictionaryConstant.REPORT_GROUP_TIME_MONTH, TIME_MONTH);
        TIME_GROUPS.put(DictionaryConstant.REPORT_GROUP_TIME_DATE, TIME_DAY);
        TIME_GROUPS.put(DictionaryConstant.REPORT_GROUP_TIME_HOUR, TIME_HOUR);
        TIME_GROUPS.put(DictionaryConstant.REPORT_GROUP_TIME_MINUTE, TIME_MINUTE);
        TIME_GROUPS.put(DictionaryConstant.REPORT_GROUP_TIME_SECOND, TIME_SECOND);
    }


    /** 名称 */
    private String name;

    /** 描述 */
    private String desc;

    /** 返回值类型 */
    private Class<? extends Number> returnType;

    public HqlFunction() {
    }

    public HqlFunction(String name, String desc, Class returnType) {
        this.name = name;
        this.desc = desc;
        this.returnType = returnType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Class<? extends Number> getReturnType() {
        return returnType;
    }

    public void setReturnType(Class<? extends Number> returnType) {
        this.returnType = returnType;
    }
}
