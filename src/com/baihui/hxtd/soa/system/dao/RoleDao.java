package com.baihui.hxtd.soa.system.dao;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.Role;
import org.springframework.stereotype.Repository;

/**
 * 角色数据访问类
 *
 * @author xiayouxue
 * @date 2014-5-17
 */
@Repository
public class RoleDao extends HibernateDAOImpl<Role, Long> {
}
