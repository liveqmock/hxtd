package com.baihui.hxtd.soa.system.dao;


import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.base.utils.serial.TierSerials;
import com.baihui.hxtd.soa.system.entity.Organization;
import org.apache.commons.lang3.Range;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import org.springframework.stereotype.Repository;

/**
 * 组织数据访问类
 *
 * @author xiayouxue
 * @date 2014/5/17
 */
@Repository
public class OrganizationDao extends HibernateDAOImpl<Organization, Long> {

    /**
     * 可访问的数据
     * 1.下级组织
     */
    public static Criterion visibleData(String alias, Long order) {
        Range<Long> range = TierSerials.getYoungerRange(order, 2);
        return Restrictions.between(alias + ".order", range.getMinimum(), range.getMaximum());
    }

    /**
     * 获取序号通过主键编号
     */
    public Long getOrderById(Long id) {
        Criteria criteria = createCriteria(Restrictions.idEq(id));
        criteria.setProjection(Projections.property("order"));
        return (Long) criteria.uniqueResult();
    }

    /**
     * 更新序号根据主键编号
     */
    public int updateOrderById(Long id, Long order) {
        String hql = "update Organization org set org.order=? where id=?";
        return createQuery(hql, order, id).executeUpdate();
    }

    /**
     * 增长序号根据序号范围
     * //TODO 不能设置order的唯一约束
     */
    public int increaseOrderByOrderRange(Long orderMin, Long orderMax, long increase) {
        String hql = "update Organization org set org.order=org.order+? where org.order between ? and ?";
        return createQuery(hql, increase, orderMin, orderMax).executeUpdate();
    }

}
