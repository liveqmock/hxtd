package com.baihui.hxtd.soa.system.dao;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 角色数据访问类
 *
 * @author xiayouxue
 * @date 2014-5-17
 */
@Repository
public class RoleDao extends HibernateDAOImpl<Role, Long> {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 查找有效角色
     * 1.用户类型包含的
     * 2.授权分配的
     * 3.组织继承的
     */
    public List<Role> findValid(User user) {
        logger.info("查找有效角色");
        logger.debug("用户主键编号“{}”", user.getId());

        logger.info("根据用户类型获取角色");
        if (user.getIsManager()) {
            logger.debug("用户类型为“管理员”，获取所有角色");
            return find();
        } else {
            logger.debug("用户类型为“常规人员”，获取权限内角色");
            String hql = "select role from Role role" +
                    " inner join role.owners roleOwner" +
                    " left join role.organizations org" +
                    " left join org.owners orgOwner" +
                    " where role.isDeleted=false and roleOwner.id=? or orgOwner.id=?";
            List<Role> roles = find(hql, user.getId(), user.getId());
            logger.debug("数目“{}”", roles.size());
            return roles;
        }
    }
}
