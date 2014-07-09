package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;

/**
 * OFC2Element
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2Element {

    private String type;
    private Float alpha;
    private String colour;
    private String text;
    @JsonProperty("font-size")
    private String fontSize;
    private List values = new ArrayList();

    public OFC2Element() {

    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Float getAlpha() {
        return alpha;
    }

    public void setAlpha(Float alpha) {
        this.alpha = alpha;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getFontSize() {
        return fontSize;
    }

    public void setFontSize(String fontSize) {
        this.fontSize = fontSize;
    }

    public List getValues() {
        return values;
    }

    public void setValues(List values) {
        this.values = values;
    }
}
