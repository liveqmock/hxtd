package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.baihui.hxtd.soa.base.utils.report.ChartGraph;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;

/**
 * Open Flash Chart2 Data
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2ChartGraph extends ChartGraph {

    private OFC2Legend title = new OFC2Legend();   //图表标题

    @JsonProperty("x_legend")
    private OFC2Legend xLegend; //X轴标题

    @JsonProperty("y_legend")
    private OFC2Legend yLegend; //Y轴标题

    @JsonProperty("is_decimal_separator_comma")
    private Boolean isDecimalSeparatorComma;    //(0/1)，是否用逗号替换小数点

    @JsonProperty("is_fixed_num_decimals_forced")
    private Boolean isFixedNumDecimalsForced;    //(0/1)，是否用逗号替换小数点

    @JsonProperty("num_decimals")
    private Integer numDecimals;    //精度，即小数点后面的位数，需要配合上面参数一起使用

    @JsonProperty("is_thousand_separator_disabled")
    private Boolean isThousandSeparatorDisabled;    //(0/1)，是否使用千位分隔符

    @JsonProperty("x_axis")
    private OFC2Axis xAxis = new OFC2Axis();

    @JsonProperty("y_axis")
    private OFC2Axis yAxis = new OFC2Axis();

    private List<OFC2Element> elements = new ArrayList<OFC2Element>();

    private OFC2Tooltip tooltip = new OFC2Tooltip();


    public OFC2ChartGraph() {
        this.title.setStyle("{font-size: 20px; color:#0000ff; font-family: Verdana; text-align: center;}");
//        this.xLegend.setStyle("{font-size: 12px; color:#736AFF;}");
//        this.yLegend.setStyle("{color: #736AFF; font-size: 12px;}");

//        this.xAxis.setStroke(1);
//        this.xAxis.setTickHeight(10);
//        this.xAxis.setColour("#d000d0");
//        this.xAxis.setGridColour("#00ff00");
//        this.xAxis.setOffset(true);
//        this.xAxis.setThreeDimensional(false);

//        this.yAxis.setStroke(4);
//        this.yAxis.setTickLength(3);
//        this.yAxis.setColour("#d000d0");
//        this.yAxis.setGridColour("#00ff00");
//        this.yAxis.setOffset(false);

        this.tooltip.setShadow(false);
        this.tooltip.setStroke(2);
        this.tooltip.setRounded(1);
        this.tooltip.setColour("#00d000");
        this.tooltip.setTitle("{font-size: 18px; color: #000000; font-weight:bold;}");
        this.tooltip.setBody("{font-size: 10px; color: #000000;}");
    }

    public OFC2Legend getTitle() {
        return title;
    }

    public void setTitle(OFC2Legend title) {
        this.title = title;
    }

    public OFC2Legend getxLegend() {
        return xLegend;
    }

    public void setxLegend(OFC2Legend xLegend) {
        this.xLegend = xLegend;
    }

    public OFC2Legend getyLegend() {
        return yLegend;
    }

    public void setyLegend(OFC2Legend yLegend) {
        this.yLegend = yLegend;
    }

    public Boolean getIsDecimalSeparatorComma() {
        return isDecimalSeparatorComma;
    }

    public void setIsDecimalSeparatorComma(Boolean isDecimalSeparatorComma) {
        this.isDecimalSeparatorComma = isDecimalSeparatorComma;
    }

    public Boolean getIsFixedNumDecimalsForced() {
        return isFixedNumDecimalsForced;
    }

    public void setIsFixedNumDecimalsForced(Boolean isFixedNumDecimalsForced) {
        this.isFixedNumDecimalsForced = isFixedNumDecimalsForced;
    }

    public Integer getNumDecimals() {
        return numDecimals;
    }

    public void setNumDecimals(Integer numDecimals) {
        this.numDecimals = numDecimals;
    }

    public Boolean getIsThousandSeparatorDisabled() {
        return isThousandSeparatorDisabled;
    }

    public void setIsThousandSeparatorDisabled(Boolean isThousandSeparatorDisabled) {
        this.isThousandSeparatorDisabled = isThousandSeparatorDisabled;
    }

    public OFC2Axis getxAxis() {
        return xAxis;
    }

    public void setxAxis(OFC2Axis xAxis) {
        this.xAxis = xAxis;
    }

    public OFC2Axis getyAxis() {
        return yAxis;
    }

    public void setyAxis(OFC2Axis yAxis) {
        this.yAxis = yAxis;
    }

    public List<OFC2Element> getElements() {
        return elements;
    }

    public void setElements(List<OFC2Element> elements) {
        this.elements = elements;
    }

    public OFC2Tooltip getTooltip() {
        return tooltip;
    }

    public void setTooltip(OFC2Tooltip tooltip) {
        this.tooltip = tooltip;
    }
}
