package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.base.utils.report.GraphReport;
import com.baihui.hxtd.soa.base.utils.report.TwoDimensionReportData;
import com.baihui.hxtd.soa.common.dao.ReportDao;
import com.baihui.hxtd.soa.common.entity.Report;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;
import org.apache.commons.lang3.time.DateUtils;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.StandardBasicTypes;
import org.hibernate.type.Type;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 报表服务类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Service
public class ReportService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private ReportDao reportDao;

    @Resource
    private GraphReport graphReport;

    @Resource
    private UserDao userDao;

    /**
     * 生成报表数据
     * 1.每个月用户的注册量
     */
    @Transactional(readOnly = true)
    public String generate() {
        //获取统计数据
        DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
        ProjectionList projectionList = Projections.projectionList();
        projectionList.add(Projections.sqlGroupProjection("MONTH({alias}.CREATED_TIME) as createdTime", "MONTH({alias}.CREATED_TIME)", new String[]{"createdTime"}, new Type[]{StandardBasicTypes.STRING}));
        projectionList.add(Projections.count("id"));
        criteria.setProjection(projectionList);

        Calendar calendar = Calendar.getInstance();
        Date end = calendar.getTime();
        calendar.add(Calendar.MONTH, -3);
        Date begin = calendar.getTime();
        criteria.add(Restrictions.between("createdTime", begin, end));

        List rows = criteria.getExecutableCriteria(reportDao.getSession()).list();
        logger.debug("rows:{}", JsonMapper.nonEmptyMapper().toJson(rows));

        TwoDimensionReportData reportData = new TwoDimensionReportData();
        reportData.setTitle("每个月用户的注册量");

        reportData.setxAxisTitle("5~6月");
        reportData.setxAxises(dateValues(begin, end, Calendar.MONTH));
        reportData.setxAxisTitles(reportData.getxAxises());

        reportData.setyAxisTitle("注册量");
        reportData.setyAxises(new ArrayList());
        reportData.setyAxisTitles(reportData.getyAxises());

        reportData.fullEmptyData();
        reportData.buildXAxisIndexs();
        reportData.fullValidData(rows);

        String chartData = graphReport.generateTwoDimensionChart(GraphReport.TYPE_BAR, reportData);
        logger.debug("chartData:{}", chartData);
        return chartData;
    }


    private static Map<Integer, String> patterns = new HashMap<Integer, String>();

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
        patterns.put(Calendar.HOUR, "H");
        patterns.put(Calendar.MINUTE, "m");
        patterns.put(Calendar.SECOND, "s");

    }


    /**
     * 取出日期区间内指定单位的日期值
     * 1.将起止值精确到相同单位，防止比较时因精度不一致导致数据缺失
     * 2.对日期进行格式化
     */
    public static List<String> dateValues(Date min, Date max, int type) {
        List<String> dates = new ArrayList<String>();

        min = DateUtils.truncate(min, type);
        max = DateUtils.truncate(max, type);

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(min);
        SimpleDateFormat format = new SimpleDateFormat(patterns.get(type));
        while (!min.after(max)) {
            dates.add(format.format(min));
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

        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, detachedCriteria, Report.class);
        userDao.visibleData(detachedCriteria, dataShift);
        return reportDao.findPage(page, detachedCriteria);
    }


}
