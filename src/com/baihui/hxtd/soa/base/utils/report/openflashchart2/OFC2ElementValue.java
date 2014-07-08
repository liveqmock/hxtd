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


}
