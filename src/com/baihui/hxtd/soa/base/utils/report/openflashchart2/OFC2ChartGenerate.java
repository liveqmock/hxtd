package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.baihui.hxtd.soa.base.utils.report.ChartGenerate;
import com.baihui.hxtd.soa.base.utils.report.ReportChart;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ro.nextreports.jofc2.model.Chart;
import ro.nextreports.jofc2.model.axis.XAxis;
import ro.nextreports.jofc2.model.axis.YAxis;
import ro.nextreports.jofc2.model.elements.BarChart;
import ro.nextreports.jofc2.model.elements.Element;
import ro.nextreports.jofc2.model.elements.LineChart;
import ro.nextreports.jofc2.model.elements.PieChart;

import java.util.*;

/**
 * GraphReport
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public class OFC2ChartGenerate implements ChartGenerate {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public String generateChart(ReportChart reportChart) {
        Chart chart = new Chart(reportChart.getTitle());
        chart.setXAxis(new XAxis());
        chart.getXAxis().addLabels(reportChart.getxAxisLabels().toArray(new String[]{}));
        chart.setYAxis(new YAxis());
        chart.getYAxis().setRange(0, reportChart.getyAxisRange().getMax());
        Collection<Element> elements = new ArrayList<Element>();
        List<List<Number>> rows = reportChart.getData();
        List zAxisLabels = reportChart.getzAxisLabels();
        List<String> colours = getColours(zAxisLabels);
        switch (reportChart.getChartType()) {
            case bar:
                for (int i = 0; i < rows.size(); i++) {
                    BarChart barChart = new BarChart(BarChart.Style.THREED);
                    barChart.setText(String.valueOf(zAxisLabels.get(i)));
                    barChart.setColour(colours.get(i));
                    barChart.addValues(rows.get(i));
                    elements.add(barChart);
                }
                break;
            case pie:
                PieChart pieChart = new PieChart();
                List<String> labels = reportChart.getxAxisLabels();
                List<Number> values = rows.get(0);
                for (int i = 0; i < labels.size(); i++) {
                    pieChart.addSlice(values.get(i), String.format("%s(%s)", labels.get(i), values.get(i)));
                }
                pieChart.setStartAngle(100);
                pieChart.setAnimate(true);
                pieChart.setTooltip("#val#  /  #total#<br> 占百分之 #percent#");
                elements.add(pieChart);
                break;
            case line:
                for (int i = 0; i < rows.size(); i++) {
                    LineChart lineChart = new LineChart();
                    lineChart.setText(String.valueOf(zAxisLabels.get(i)));
                    lineChart.setColour(colours.get(i));
                    lineChart.addValues(rows.get(i));
                    elements.add(lineChart);
                }
                break;
        }
        chart.addElements(elements);

        String stringChart = chart.toString();
        logger.debug("chart={}", stringChart);

        return stringChart;
    }

    /** 获取标签对应的颜色 */
    public List<String> getColours(List labels) {
        Set<String> colours = new HashSet<String>();
        while (colours.size() < labels.size()) {
            colours.add("#" + generateRandomColourCode());
        }
        return new ArrayList<String>(colours);
    }

    /** 生成随机的颜色代码 */
    public static String generateRandomColourCode() {
        String r, g, b;
        Random random = new Random();
        r = Integer.toHexString(random.nextInt(256)).toUpperCase();
        g = Integer.toHexString(random.nextInt(256)).toUpperCase();
        b = Integer.toHexString(random.nextInt(256)).toUpperCase();

        r = r.length() == 1 ? "0" + r : r;
        g = g.length() == 1 ? "0" + g : g;
        b = b.length() == 1 ? "0" + b : b;

        return r + g + b;
    }

}
