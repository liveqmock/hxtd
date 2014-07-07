package com.baihui.hxtd.soa.system.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.RecycleBin;

/**
 * 
 * 功能描述：回收站模块持久化层实现类
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.5
 * @version (版本) 1
 * @date 2014-5-16 下午04:07:53
 */
@Repository
public class RecycleBinDao extends HibernateDAOImpl<RecycleBin, Long>  {
	public void logicalDelete(Long... ids) {
		Query sqlQuery = getSession().createQuery("delete from AuditLog where id in (:ids)");
		//batchExecute(hql, values)
		sqlQuery.setParameterList("ids", ids);
		sqlQuery.executeUpdate();
		
	}

}
