package com.baihui.hxtd.soa.common.dao;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.Report;
import org.springframework.stereotype.Repository;

/**
 * 报表数据访问类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Repository
public class ReportDao extends HibernateDAOImpl<Report, Long> {

}
