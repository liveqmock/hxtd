package com.baihui.hxtd.soa.base.utils.report;

/**
 * Hql 函数
 *
 * @author xiayouxue
 * @date 2014/7/14
 */
public class HqlFunction {

    /*聚合函数*/
    /** 总计 */
    public final static HqlFunction AGGREGATE_COUNT = new HqlFunction("COUNT", Long.class);
    /** 总数 */
    public final static HqlFunction AGGREGATE_SUM = new HqlFunction("SUM", Long.class);
    /** 平均 */
    public final static HqlFunction AGGREGATE_AVG = new HqlFunction("AVG", Long.class);
    /** 最大 */
    public final static HqlFunction AGGREGATE_MAX = new HqlFunction("MAX", Long.class);
    /** 最小 */
    public final static HqlFunction AGGREGATE_MIN = new HqlFunction("MIN", Long.class);

    /*时间函数*/
    /** 年 */
    public final static HqlFunction TIME_YEAR = new HqlFunction("YEAR", Long.class);
    /** 月 */
    public final static HqlFunction TIME_MONTH = new HqlFunction("MONTH", Long.class);
    /** 日 */
    public final static HqlFunction TIME_DAY = new HqlFunction("DAY", Long.class);
    /** 时 */
    public final static HqlFunction TIME_HOUR = new HqlFunction("HOUR", Long.class);
    /** 分 */
    public final static HqlFunction TIME_MINUTE = new HqlFunction("MINUTE", Long.class);
    /** 秒 */
    public final static HqlFunction TIME_SECOND = new HqlFunction("SECOND", Long.class);


    /** 名称 */
    private String name;

    /** 返回值类型 */
    private Class returnType;

    public HqlFunction() {
    }

    public HqlFunction(String name, Class returnType) {
        this.name = name;
        this.returnType = returnType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Class getReturnType() {
        return returnType;
    }

    public void setReturnType(Class returnType) {
        this.returnType = returnType;
    }
}
