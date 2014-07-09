package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

/**
 * OFC2Legend
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2Legend {

    private String text;
    private String style;

    public OFC2Legend() {
    }

    public OFC2Legend(String style) {
        this.style = style;
    }

    public OFC2Legend(String text, String style) {
        this.text = text;
        this.style = style;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }
}
