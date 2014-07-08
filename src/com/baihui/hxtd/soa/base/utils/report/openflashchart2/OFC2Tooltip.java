package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

/**
 * OFC2Tooltip
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2Tooltip {

    private Boolean shadow;   //提示框影子
    private Integer stroke;   //边框粗细
    private Integer rounded;  //边角圆滑程度
    private String colour;    //边框颜色
    private String backgournd;//背景颜色
    private String title;     //标题样式
    private String body;      //本体样式

    public Boolean getShadow() {
        return shadow;
    }

    public void setShadow(Boolean shadow) {
        this.shadow = shadow;
    }

    public Integer getStroke() {
        return stroke;
    }

    public void setStroke(Integer stroke) {
        this.stroke = stroke;
    }

    public Integer getRounded() {
        return rounded;
    }

    public void setRounded(Integer rounded) {
        this.rounded = rounded;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public String getBackgournd() {
        return backgournd;
    }

    public void setBackgournd(String backgournd) {
        this.backgournd = backgournd;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
