package com.baihui.hxtd.soa.common.dao;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.ModuleType;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 模块类型数据访问类
 *
 * @author xiayouxue
 * @date 2014/7/8
 */
@Repository
public class ModuleTypeDao extends HibernateDAOImpl<ModuleType, Long> {

    /**
     * 查找模块主键编号通过类型编号
     */
    public List<Long> findModuleIdByTypeId(Long typeId) {
        String hql = "select moduleType.moduleId from ModuleType moduleType inner join moduleType.type type where type.id=?";
        return find(hql, typeId);
    }

}
