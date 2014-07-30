package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.baihui.hxtd.soa.base.utils.report.ChartGenerate;
import com.baihui.hxtd.soa.base.utils.report.ReportChart;
import com.baihui.hxtd.soa.base.utils.report.YAxisRange;
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
        generateStep(reportChart.getyAxisRange());
        chart.getYAxis().setRange(reportChart.getyAxisRange().getMin(), reportChart.getyAxisRange().getMax(), reportChart.getyAxisRange().getStep());

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

    /**
     * 生成递增值
     * -y轴固定显示10个数值
     * -递增值
     * --不考虑小数情况
     * --递增值为n*10~次方
     *
     * @return
     */
    public static Number generateStep(YAxisRange<Number> range) {
        Number min = range.getMin();
        Number max = range.getMax();
        if (min instanceof Long && max instanceof Long) {
            long differ = (Long) max - (Long) min + 1;
            long step = differ / 10;
            long remainder = differ % 10;
            int time = 0;
            while (step > 10) {
                step = step / 10;
                remainder = step % 10;
                time++;
            }
            if (remainder > 0) {
                step++;
            }
            step *= (int) Math.pow(10, time);
            range.setStep(step);
            range.setMax((Long) min + step * 10);
            return step;
        } else if (min instanceof Integer && max instanceof Integer) {
            int differ = (Integer) max - (Integer) min + 1;
            int step = differ / 10;
            int remainder = differ % 10;
            int time = 0;
            while (step > 10) {
                step = step / 10;
                remainder = step % 10;
                time++;
            }
            if (remainder > 0) {
                step++;
            }
            step *= (int) Math.pow(10, time);
            range.setStep(step);
            range.setMax((Integer) min + step * 10);
            return step;
        }
        throw new RuntimeException(String.format("未预期的值%s和%s", min, max));
    }


    /** 颜色，初始化13种，需要时自动扩涨 */
    private final static Set<String> COLOURS = new LinkedHashSet<String>(Arrays.asList("#FF0000", "#00FF00", "#0000FF",/* "#FFFF00",*/ "#00FFFF", "#FF00FF", "#02d1b1",
            "#00c6ff", "#b9e415", "#f28f02", "#ec31e1", "#e45915", "#f798db", "#8b97ef"));


    /** 获取标签对应的颜色 */
    public static List<String> getColours(List labels) {
        while (COLOURS.size() <= labels.size()) {
            COLOURS.add("#" + generateRandomColourCode());
        }
        return new ArrayList<String>(COLOURS);
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
