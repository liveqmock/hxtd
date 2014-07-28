package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.FieldInfo;
import com.baihui.hxtd.soa.base.FieldInfoParser;
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
import com.baihui.hxtd.soa.util.CommonCalendar;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.Range;
import org.apache.commons.lang3.time.DateUtils;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

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
    private ChartGenerate chartGenerate;

    /** 查找时间类型字段，默认返回createdTime */
    public static String findTimeTypeFieldName(Report report) {
        Module module = InitApplicationConstant.findModuleById(report.getModule().getId());
        Field[] fields = module.getFields();
        String[] names = {report.getxFieldName(), report.getyFieldName(), report.getzFieldName()};
        for (int i = 0; i < names.length; i++) {
            String name = names[i];
            if (name != null) {
                Field field = ModuleUtil.findFieldByName(fields, name);
                if (field.getType().equals(Date.class)) {
                    return name;
                }
            }
        }
        return "createdTime";
    }

    /**
     * 构建以当前时间为基础的过滤器
     *
     * @param name 字段名称
     * @param type 时间类型，使用Calendar的时间单位
     * @return
     */
    public static Collection<SearchFilter> buildTimeFilter(String name, int type) {
        List<SearchFilter> searchFilters = new ArrayList<SearchFilter>();
        Range<Date> range = CommonCalendar.generateDateRange(new Date(), type);
        searchFilters.add(new SearchFilter(name, SearchFilter.Operator.GTE, range.getMinimum()));
        searchFilters.add(new SearchFilter(name, SearchFilter.Operator.LT, range.getMaximum()));
        return searchFilters;
    }

    /** 生成报表数据 */
    @Transactional(readOnly = true)
    public ChartModel generate(Report report, Collection<SearchFilter> filters) throws NoSuchFieldException {

        if (filters.size() == 0) {
            filters = buildTimeFilter(findTimeTypeFieldName(report), report.getTimeType());
        }

        Module module = report.getModule();
        Field[] fields = module.getFields();

        //创建 Chart
        ChartModel chartModel = new ChartModel(report.getName());

        //创建 hql
        ExtendItemSelectHql hql = new ExtendItemSelectHql(module.getEntityClazz().getSimpleName(), module.getName());
        Search.buildWhereHql(filters, hql, module.getEntityClazz());

        //创建 ReportData
        ReportData reportData = new ReportData();
        buildXAxis(report, hql, reportData);
        if (report.getzFieldName() != null) {
            buildZAxis(report, hql, reportData);
        }
        buildData(report, hql, reportData);

        //创建 ChartTable
        ChartTable chartTable = new ChartTable();
        chartTable.setTitle(report.getName());
        chartTable.setxAxisTitle(FieldInfoParser.toModuleField(ModuleUtil.findFieldByName(fields, report.getxFieldName())).getDesc());
        List<String> xAxisDescs = ReflectionUtils.invokeGetterMethod(reportData.getxAxis(), "desc");
        chartTable.setxAxisHeader(xAxisDescs);
        if (report.getzFieldName() == null) {
            chartTable.setyAxisTitle(HqlFunction.AGGREGATES.get(report.getyAggregateType().getValue()).getDesc());
            chartTable.setyAxisHeader(new ArrayList());
            chartTable.getyAxisHeader().add("数值");
            chartTable.setRows(new ArrayList());
            chartTable.getRows().add(ChartUtil.toTable(reportData.getRows(), reportData.getxAxis()));
        } else {
            chartTable.setyAxisTitle(FieldInfoParser.toModuleField(ModuleUtil.findFieldByName(fields, report.getzFieldName())).getDesc());
            List<String> zAxisDescs = ReflectionUtils.invokeGetterMethod(reportData.getzAxis(), "desc");
            chartTable.setyAxisHeader(zAxisDescs);
            chartTable.setRows(ChartUtil.toTable(reportData.getRows(), reportData.getxAxis(), reportData.getzAxis()));
        }
        chartModel.setChartTable(chartTable);

        //创建 ReportChart
        ReportChart reportChart = new ReportChart();
        reportChart.setTitle(chartTable.getTitle());
        reportChart.setChartType(ChartType.findByValue(report.getChart().getValue()));
        reportChart.setDimensionality(report.getzFieldName() == null ? ReportChart.Dimensionality.two : ReportChart.Dimensionality.three);
        reportChart.setxAxisTitle(chartTable.getxAxisTitle());
        reportChart.setxAxisLabels(chartTable.getxAxisHeader());
        reportChart.setyAxisRange(reportData.getyAxisRange());
        reportChart.setzAxisTitle(chartTable.getyAxisTitle());
        reportChart.setzAxisLabels(chartTable.getyAxisHeader());
        reportChart.setData(chartTable.getRows());

        chartModel.setChart(chartGenerate.generateChart(reportChart));

        logger.info("chartModule={}", chartModel);

        return chartModel;
    }


    /** 生成报表根据编码和查询条件 */
    @Transactional(readOnly = true)
    public ChartModel generate(String code, Collection<SearchFilter> filters) throws NoSuchFieldException {
        Report report = getByCode(code);
        report.setModule(InitApplicationConstant.findModuleById(report.getModule().getId()));
        return generate(report, filters);
    }

    /** 时间分组日历单位 */
    private static Map<String, Integer> TIME_GROUP_CALENDAR_UNIT = new HashMap<String, Integer>();

    static {
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, Calendar.YEAR);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_QUARTER, Calendar.MONTH);
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

    /** 时间格式 */
    private static Map<Integer, String[]> PATTERNS = new HashMap<Integer, String[]>();

    static {
        PATTERNS.put(Calendar.YEAR, new String[]{"yyyy", "年"});
        PATTERNS.put(CommonCalendar.QUARTER, new String[]{null, "季"});
        PATTERNS.put(Calendar.MONTH, new String[]{"M", "月"});
        PATTERNS.put(Calendar.WEEK_OF_MONTH, new String[]{"w", "周"});
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

        if (type == CommonCalendar.QUARTER) {

        } else if (type == Calendar.WEEK_OF_MONTH) {

        } else {
            min = DateUtils.truncate(min, type);
            max = DateUtils.truncate(max, type);
        }

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

    /** 构建字典轴 */
    private List<AxisInfo> buildDictionaryAxis(Module module, String fieldName, Dictionary groupType, ExtendItemSelectHql hql) {
        List<AxisInfo> axisInfos = new ArrayList<AxisInfo>();
        Field field = ModuleUtil.findFieldByName(module.getFields(), fieldName);
        List<Dictionary> axisValues = dictionaryDao.findChildren(field.getAnnotation(FieldInfo.class).dictionary());
        for (int i = 0; i < axisValues.size(); i++) {
            Dictionary dictionary = axisValues.get(i);
            axisInfos.add(new AxisInfo(dictionary.getKey(), dictionary.getId()));
        }
        return axisInfos;
    }

    /** 构建数据轴 */
    private List buildDataAxis(Module module, String fieldName, Dictionary groupType, ExtendItemSelectHql hql) {
        List<AxisInfo> axisInfos = new ArrayList<AxisInfo>();

        String select = String.format("%s.%s", hql.getEntityAlias(), fieldName);
        String from = String.format("%s %s", hql.getEntityName(), hql.getEntityAlias());
        SelectHql selectHql = new SelectHql("distinct " + select, from);
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
            Field[] fields = InitApplicationConstant.findModuleById(module.getId()).getFields();
            Field field = ModuleUtil.findFieldByName(fields, fieldName);
            Class type = ReflectionUtils.getEntityFieldType(field);
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
            Field[] fields = InitApplicationConstant.findModuleById(module.getId()).getFields();
            Field field = ModuleUtil.findFieldByName(fields, fieldName);
            Class type = ReflectionUtils.getEntityFieldType(field);
            if (type.equals(Dictionary.class)) {
                reportData.setzAxis(buildDictionaryAxis(module, fieldName, groupType, hql));
            } else {
                reportData.setzAxis(buildDataAxis(module, fieldName, groupType, hql));
            }
        }
    }

    /** 构建数据 */
    public void buildData(Report report, ExtendItemSelectHql hql, ReportData reportData) {
        buildXAxisHql(report, hql);
        if (report.getzFieldName() != null) {
            buildZAxisHql(report, hql);
        }
        buildYAxisHql(report, hql);

        List rows = reportDao.find(hql.toString(), hql.getConditionValues());
        logger.debug("rows={}", JsonMapper.nonEmptyMapper().toJson(rows));
        reportData.setRows(rows);

        reportData.getyAxisRange().setMax(10);
        if (CollectionUtils.isNotEmpty(rows)) {
            List numbers = new ArrayList();
            int index = report.getzFieldName() == null ? 1 : 2;
            for (int i = 0; i < rows.size(); i++) {
                Object[] row = (Object[]) rows.get(i);
                numbers.add(row[index]);
            }
            Collections.sort(numbers);
            reportData.getyAxisRange().setMin((Number) numbers.get(0));
            reportData.getyAxisRange().setMax((Number) numbers.get(numbers.size() - 1));
        }
    }

    /** 时间分组函数映射 */
    private static Map<String, String> TIME_GROUP_FUNCTION = new HashMap<String, String>();

    static {
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, "YEAR(%s)");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_QUARTER, "QUARTER(%s)");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MONTH, "MONTH(%s)");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_WEEK, "CAST(DATE_FORMAT(%s,'%%c'),Integer)");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_DATE, "DAY(%s)");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_HOUR, "HOUR(%s)");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MINUTE, "MINUTE(%s)");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_SECOND, "SECOND(%s)");
    }

    /** 构建轴hql语句 */
    private void buildAxisHql(Field field, Dictionary groupType, ExtendItemSelectHql hql) {
        String fieldName = field.getName();
        if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
            String function = TIME_GROUP_FUNCTION.get(groupType.getValue());
            String selectItem = String.format(function, String.format("%s.%s", hql.getEntityAlias(), fieldName));
            hql.getSelectItems().add(selectItem);
            hql.getGroupByItems().add(selectItem);
        } else if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {
            String selectItem = "%s.%s";
            if (ModuleUtil.isAssociation(field, InitApplicationConstant.MODULES)) {
                selectItem = "%s.%s.id";
            }
            selectItem = String.format(selectItem, hql.getEntityAlias(), fieldName);
            hql.getSelectItems().add(selectItem);
            hql.getGroupByItems().add(selectItem);
        }
    }

    /** 构建x轴hql语句 */
    public void buildXAxisHql(Report report, ExtendItemSelectHql hql) {
        buildAxisHql(ModuleUtil.findFieldByName(report.getModule().getFields(), report.getxFieldName()), report.getxGroupType(), hql);
    }

    /** 构建y轴hql语句 */
    public void buildYAxisHql(Report report, ExtendItemSelectHql hql) {
        String function = HqlFunction.AGGREGATES.get(report.getyAggregateType().getValue()).getName();
        String ySelectItem = String.format("%s(%s.%s)", function, hql.getEntityAlias(), report.getyFieldName());
        hql.getSelectItems().add(ySelectItem);
    }

    /** 构建z轴hql语句 */
    public void buildZAxisHql(Report report, ExtendItemSelectHql hql) {
        buildAxisHql(ModuleUtil.findFieldByName(report.getModule().getFields(), report.getzFieldName()), report.getzGroupType(), hql);
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
     * 分页查找
     */
    @Transactional(readOnly = true)
    public List<Report> findAllReport(DataShift dataShift) throws NoSuchFieldException {
        logger.info("分页查找用户");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Report.class);
        userDao.visibleData(detachedCriteria, dataShift);
        return reportDao.find(detachedCriteria);
    }

    /** 字段名称转换为描述 */
    public List<Report> nameToDesc(List<Report> reports) {
        for (int i = 0; i < reports.size(); i++) {
            nameToDesc(reports.get(i));
        }
        return reports;
    }

    /** 字段名称转换为描述 */
    public Report nameToDesc(Report report) {
        Module module = InitApplicationConstant.findModuleById(report.getModule().getId());
        Field[] fields = module.getFields();
        Field xField = ModuleUtil.findFieldByName(fields, report.getxFieldName());
        report.setxFieldName(FieldInfoParser.toModuleField(xField).getDesc());
        if (report.getyFieldName() != null) {
            Field yField = ModuleUtil.findFieldByName(fields, report.getyFieldName());
            report.setyFieldName(FieldInfoParser.toModuleField(yField).getDesc());
        }
        if (report.getzFieldName() != null) {
            Field zField = ModuleUtil.findFieldByName(fields, report.getzFieldName());
            report.setzFieldName(FieldInfoParser.toModuleField(zField).getDesc());
        }
        return report;
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

    /** 获取通过编号 */
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

    /** 获取报表根据编号 */
    @Transactional(readOnly = true)
    public Report getByCode(String code) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Report.class);
        criteria.setFetchMode("module", FetchMode.JOIN);
        criteria.setFetchMode("chart", FetchMode.JOIN);
        criteria.setFetchMode("xGroupType", FetchMode.JOIN);
        criteria.setFetchMode("yAggregateType", FetchMode.JOIN);
        criteria.setFetchMode("zGroupType", FetchMode.SELECT);
        criteria.add(Restrictions.eq("code", code));
        return userDao.findUnique(criteria);
    }


    /** 修改 */
    @Transactional
    public void modify(Report report, AuditLog auditLog) {
        logger.info("修改");
        reportDao.update(report);
    }


}
