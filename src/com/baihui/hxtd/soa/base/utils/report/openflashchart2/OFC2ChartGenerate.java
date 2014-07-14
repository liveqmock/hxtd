package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.baihui.hxtd.soa.base.utils.report.ChartGenerate;
import com.baihui.hxtd.soa.base.utils.report.ReportChart;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ro.nextreports.jofc2.model.Chart;
import ro.nextreports.jofc2.model.Text;
import ro.nextreports.jofc2.model.axis.XAxis;
import ro.nextreports.jofc2.model.axis.YAxis;
import ro.nextreports.jofc2.model.elements.BarChart;
import ro.nextreports.jofc2.model.elements.Element;
import ro.nextreports.jofc2.model.elements.LineChart;
import ro.nextreports.jofc2.model.elements.PieChart;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * GraphReport
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public class OFC2ChartGenerate implements ChartGenerate {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public Chart generateTwoDimensionChart(ReportChart reportChart) {
        Chart chart = new Chart(reportChart.getTitle());
        chart.setXLegend(new Text(reportChart.getxAxisTitle()));
//        chart.setYLegend(new Text(reportChart.getyAxisTitle()));
        chart.setXAxis(new XAxis());
        chart.getXAxis().addLabels(reportChart.getxAxisLabels().toArray(new String[]{}));
        chart.setYAxis(new YAxis());
        chart.getYAxis().setRange(0, reportChart.getyAxisRange().getMax());
        Collection<Element> elements = new ArrayList<Element>();
        switch (reportChart.getGraphType()) {
            case bar:
                BarChart barChart = new BarChart();
                barChart.addValues(reportChart.getData().get(0));
                elements.add(barChart);
                break;
            case pie:
                PieChart pieChart = new PieChart();
                pieChart.addValues(reportChart.getData().get(0));
                elements.add(pieChart);
                break;
            case line:
                LineChart lineChart = new LineChart();
                lineChart.addValues(reportChart.getData().get(0));
                elements.add(lineChart);
                break;
        }
        chart.addElements(elements);

//        logger.debug("chart={}", chart);
        System.out.println(String.format("chart=%s", chart.toString()));

        return chart;
    }

    public Chart generateThreeDimensionChart(ReportChart reportChart) {
        Chart chart = new Chart(reportChart.getTitle());
//        chart.setXLegend(new Text(reportChart.getxAxisTitle()));
//        chart.setYLegend(new Text(reportChart.getyAxisTitle()));
        chart.setXAxis(new XAxis());
        chart.getXAxis().addLabels(reportChart.getxAxisLabels().toArray(new String[]{}));
        chart.setYAxis(new YAxis());
        chart.getYAxis().setRange(0, reportChart.getyAxisRange().getMax());
        Collection<Element> elements = new ArrayList<Element>();
        List<List<Number>> rows = reportChart.getData();
        switch (reportChart.getGraphType()) {
            case bar:
                BarChart barChart = new BarChart();
                for (int i = 0; i < rows.size(); i++) {
                    barChart.addValues(rows.get(i));
                    elements.add(barChart);
                }
                break;
            case pie:
                PieChart pieChart = new PieChart();
                pieChart.addValues(rows.get(0));
                elements.add(pieChart);
                break;
            case line:
                LineChart lineChart = new LineChart();
                lineChart.addValues(rows.get(0));
                elements.add(lineChart);
                break;
        }
        chart.addElements(elements);

        return chart;
    }


}
