package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

/**
 * OFC2Legend
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2Legend {

    private String title;
    private String style;

    public OFC2Legend() {
    }

    public OFC2Legend(String style) {
        this.style = style;
    }

    public OFC2Legend(String title, String style) {
        this.title = title;
        this.style = style;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }
}
