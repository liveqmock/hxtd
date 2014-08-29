package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.utils.report.ChartModel;
import com.baihui.hxtd.soa.base.utils.report.ChartTable;
import com.baihui.hxtd.soa.order.dao.OrderDao;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.Range;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ro.nextreports.jofc2.model.Chart;
import ro.nextreports.jofc2.model.elements.PieChart;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 预警管理服务类
 *
 * @author xiayouxue
 * @date 2014/8/7
 */
@Service
public class WarningService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private OrderDao orderDao;

    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * 计算一段时间内的订单支付金额
     * 1.完成时间 in (min,max)
     * 2.财务状态 = 已付款
     * 3.支付金额=购买金额*（1+收益率）
     */
    @Transactional(readOnly = true)
    public List findOrderPayment(Range<Date> range) {
        String hql = "select entity.code,entity.purchaseMoney*(1+entity.earningRate),entity.orderEndTime" +
                " from Order entity" +
                " where entity.orderEndTime between ? and ?" +
                " and entity.payStatus.value=?" +
                " order by entity.orderEndTime";
        return orderDao.find(hql, range.getMinimum(), range.getMaximum(), DictionaryConstant.ORDER_PAY_2_HXTD_STATUS_ALL);
    }
    
    @Transactional(readOnly = true)
    public List findNomarlOrderByEndDate(Date orderEndDate) {
    	String hql = "select entity.id,entity.code,entity.owner,entity.salesManager,entity.salesMajordomo" +
	        " from Order entity" +
	        " where entity.orderEndTime=?" +
	        " and entity.payStatus.value=?" +
	        " order by entity.orderEndTime";
        return orderDao.find(hql, orderEndDate, DictionaryConstant.ORDER_PAY_2_HXTD_STATUS_ALL);
	}

    public List filterOrderPayment(List orders, Range<Date> range) {
        List<Object[]> filter = new ArrayList<Object[]>();
        for (int i = 0; i < orders.size(); i++) {
            Object[] row = (Object[]) orders.get(i);
            Date endTime = (Date) row[2];
            if (range.contains(endTime)) {
                filter.add(row);
            }
        }
        return filter;
    }

    public ChartModel generateChartModel(Range<Date> range, List rows) {
        if (CollectionUtils.isEmpty(rows)) {
            return null;
        }

        ChartModel chartModel = new ChartModel();
        ChartTable chartTable = new ChartTable();
        chartTable.setxAxisTitle("订单编号");
        chartTable.setxAxisHeader(new ArrayList<String>());
        chartTable.setyAxisTitle("支付金额（万元）");
        chartTable.setyAxisHeader(new ArrayList<String>());
        chartTable.getyAxisHeader().add("数值");
        chartTable.setRows(new ArrayList<List<Number>>());
        List<Number> numbers = new ArrayList<Number>();
        for (int i = 0; i < rows.size(); i++) {
            Object[] row = (Object[]) rows.get(i);
            chartTable.getxAxisHeader().add(String.valueOf(row[0]));
            numbers.add(((BigDecimal) row[1]).longValue());
        }
        chartTable.getRows().add(numbers);
        chartModel.setChartTable(chartTable);

        String minFormat = dateFormat.format(range.getMinimum());
        String maxFormat = dateFormat.format(range.getMaximum());
        Chart chart = new Chart(String.format("%s~%s订单需要支付的金额（万元）", minFormat, maxFormat));
        PieChart pieChart = new PieChart();
        for (int i = 0; i < rows.size(); i++) {
            Object[] row = (Object[]) rows.get(i);
            pieChart.addSlice(((BigDecimal) row[1]).longValue(), String.format("%s(%s)", row[0], String.valueOf(row[1])));
        }
        pieChart.setStartAngle(100);
        pieChart.setAnimate(true);
        pieChart.setTooltip("#val# / #total#<br> 占百分之 #percent#  <br>");
        chart.addElements(pieChart);

        chartModel.setChart(chart.toString());
        return chartModel;
    }


}
