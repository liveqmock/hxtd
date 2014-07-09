package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import java.util.ArrayList;
import java.util.List;

/**
 * OFC2Labels
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
public class OFC2Labels {

    private List labels = new ArrayList();

    public OFC2Labels() {
    }

    public OFC2Labels(List labels) {
        this.labels = labels;
    }

    public List getLabels() {
        return labels;
    }

    public void setLabels(List labels) {
        this.labels = labels;
    }
}
