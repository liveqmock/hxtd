package com.baihui.hxtd.soa.system.dao;


import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 字典数据访问类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Repository
public class DictionaryDao extends HibernateDAOImpl<Dictionary, Long> {

    /**
     * 获取主键编号通过代码值
     */
    public Long getIdByValue(String value) {
        String hql = "select dic.id from Dictionary dic where dic.value=?";
        return findUnique(hql, value);
    }

    /**
     * 获取字典通过字典值
     */
    public Dictionary getByValue(String value) {
        String hql = "from Dictionary dic where dic.value=?";
        return findUnique(hql, value);
    }

    /**
     * 获取字典列表通过父节点字典值
     */
    public List<Dictionary> findChildren(String parentValue) {
        String hql = "from Dictionary dic where dic.parent.value=? order by dic.value";
        return find(hql, parentValue);
    }

    /**
     * 获取字典列表通过节点字典值
     */
    public List<Dictionary> findBrother(String value) {
        String hql = "from Dictionary dic" +
                " where dic.parent=(select current.parent from Dictionary current where current.value=?)" +
                " order by dic.value";
        return find(hql, value);
    }

    public Dictionary getValue(String key, Long parentId) {
        String hql = "from Dictionary dic where dic.parent.id=? and dic.key=?";
        return findUnique(hql, parentId, key);
    }

}
