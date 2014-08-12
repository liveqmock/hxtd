package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.utils.report.ChartModel;
import com.baihui.hxtd.soa.base.utils.report.ChartTable;
import com.baihui.hxtd.soa.order.dao.OrderDao;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ro.nextreports.jofc2.model.Chart;
import ro.nextreports.jofc2.model.elements.PieChart;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
     * 1.完成时间 in (当日-6,当日)
     * 2.财务状态 = 已付款
     * 3.支付金额=购买金额*（1+收益率）
     */
    public ChartModel countOrderPayment(Date min, Date max) {
        ChartModel chartModel = new ChartModel();
        String hql = "select entity.code,entity.purchaseMoney*(1+entity.earningRate)" +
                " from Order entity" +
                " where entity.orderEndTime between ? and ?" +
                " and entity.payStatus.value=?" +
                " order by entity.orderEndTime";
        List rows = orderDao.find(hql, min, max, DictionaryConstant.ORDER_PAY_2_HXTD_STATUS_ALL);
        logger.info("rows.size={}", rows == null ? 0 : rows.size());
        if (CollectionUtils.isEmpty(rows)) {
            return chartModel;
        }

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
            numbers.add((Number) row[1]);
        }
        chartTable.getRows().add(numbers);
        chartModel.setChartTable(chartTable);

        Chart chart = new Chart(String.format("%s~%s订单需要支付的金额（万元）", dateFormat.format(min), dateFormat.format(max)));
        PieChart pieChart = new PieChart();
        for (int i = 0; i < rows.size(); i++) {
            Object[] row = (Object[]) rows.get(i);
            pieChart.addSlice((Number) row[1], String.format("%s(%s)", row[0], String.valueOf(row[1])));
        }
        pieChart.setStartAngle(100);
        pieChart.setAnimate(true);
        pieChart.setTooltip("#val#  /  #total#<br> 占百分之 #percent#  <br>");
        chart.addElements(pieChart);

        chartModel.setChart(chart.toString());
        return chartModel;
    }

    /**
     * 计算完成时间在一周内的订单支付金额
     */
    @Transactional(readOnly = true)
    public ChartModel countOrderPaymentInWeek() {
        logger.info("计算完成时间在一周内的订单支付金额");
        Calendar calendar = Calendar.getInstance();
        calendar = DateUtils.truncate(calendar, Calendar.DATE);
        Date weekMin = calendar.getTime();

        calendar.add(Calendar.DATE, 6);
        calendar = DateUtils.ceiling(calendar, Calendar.DATE);
        calendar.add(Calendar.MILLISECOND, -1);
        Date weekMax = calendar.getTime();

        ChartModel chartModel = countOrderPayment(weekMin, weekMax);

        return chartModel;
    }

    /**
     * 计算完成时间在一周内的订单支付金额
     */
    @Transactional(readOnly = true)
    public ChartModel countOrderPaymentInMonth() {
        logger.info("计算完成时间在一周内的订单支付金额");

        Calendar calendar = Calendar.getInstance();
        calendar = DateUtils.truncate(calendar, Calendar.DATE);
        Date weekMin = calendar.getTime();

        calendar.add(Calendar.DATE, 30);
        calendar = DateUtils.ceiling(calendar, Calendar.DATE);
        calendar.add(Calendar.MILLISECOND, -1);
        Date weekMax = calendar.getTime();

        ChartModel chartModel = countOrderPayment(weekMin, weekMax);

        return chartModel;
    }
}
