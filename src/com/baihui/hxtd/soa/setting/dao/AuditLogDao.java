package com.baihui.hxtd.soa.setting.dao;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.customer.entity.Contact;
import com.baihui.hxtd.soa.setting.entity.AuditLog;

/**
 * 
 * 功能描述：联系人模块持久化层实现类
 * 
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.5
 * @ClassName: com.baihui.hxtd.soa.customer.dao.ContactDao.java
 * @version (版本) 1
 * @date 2014-5-16 下午04:07:53
 */
@Repository
public class AuditLogDao extends HibernateDAOImpl<AuditLog, Long>  {

}
