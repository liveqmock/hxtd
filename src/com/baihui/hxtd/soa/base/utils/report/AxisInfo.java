package com.baihui.hxtd.soa.base.utils.report;

/**
 * 轴信息
 * 包括描述和值
 *
 * @author xiayouxue
 * @date 2014/7/14
 */
public class AxisInfo {

    private String desc;
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
