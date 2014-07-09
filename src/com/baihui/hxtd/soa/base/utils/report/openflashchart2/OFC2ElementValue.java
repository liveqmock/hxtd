package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * OFC2ElementValues
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2ElementValue {

    private Integer bottom;
    private Integer top;
    private String colour;
    private String tip;
    @JsonProperty("on-click")
    private String onClick;

    public OFC2ElementValue() {
    }

    public OFC2ElementValue(Integer top) {
        this.top = top;
    }

    public Integer getBottom() {
        return bottom;
    }

    public void setBottom(Integer bottom) {
        this.bottom = bottom;
    }

    public Integer getTop() {
        return top;
    }

    public void setTop(Integer top) {
        this.top = top;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public String getTip() {
        return tip;
    }

    public void setTip(String tip) {
        this.tip = tip;
    }

    public String getOnClick() {
        return onClick;
    }

    public void setOnClick(String onClick) {
        this.onClick = onClick;
    }
}
