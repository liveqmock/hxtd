package com.baihui.hxtd.soa.base.utils.report.openflashchart2;

import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.report.GraphReport;
import com.baihui.hxtd.soa.base.utils.report.ThreeDimensionReportData;
import com.baihui.hxtd.soa.base.utils.report.TwoDimensionReportData;

import java.util.List;

/**
 * GraphReport
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public class OFC2GraphReport implements GraphReport {

    public String generateTwoDimensionChart(String type, TwoDimensionReportData reportData) {
        OFC2Chart ofc2Data = new OFC2Chart();
        ofc2Data.getTitle().setText(reportData.getTitle());
        ofc2Data.getxLegend().setText(reportData.getxAxisTitle());
        ofc2Data.getyLegend().setText(reportData.getyAxisTitle());
        ofc2Data.getxAxis().getLabels().setLabels(reportData.getxAxisTitles());

        ofc2Data.getyAxis().setMin(1);
        ofc2Data.getyAxis().setMax(100);
        ofc2Data.getyAxis().setSteps(10f);

        List<OFC2Element> elements = ofc2Data.getElements();
        OFC2Element element = new OFC2Element();
        element.setType(type);
        element.setValues(reportData.getData());
        elements.add(element);

        return JsonMapper.nonEmptyMapper().toJson(ofc2Data);
    }

    public String generateThreeDimensionChart(String type, ThreeDimensionReportData reportData) {
        OFC2Chart ofc2Data = new OFC2Chart();
        ofc2Data.getTitle().setText(reportData.getTitle());
        ofc2Data.getxLegend().setText(reportData.getxAxisTitle());
        ofc2Data.getyLegend().setText(reportData.getyAxisTitle());
        List labels = ofc2Data.getxAxis().getLabels().getLabels();
        for (int i = 0; i < labels.size(); i++) {
        }

        ofc2Data.getyAxis().setMin(1);
        ofc2Data.getyAxis().setMax(100);
        ofc2Data.getyAxis().setSteps(10f);

        List<OFC2Element> elements = ofc2Data.getElements();
        for (int i = 0; i < reportData.getData().size(); i++) {
            List values = elements.get(i).getValues();
            Object row = reportData.getData().get(i);
            for (int j = 0; j < values.size(); j++) {

            }
        }

        return null;
    }


}
