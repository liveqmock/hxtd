package com.baihui.hxtd.soa.system.dao;


import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.User;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户数据访问类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Repository
public class UserDao extends HibernateDAOImpl<User, Long> {

    /**
     * 查找用户集合通过离线查询条件
     * 1.进行数据限制
     */
    public List<User> find(DetachedCriteria criteria, int maxResults) {
        Criteria executableCriteria = criteria.getExecutableCriteria(getSession());
        executableCriteria.setMaxResults(maxResults);
        return executableCriteria.list();
    }

    /**
     * 根据用户名查找用户
     */
    public User getByName(String name) {
        String hql = "select user from User user" +
                " inner join fetch user.sex" +
                " inner join fetch user.storeStatus" +
                " inner join fetch user.jobSituation" +
                " inner join fetch user.organization" +
                " where user.name=?";
        return findUnique(hql, name);
    }

    /**
     * 获取存储状态值通过主键编号
     */
    public String getStoreStatusById(Long id) {
        DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
        criteria.createAlias("storeStatus", "storeStatus");
        criteria.setProjection(Projections.property("storeStatus.value"));
        criteria.add(Restrictions.idEq(id));
        return findUnique(criteria);
    }

    /**
     * 更新用户密码通过主键编号
     */
    public int updatePasswordById(Long id, String password) {
        logger.info("更新用户密码通过主键编号");
        logger.debug("主键编号“{}”", id);
        String hql = "update User user set user.password=? where user.id=?";
        return batchExecute(hql, password, id);
    }

    /**
     * 更新用户密码通过主键编号
     */
    public int updatePasswordByIds(Long[] ids, String password) {
        logger.info("更新用户密码通过主键编号");
        logger.debug("主键编号“{}”", StringUtils.join(ids, ","));
        String hql = "update User user set user.password=:password where user.id in (:id)";
        return getSession().createQuery(hql).setParameterList("id", ids).setParameter("password", password).executeUpdate();
    }

    /**
     * 更新用户启用状态通过主键编号
     */
    public int updateIsActiveByIds(Long[] ids, Boolean isActive) {
        logger.info("更新用户启用状态通过主键编号");
        logger.debug("主键编号“{}”", StringUtils.join(ids, ","));
        String hql = "update User user set user.isActive=:isActive where user.id in (:id)";
        return getSession().createQuery(hql).setParameterList("id", ids).setParameter("isActive", isActive).executeUpdate();
    }

    /**
     * 更新用户数据存储状态通过主键编号
     */
    public int updateStoreStatusById(Long id, Long storeStatusId) {
        logger.info("更新用户数据存储状态通过主键编号");
        logger.debug("主键编号“{}”", id);
        String hql = "update User user set user.storeStatus.id=? where user.id=?";
        return batchExecute(hql, storeStatusId, id);
    }

    /**
     * 重置用户数据存储状态
     * 1.登录时，将数据存储状态置为最新
     */
    public int resetDataStoreStatusById(Long id) {
        logger.info("重置用户的数据存储状态");
        return updateStoreStatusById(id, Long.parseLong("01040401"));
    }

    /**
     * 更新用户数据存储状态
     * 1.session中存储的数据发生改变时，更新数据存储状态
     */
    public int updateDataStoreStatusById(Long id) {
        logger.info("更新用户的数据存储状态");
        return updateStoreStatusById(id, Long.parseLong("01040402"));
    }

    /**
     * 更新管理员用户数据存储状态
     */
    public int updateManagerStoreStatus() {
        logger.info("更新管理员用户数据存储状态");
        String hql = "update User user set user.storeStatus.id=01040402 where user.isManager=true";
        return batchExecute(hql);
    }
}
