package com.baihui.hxtd.soa.base.utils.report;

/**
 * 轴信息
 *
 * @author xiayouxue
 * @date 2014/7/14
 */
public class AxisInfo {

    /** 描述 */
    private String desc;

    /** 值 */
    private Object value;

    public AxisInfo() {
    }

    public AxisInfo(String desc, Object value) {
        this.desc = desc;
        this.value = value;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }
}
