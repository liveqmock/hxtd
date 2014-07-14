package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.base.InitApplicationConstant;
import com.baihui.hxtd.soa.base.orm.ExtendItemSelectHql;
import com.baihui.hxtd.soa.base.orm.SelectHql;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.report.*;
import com.baihui.hxtd.soa.common.dao.ReportDao;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.service.DataShift;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;
import ro.nextreports.jofc2.model.Chart;

import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 报表服务类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Service
@SuppressWarnings("unchecked")
public class ReportService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ReportDao reportDao;

    @Resource
    private UserDao userDao;

    @Resource
    private DictionaryDao dictionaryDao;

    @Resource
    private ChartGenerate chartGraphGenerate;


    /**
     * 生成报表数据
     * 1.每个月用户的注册量
     */
    @Transactional(readOnly = true)
    public ChartModel generate(Report report, Map<String, SearchFilter> filters) throws NoSuchFieldException {

        Module module = report.getModule();
        Field[] fields = module.getFields();

        //创建Chart
        ChartModel chartModel = new ChartModel(report.getName());

        //创建hql
        ExtendItemSelectHql hql = new ExtendItemSelectHql(module.getEntityClazz().getSimpleName(), module.getName());
        Search.buildWhereHql(filters, hql, module.getEntityClazz());

        //创建ChartOrginal
        ReportData reportData = new ReportData();
        buildXAxis(report, hql, reportData);
        if (report.getzFieldName() != null) {
            buildZAxis(report, hql, reportData);
        }
        buildData(report, hql, reportData);

        //创建ChartTable
        ChartTable chartTable = new ChartTable();
        chartTable.setTitle(report.getName());
        chartTable.setxAxisTitle(ModuleService.toModuleField(ModuleService.findFieldByName(fields, report.getxFieldName())).getDesc());
        List<String> xAxisDescs = ReflectionUtils.invokeGetterMethod(reportData.getxAxis(), "desc");
        chartTable.setxAxisHeader(xAxisDescs);
        if (report.getzFieldName() == null) {
            chartTable.setyAxisTitle("总数");
            chartTable.setyAxisHeader(new ArrayList());
            chartTable.getyAxisHeader().add("数值");
            chartTable.setRows(new ArrayList());
            chartTable.getRows().add(ChartUtil.toTable(reportData.getRows(), reportData.getxAxis()));
        } else {
            chartTable.setyAxisTitle(ModuleService.toModuleField(ModuleService.findFieldByName(fields, report.getzFieldName())).getDesc());
            List<String> zAxisDescs = ReflectionUtils.invokeGetterMethod(reportData.getzAxis(), "desc");
            chartTable.setyAxisHeader(zAxisDescs);
            chartTable.setRows(ChartUtil.toTable(reportData.getRows(), reportData.getxAxis(), reportData.getzAxis()));
        }
        chartModel.setChartTable(chartTable);

        //创建ChartGraph
        ReportChart reportChart = new ReportChart();
        reportChart.setTitle(chartTable.getTitle());
        reportChart.setGraphType(GraphType.findByValue(report.getChart().getValue()));
        reportChart.setxAxisTitle(chartTable.getxAxisTitle());
        reportChart.setxAxisLabels(chartTable.getxAxisHeader());
        reportChart.setyAxisRange(reportData.getyAxisRange());
        if (report.getzFieldName() != null) {
            reportChart.setzAxisTitle(chartTable.getyAxisTitle());
            reportChart.setzAxisLabels(chartTable.getyAxisHeader());
            reportChart.setData(chartTable.getRows());
        } else {
            reportChart.setData(chartTable.getRows());
        }
        chartModel.setCharts(new ArrayList<Chart>());
        if (report.getzFieldName() != null) {
            chartModel.getCharts().add(chartGraphGenerate.generateThreeDimensionChart(reportChart));
        } else {
            chartModel.getCharts().add(chartGraphGenerate.generateTwoDimensionChart(reportChart));
        }

        logger.info("chartModule={}", chartModel);

        return chartModel;
    }

    /** 时间分组日历单位 */
    private static Map<String, Integer> TIME_GROUP_CALENDAR_UNIT = new HashMap<String, Integer>();

    static {
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, Calendar.YEAR);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_MONTH, Calendar.MONTH);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_DATE, Calendar.DAY_OF_MONTH);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_HOUR, Calendar.HOUR_OF_DAY);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_MINUTE, Calendar.MINUTE);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_SECOND, Calendar.SECOND);
    }

    /** 构建时间轴 */
    private List<AxisInfo> buildTimeAxis(Module module, String fieldName, Dictionary groupType, ExtendItemSelectHql hql) {
        Date min = (Date) hql.getConditionValues().get(Search.placeHodler(fieldName, SearchFilter.Operator.GTE));
        Date max = (Date) hql.getConditionValues().get(Search.placeHodler(fieldName, SearchFilter.Operator.LTE));
        return dateValues(min, max, TIME_GROUP_CALENDAR_UNIT.get(groupType.getValue()));
    }

    private static Map<Integer, String[]> PATTERNS = new HashMap<Integer, String[]>();

    static {
        PATTERNS.put(Calendar.YEAR, new String[]{"yyyy", "年"});
        PATTERNS.put(Calendar.MONTH, new String[]{"M", "月"});
        PATTERNS.put(Calendar.DAY_OF_MONTH, new String[]{"d", "日"});
        PATTERNS.put(Calendar.HOUR_OF_DAY, new String[]{"H", "时"});
        PATTERNS.put(Calendar.MINUTE, new String[]{"m", "分"});
        PATTERNS.put(Calendar.SECOND, new String[]{"s", "秒"});
    }

    /**
     * 取出日期区间内指定单位的日期值
     * 1.将起止值精确到相同单位，防止比较时因精度不一致导致数据缺失
     * 2.对日期进行格式化
     */
    public static List<AxisInfo> dateValues(Date min, Date max, int type) {
        List<AxisInfo> dates = new ArrayList<AxisInfo>();

        min = DateUtils.truncate(min, type);
        max = DateUtils.truncate(max, type);

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(min);
        SimpleDateFormat format = new SimpleDateFormat();
        String[] patterns = PATTERNS.get(type);
        while (!min.after(max)) {
            AxisInfo axisInfo = new AxisInfo();
            format.applyPattern(patterns[0]);
            String value = format.format(min);
            axisInfo.setValue(Integer.parseInt(value));
            format.applyPattern(patterns[1]);
            axisInfo.setDesc(new ChineseFormat().format(value) + format.format(min));
            dates.add(axisInfo);
            calendar.add(type, 1);
            min = calendar.getTime();
        }
        return dates;
    }

    private List<AxisInfo> buildDictionaryAxis(Module module, String fieldName, Dictionary groupType, ExtendItemSelectHql hql) {
        List<AxisInfo> axisInfos = new ArrayList<AxisInfo>();
        Field field = ModuleService.findFieldByName(module.getFields(), fieldName);
        List<Dictionary> axisValues = dictionaryDao.findChildren(field.getAnnotation(FieldInfo.class).dictionary());
        for (int i = 0; i < axisValues.size(); i++) {
            Dictionary dictionary = axisValues.get(i);
            axisInfos.add(new AxisInfo(dictionary.getKey(), dictionary.getId()));
        }
        return axisInfos;
    }

    private List buildDataAxis(Module module, String fieldName, Dictionary groupType, ExtendItemSelectHql hql) {
        List<AxisInfo> axisInfos = new ArrayList<AxisInfo>();

        String select = String.format("%s.%s", hql.getEntityAlias(), fieldName);
        String from = String.format("distinct %s %s", hql.getEntityName(), hql.getEntityAlias());
        SelectHql selectHql = new SelectHql(select, from);
        selectHql.setWhere(hql.toWhere().getWhere());
        selectHql.setOrderBy(select);
        List rows = reportDao.find(selectHql.toString(), hql.getConditionValues());
        for (int i = 0; i < rows.size(); i++) {
            Object row = rows.get(i);
            axisInfos.add(new AxisInfo(String.valueOf(row), row));
        }
        return axisInfos;
    }

    /**
     * 构建X轴
     * 1.设置X轴值
     * 2.设置X轴描述
     * <p/>
     * 取至分组类型
     * 1.日期分组
     * 1.1.根据时间范围，获取X轴值范围
     * 2.其他分组
     * 2.1.如果是字典，取至字典表
     * 2.2.如果是其他，取至数据表
     */
    public void buildXAxis(Report report, ExtendItemSelectHql hql, ReportData reportData) {
        Module module = report.getModule();
        String fieldName = report.getxFieldName();
        Dictionary groupType = report.getxGroupType();
        if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
            reportData.setxAxis(buildTimeAxis(module, fieldName, groupType, hql));
        } else if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {
            Field[] fields = ModuleService.findById(module.getId()).getFields();
            Field field = ModuleService.findFieldByName(fields, fieldName);
            Class type = ModuleService.getFieldType(field);
            if (type.equals(Dictionary.class)) {
                reportData.setxAxis(buildDictionaryAxis(module, fieldName, groupType, hql));
            } else {
                reportData.setxAxis(buildDataAxis(module, fieldName, groupType, hql));
            }
        }
    }

    /**
     * 构建z轴
     */
    public void buildZAxis(Report report, ExtendItemSelectHql hql, ReportData reportData) {
        Module module = report.getModule();
        String fieldName = report.getzFieldName();
        Dictionary groupType = report.getzGroupType();
        if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
            reportData.setzAxis(buildTimeAxis(module, fieldName, groupType, hql));
        } else if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {
            Field[] fields = ModuleService.findById(module.getId()).getFields();
            Field field = ModuleService.findFieldByName(fields, fieldName);
            Class type = ModuleService.getFieldType(field);
            if (type.equals(Dictionary.class)) {
                reportData.setzAxis(buildDictionaryAxis(module, fieldName, groupType, hql));
            } else {
                reportData.setzAxis(buildDataAxis(module, fieldName, groupType, hql));
            }
        }
    }

    /**
     * 构建数据
     */
    public void buildData(Report report, ExtendItemSelectHql hql, ReportData reportOrginal) {
        buildXAxisHql(report, hql);
        if (report.getzFieldName() != null) {
            buildZAxisHql(report, hql);
        }
        buildYAxisHql(report, hql);

        List rows = reportDao.find(hql.toString(), hql.getConditionValues());
        logger.debug("rows={}", JsonMapper.nonEmptyMapper().toJson(rows));
        reportOrginal.setRows(rows);

        if (CollectionUtils.isNotEmpty(rows)) {
            List<Long> numbers = new ArrayList<Long>();
            int index = report.getzFieldName() == null ? 1 : 2;
            for (int i = 0; i < rows.size(); i++) {
                Object[] row = (Object[]) rows.get(i);
                numbers.add((Long) row[index]);
            }
            Collections.sort(numbers);
            reportOrginal.getyAxisRange().setMin(numbers.get(0));
            reportOrginal.getyAxisRange().setMax(numbers.get(numbers.size() - 1));
        }
    }

    /** 时间分组函数映射 */
    private static Map<String, String> TIME_GROUP_FUNCTION = new HashMap<String, String>();

    static {
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, "YEAR");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MONTH, "MONTH");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_DATE, "DAY");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_HOUR, "HOUR");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MINUTE, "MINUTE");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_SECOND, "SECOND");
    }

    private void buildAxisHql(Field field, Dictionary groupType, ExtendItemSelectHql hql) {
        String fieldName = field.getName();
        if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
            String function = TIME_GROUP_FUNCTION.get(groupType.getValue());
            String selectItem = String.format("%s(%s.%s)", function, hql.getEntityAlias(), fieldName);
            hql.getSelectItems().add(selectItem);
            hql.getGroupByItems().add(selectItem);
        } else if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {
            String selectItem = "%s.%s";
            if (ModuleService.isAssociation(field, InitApplicationConstant.MODULES)) {
                selectItem = "%s.%s.id";
            }
            selectItem = String.format(selectItem, hql.getEntityAlias(), fieldName);
            hql.getSelectItems().add(selectItem);
            hql.getGroupByItems().add(selectItem);
        }
    }

    public void buildXAxisHql(Report report, ExtendItemSelectHql hql) {
        buildAxisHql(ModuleService.findFieldByName(report.getModule().getFields(), report.getxFieldName()), report.getxGroupType(), hql);
    }

    /** 聚合函数映射 */
    private static Map<String, String> AGGREGATE_FUNCTION = new HashMap<String, String>();

    static {
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_COUNT, "COUNT");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_SUM, "SUM");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_AVG, "AVG");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_MAX, "MAX");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_MIN, "MIN");
    }

    public void buildYAxisHql(Report report, ExtendItemSelectHql hql) {
        String function = AGGREGATE_FUNCTION.get(report.getyAggregateType().getValue());
        String ySelectItem = String.format("%s(%s.%s)", function, hql.getEntityAlias(), report.getyFieldName());
        hql.getSelectItems().add(ySelectItem);
    }

    public void buildZAxisHql(Report report, ExtendItemSelectHql hql) {
        buildAxisHql(ModuleService.findFieldByName(report.getModule().getFields(), report.getzFieldName()), report.getzGroupType(), hql);
    }


    /** 分组类型 */
    private static Map<Class, String> CLASS_GROUP_TYPE = new HashMap<Class, String>();

    static {
        CLASS_GROUP_TYPE.put(Date.class, DictionaryConstant.REPORT_GROUP_TIME);
    }

    /**
     * 查找分组类型根据类
     */
    @Transactional(readOnly = true)
    public List<Dictionary> findGroupType(Class clazz) {
        logger.info("查找分组类型根据类");
        logger.debug("类={}", clazz.getName());

        List<Dictionary> targetDictionaries = new ArrayList<Dictionary>();

        //根据class查找
        String groupType = null;
        for (Map.Entry<Class, String> entry : CLASS_GROUP_TYPE.entrySet()) {
            if (entry.getKey().equals(clazz)) {
                groupType = entry.getValue();
                break;
            }
        }

        //赋予默认值
        if (groupType == null) {
            groupType = DictionaryConstant.REPORT_GROUP_ELSE;
        }

        logger.debug("报表分组类型={}", groupType);
        targetDictionaries.addAll(dictionaryDao.findChildren(groupType));

        return targetDictionaries;
    }


    /**
     * 分页查找
     */
    @Transactional(readOnly = true)
    public HibernatePage<Report> findPage(Map<String, Object> searchParams, HibernatePage<Report> page, DataShift dataShift) throws NoSuchFieldException {
        logger.info("分页查找用户");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Report.class);
        detachedCriteria.setFetchMode("module", FetchMode.JOIN);
        detachedCriteria.setFetchMode("xGroupType", FetchMode.JOIN);
        detachedCriteria.setFetchMode("yAggregateType", FetchMode.JOIN);
        detachedCriteria.setFetchMode("zGroupType", FetchMode.JOIN);
        detachedCriteria.setFetchMode("chart", FetchMode.JOIN);

        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, detachedCriteria, Report.class);
        userDao.visibleData(detachedCriteria, dataShift);
        return reportDao.findPage(page, detachedCriteria);
    }


    /**
     * 新增
     */
    @Transactional
    public void add(Report report, AuditLog auditLog) {
        logger.info("新增");
        report.setCreatedTime(new Date());
        report.setIsDeleted(false);
        report.setIsInitialized(false);
        reportDao.save(report);
    }

    /**
     * 获取通过编号
     */
    @Transactional(readOnly = true)
    public Report get(Long id) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Report.class);
        criteria.setFetchMode("module", FetchMode.JOIN);
        criteria.setFetchMode("xGroupType", FetchMode.JOIN);
        criteria.setFetchMode("yAggregateType", FetchMode.JOIN);
        criteria.setFetchMode("zGroupType", FetchMode.JOIN);
        criteria.setFetchMode("chart", FetchMode.JOIN);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.add(Restrictions.idEq(id));
        return userDao.findUnique(criteria);
    }

    /**
     * 修改
     */
    @Transactional
    public void modify(Report report, AuditLog auditLog) {
        logger.info("修改");
        reportDao.update(report);
    }


}
