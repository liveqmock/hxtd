package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.baihui.hxtd.soa.base.utils.report.ChartGraphGenerate;
import com.baihui.hxtd.soa.base.utils.report.ChartGraph;
import com.baihui.hxtd.soa.base.utils.report.ReportGraph;

import java.util.Arrays;
import java.util.List;

/**
 * GraphReport
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public class OFC2ChartGraphGenerate implements ChartGraphGenerate {

    public ChartGraph generateTwoDimensionChart(ReportGraph reportGraph) {
        OFC2ChartGraph chartGraph = new OFC2ChartGraph();
        chartGraph.getTitle().setText(reportGraph.getTitle());
        chartGraph.setxLegend(new OFC2Legend(reportGraph.getxAxisTitle(),"{font-size: 12px; color:#736AFF;}"));

        chartGraph.getxAxis().setLabels(reportGraph.getxAxisLabels());
        chartGraph.getyAxis().setMin(0l);
        chartGraph.getyAxis().setMax(reportGraph.getyAxisRange().getMax());

        List<OFC2Element> elements = chartGraph.getElements();
        OFC2Element element = new OFC2Element();
        element.setType(reportGraph.getGraphType().name());
        element.setValues(reportGraph.getData());
        elements.add(element);

        return chartGraph;
    }

    public ChartGraph generateThreeDimensionChart(ReportGraph reportGraph) {
        OFC2ChartGraph chartGraph = new OFC2ChartGraph();
        chartGraph.getTitle().setText(reportGraph.getTitle());
        chartGraph.setxLegend(new OFC2Legend(reportGraph.getxAxisTitle(),"{font-size: 12px; color:#736AFF;}"));
//        chartGraph.getyLegend().setText(reportGraph.getyAxisTitle());

        chartGraph.getxAxis().setLabels(reportGraph.getxAxisLabels());
        chartGraph.getyAxis().setMin(0l);
        chartGraph.getyAxis().setMax(reportGraph.getyAxisRange().getMax());

        List<OFC2Element> elements = chartGraph.getElements();
        List<String> colours = Arrays.asList("#d000d0", "#CC9933");
        for (int i = 0; i < reportGraph.getData().size(); i++) {
            List row = (List) reportGraph.getData().get(i);
            OFC2Element element = new OFC2Element();
            element.setType(reportGraph.getGraphType().name());
            element.setColour(colours.get(i));
            element.setText(String.valueOf(reportGraph.getzAxisLabels().get(i)));
            element.setValues(row);
            elements.add(element);
        }

        return chartGraph;
    }


}
