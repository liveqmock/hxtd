package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ReflectionUtils;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.report.ChartOrginal;
import com.baihui.hxtd.soa.base.utils.report.ChartTabel;
import com.baihui.hxtd.soa.base.utils.report.GraphReport;
import com.baihui.hxtd.soa.common.dao.ReportDao;
import com.baihui.hxtd.soa.common.entity.Module;
import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.service.DataShift;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
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
    private GraphReport graphReport;


    /**
     * 生成报表数据
     * 1.每个月用户的注册量
     */
    @Transactional(readOnly = true)
    public String generate(Report report, String fieldName, Date min, Date max) {

        Module module = report.getModule();
        String entityName = module.getEntityClazz().getSimpleName();
        String entityAlias = module.getName();
        String hql = String.format("select :select from %s %s :association where :where group by :group", entityName, entityAlias);
        List<String> selectParts = new ArrayList<String>();
        List<String> associationParts = new ArrayList<String>();
        List<String> groupParts = new ArrayList<String>();
        String xFieldName = report.getxFieldName();
        Dictionary xGroupType = report.getxGroupType();
        if (xGroupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
            String function = TIME_GROUP_FUNCTION.get(xGroupType.getValue());
            String xSelectItem = String.format("%s(%s.%s)", function, entityAlias, xFieldName);
            selectParts.add(xSelectItem);
            groupParts.add(xSelectItem);
        } else if (xGroupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {
            if (xGroupType.getValue().equals(DictionaryConstant.REPORT_GROUP_ELSE_MOSTDETAIL)) {
                String xSelectItem = String.format("%s.%s", entityAlias, xFieldName);
                selectParts.add(xSelectItem);
                groupParts.add(xSelectItem);
            }
        }

        String zFieldName = report.getzFieldName();
        Dictionary zGroupType = report.getzGroupType();
        if (zFieldName != null && report.getzGroupType() != null) {
            if (zGroupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
                String function = TIME_GROUP_FUNCTION.get(zGroupType.getValue());
                String xSelectItem = String.format("%s(%s.%s)", function, entityAlias, zFieldName);
                selectParts.add(xSelectItem);
                groupParts.add(xSelectItem);
            } else if (zGroupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {
                if (zGroupType.getValue().equals(DictionaryConstant.REPORT_GROUP_ELSE_MOSTDETAIL)) {
                    String xSelectItem = String.format("%s.%s", entityAlias, zFieldName);
                    selectParts.add(xSelectItem);
                    groupParts.add(xSelectItem);
                }
            }
        }

        String function = AGGREGATE_FUNCTION.get(report.getyAggregateType().getValue());
        String ySelectItem = String.format("%s(%s.%s)", function, entityAlias, report.getyFieldName());
        selectParts.add(ySelectItem);

        hql = hql.replaceFirst(":select", StringUtils.join(selectParts, ","));
        hql = hql.replaceFirst(":association", StringUtils.join(associationParts, ","));
        hql = hql.replaceFirst(":where", String.format("%s.%s between ? and ?", entityAlias, fieldName));
        hql = hql.replaceFirst(":group", StringUtils.join(groupParts, ","));

        logger.debug("hql={}", hql);
        List rows = reportDao.find(hql, min, max);
        logger.debug("rows:{}", JsonMapper.nonEmptyMapper().toJson(rows));


        ChartOrginal chartOrginal = new ChartOrginal();
        chartOrginal.setTable(rows);

        ChartTabel chartTabel = new ChartTabel();
        chartTabel.setTitle(report.getName());


        return null;
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
    public void buildXAxis(Report report, String where, Map<String, ?> conditions, ChartOrginal chartOrginal) {
        Dictionary xGroupType = report.getxGroupType();
        Date min = (Date) conditions.get("min");
        Date max = (Date) conditions.get("max");

        if (xGroupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
            chartOrginal.setxAxisValues(dateValues(min, max, TIME_GROUP_CALENDAR_UNIT.get(xGroupType.getValue())));
            chartOrginal.setxAxisDescs(chartOrginal.getxAxisValues());
        } else if (xGroupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {
            Field[] fields = ModuleService.findById(report.getModule().getId()).getFields();
            Class type = ModuleService.getFieldType(ModuleService.findFieldByName(fields, report.getxFieldName()));
            if (type.equals(Dictionary.class)) {
                List<Dictionary> xRange = dictionaryDao.findBrother(report.getxGroupType().getValue());
                chartOrginal.setxAxisValues(ReflectionUtils.invokeGetterMethod(xRange, "id"));
                chartOrginal.setxAxisDescs(ReflectionUtils.invokeGetterMethod(xRange, "name"));
            } else {
                chartOrginal.setxAxisValues(findSingleRange(report.getModule(), report.getxFieldName(), where, conditions));
                chartOrginal.setxAxisDescs(chartOrginal.getxAxisValues());
            }
        }
    }

    /**
     * 查找单一的范围
     */
    public List findSingleRange(Module module, String fieldName, String where, Map<String, ?> condition) {
        String entityName = module.getEntityClazz().getSimpleName();
        String entityAlias = module.getName();
        String selectItem = String.format("%s.%s", entityAlias, fieldName);
        String axisHql = String.format("select distinct %s from %s %s where %s order by %s", selectItem, entityName, entityAlias, where, selectItem);
        return reportDao.find(axisHql, condition);
    }

    /**
     * 构建Z轴
     */
    public void buildZAxis(Report report, Map<String, Object> conditions, ChartOrginal chartOrginal) {

    }

    /**
     * 构建数据
     */
    public void buildData(Report report, Map<String, Object> conditions, ChartOrginal chartOrginal) {

    }

    /**
     * 分组类型
     */
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
     * 时间分组函数映射
     */
    private static Map<String, String> TIME_GROUP_FUNCTION = new HashMap<String, String>();

    /**
     * 聚合函数映射
     */
    private static Map<String, String> AGGREGATE_FUNCTION = new HashMap<String, String>();


    static {
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, "YEAR");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MONTH, "MONTH");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_DATE, "DAYOFMONTH");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_HOUR, "HOUR");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MINUTE, "MINUTE");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_SECOND, "SECOND");

        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, "YEAR");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MONTH, "MONTH");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_DATE, "DAY");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_HOUR, "HOUR");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_MINUTE, "MINUTE");
        TIME_GROUP_FUNCTION.put(DictionaryConstant.REPORT_GROUP_TIME_SECOND, "SECOND");

        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_COUNT, "COUNT");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_SUM, "SUM");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_AVG, "AVG");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_MAX, "MAX");
        AGGREGATE_FUNCTION.put(DictionaryConstant.REPORT_AGGREGATE_MIN, "MIN");

    }

    public Projection find(String fieldName, Dictionary groupType) {
//        String[] parts = fieldName.split("\\.");
//        String moduleName = parts[0];
//        fieldName = parts[1];
        if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_TIME)) {
            String function = TIME_GROUP_FUNCTION.get(groupType.getValue());
            String sql = String.format("%s(%s)", function, fieldName);

        } else if (groupType.getValue().startsWith(DictionaryConstant.REPORT_GROUP_ELSE)) {

        }
        return null;
    }


    private static Map<Integer, String> patterns = new HashMap<Integer, String>();
    private static Map<String, Integer> TIME_GROUP_CALENDAR_UNIT = new HashMap<String, Integer>();

    static {
        patterns.put(Calendar.YEAR, "yyyy");
        patterns.put(Calendar.MONTH, "yyyy-MM");
        patterns.put(Calendar.DAY_OF_MONTH, "yyyy-MM-dd");
        patterns.put(Calendar.HOUR, "yyyy-MM-dd HH");
        patterns.put(Calendar.MINUTE, "yyyy-MM-dd HH:mi");
        patterns.put(Calendar.SECOND, "yyyy-MM-dd HH:mm:ss");

        patterns.put(Calendar.YEAR, "yyyy");
        patterns.put(Calendar.MONTH, "M");
        patterns.put(Calendar.DAY_OF_MONTH, "d");
        patterns.put(Calendar.HOUR_OF_DAY, "H");
        patterns.put(Calendar.MINUTE, "m");
        patterns.put(Calendar.SECOND, "s");

        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_YEAR, Calendar.YEAR);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_MONTH, Calendar.MONTH);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_DATE, Calendar.DAY_OF_MONTH);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_HOUR, Calendar.HOUR_OF_DAY);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_MINUTE, Calendar.MINUTE);
        TIME_GROUP_CALENDAR_UNIT.put(DictionaryConstant.REPORT_GROUP_TIME_SECOND, Calendar.SECOND);
    }


    /**
     * 取出日期区间内指定单位的日期值
     * 1.将起止值精确到相同单位，防止比较时因精度不一致导致数据缺失
     * 2.对日期进行格式化
     */
    public static List<Integer> dateValues(Date min, Date max, int type) {
        List<Integer> dates = new ArrayList<Integer>();

        min = DateUtils.truncate(min, type);
        max = DateUtils.truncate(max, type);

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(min);
        SimpleDateFormat format = new SimpleDateFormat(patterns.get(type));
        while (!min.after(max)) {
            dates.add(Integer.parseInt(format.format(min)));
            calendar.add(type, 1);
            min = calendar.getTime();
        }
        return dates;
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
