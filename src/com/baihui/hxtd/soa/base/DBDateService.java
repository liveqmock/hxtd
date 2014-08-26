package com.baihui.hxtd.soa.base;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 获取数据库时间
 *
 * @author xiayouxue
 * @date 2014/8/26
 */
@Service
public class DBDateService {

    private static SessionFactory sessionFactory;

    @Transactional(readOnly = true)
    public Date nowDate() {
        String sql = "select current_date";
        return (Date) sessionFactory.getCurrentSession().createSQLQuery(sql).uniqueResult();
    }

    @Transactional(readOnly = true)
    public Date nowTime() {
        String sql = "select current_timestamp";
        return (Date) sessionFactory.getCurrentSession().createSQLQuery(sql).uniqueResult();
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    @Resource
    public void setSessionFactory(SessionFactory sessionFactory) {
        DBDateService.sessionFactory = sessionFactory;
    }


}
