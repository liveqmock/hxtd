package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * OFC2Axis
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2Axis {

    private Integer stroke;        //粗细
    @JsonProperty("tick_height")
    private Integer tickHeight;    //X轴的高度
    @JsonProperty("tick_length")
    private Integer tickLength;    //Y轴的长度
    private String colour;         //颜色
    @JsonProperty("grid_colour")
    private String gridColour;     //网格线的颜色
    private Boolean offset;        //是否根据数据图形和标签的宽度进行延展
    @JsonProperty("3d")
    private Boolean threeDimensional;
    private Float steps;
    private Integer min;
    private Integer max;
    private OFC2Labels labels;

    public OFC2Axis() {
    }

    public Integer getStroke() {
        return stroke;
    }

    public void setStroke(Integer stroke) {
        this.stroke = stroke;
    }

    public Integer getTickHeight() {
        return tickHeight;
    }

    public void setTickHeight(Integer tickHeight) {
        this.tickHeight = tickHeight;
    }

    public Integer getTickLength() {
        return tickLength;
    }

    public void setTickLength(Integer tickLength) {
        this.tickLength = tickLength;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public String getGridColour() {
        return gridColour;
    }

    public void setGridColour(String gridColour) {
        this.gridColour = gridColour;
    }

    public Boolean getOffset() {
        return offset;
    }

    public void setOffset(Boolean offset) {
        this.offset = offset;
    }

    public Boolean getThreeDimensional() {
        return threeDimensional;
    }

    public void setThreeDimensional(Boolean threeDimensional) {
        this.threeDimensional = threeDimensional;
    }

    public Float getSteps() {
        return steps;
    }

    public void setSteps(Float steps) {
        this.steps = steps;
    }

    public Integer getMin() {
        return min;
    }

    public void setMin(Integer min) {
        this.min = min;
    }

    public Integer getMax() {
        return max;
    }

    public void setMax(Integer max) {
        this.max = max;
    }

    public OFC2Labels getLabels() {
        return labels;
    }

    public void setLabels(OFC2Labels labels) {
        this.labels = labels;
    }
}
