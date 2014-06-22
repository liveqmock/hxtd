package com.baihui.hxtd.soa.system.dao;


import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.Organization;
import org.apache.commons.lang3.Range;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
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
     * 下级组织
     */
    public Criterion younger(String alias, Range<Long> range) {
        return Restrictions.between(alias + ".order", range.getMinimum(), range.getMaximum());
    }

    /**
     * 当前组织和下级组织
     */
    public Criterion selfAndYounger(String alias, Long id, Range<Long> range) {
        return Restrictions.or(Restrictions.eq(alias + ".id", id), younger(alias, range));
    }

    /**
     * 获取序号通过主键编号
     */
    public Long getOrderById(Long id) {
        String hql = "select org.order from Organization org where org.id=?";
        return findUnique(hql, id);
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
