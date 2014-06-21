package com.baihui.hxtd.soa.common.dao;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.Common;
import org.springframework.stereotype.Repository;


@Repository
@SuppressWarnings("unchecked")
public class CommonDao extends HibernateDAOImpl<Common, Long> {

    /**
     * 获取实体通过主键编号
     */
    public <T> T get(String entityName, Long id) {
        String hql = String.format("select entity from %s entity where entity.id=?", entityName);
        return (T) createQuery(hql, id).uniqueResult();
    }

    /**
     * 获取序号通过主键编号
     */
    public Long getOrderById(String entityName, Long id) {
        String hql = String.format("select entity.order from %s entity where entity.id=?", entityName);
        return findUnique(hql, id);
    }

    /**
     * 更新序号根据主键编号
     */
    public int updateOrderById(String entityName, Long id, Long order) {
        String hql = String.format("update %s entity set entity.order=? where id=?", entityName);
        return createQuery(hql, order, id).executeUpdate();
    }

    /**
     * 增长序号根据序号范围
     * //TODO 不能设置order的唯一约束
     */
    public int increaseOrderByOrderRange(String entityName, long orderMin, long orderMax, long increase) {
        String hql = String.format("update %s entity set entity.order=entity.order+? where entity.order between ? and ?", entityName);
        return createQuery(hql, increase, orderMin, orderMax).executeUpdate();
    }

    /**
     * 增长级别根据序号范围
     */
    public int increaseLevelByOrderRange(String entityName, long orderMin, long orderMax, int increase) {
        String hql = String.format("update %s entity set entity.level=entity.level+? where entity.order between ? and ?", entityName);
        return createQuery(hql, increase, orderMin, orderMax).executeUpdate();
    }

    /**
     * 更新父节点通过唯一编号
     */
    public int updateParentById(String entityName, Long id, Long parentId) {
        String hql = String.format("update %s entity set entity.parent.id=? where entity.id=?", entityName);
        return createQuery(hql, parentId, id).executeUpdate();
    }

    /**
     * 更新是否叶子节点通过唯一编号
     */
    public int updateIsLeafById(String entityName, Long id, boolean isLeaf) {
        String hql = String.format("update %s entity set entity.isLeaf=? where entity.id=?", entityName);
        return createQuery(hql, isLeaf, id).executeUpdate();
    }

}
