package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.base.utils.mapper.JsonMapper;
import com.baihui.hxtd.soa.common.dao.ReportDao;
import com.baihui.hxtd.soa.system.entity.User;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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

    /**
     * 生成报表数据
     * 1.每个月用户的注册量
     */
    @Transactional(readOnly = true)
    public String generate() {
        DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
        ProjectionList projectionList = Projections.projectionList();
        projectionList.add(Projections.groupProperty("month(createTime)"));
        projectionList.add(Projections.count("id"));
        criteria.setProjection(projectionList);

        Calendar calendar = Calendar.getInstance();
        Date end = calendar.getTime();
        calendar.add(Calendar.MONTH, -3);
        criteria.add(Restrictions.between("createTime", calendar.getTime(), end));

//        List<Object[]> rows = criteria.getExecutableCriteria(reportDao.getSession()).list();
//        logger.debug("rows:{}", JsonMapper.nonEmptyMapper().toJson(rows));

        return null;
    }
}
