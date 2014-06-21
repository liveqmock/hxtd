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
        String hql = "from Dictionary dic where dic.parent.value=?";
        return find(hql, parentValue);
    }

}
