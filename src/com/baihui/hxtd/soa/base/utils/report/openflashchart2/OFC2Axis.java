package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

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
    private Long min;
    private Long max;
    private List labels;

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

    public Long getMin() {
        return min;
    }

    public void setMin(Long min) {
        this.min = min;
    }

    public Long getMax() {
        return max;
    }

    public void setMax(Long max) {
        this.max = max;
    }

    public List getLabels() {
        return labels;
    }

    public void setLabels(List labels) {
        this.labels = labels;
    }
}
