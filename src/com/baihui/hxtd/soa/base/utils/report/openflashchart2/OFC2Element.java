package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

/**
 * OFC2Element
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2Element {

    private String type;   //可选值有bar，line，pie等
    private Float alpha;
    private String colour;
    private String text;
    @JsonProperty("font-size")
    private String fontSize;
    private List<OFC2ElementValue> values;


}
