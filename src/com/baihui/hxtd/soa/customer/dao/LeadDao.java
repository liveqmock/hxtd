package com.baihui.hxtd.soa.customer.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.customer.entity.Lead;

/**
 * 
 * 功能描述：线索表持久化层
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.customer.dao.LeadDao.java
 * @version (版本) 1.0
 * @date 2014-5-13 下午07:28:30
 */
@Repository
public class LeadDao extends HibernateDAOImpl<Lead, Long>{

	/**
	 * 修改线索所有者
	 * @param ownerId
	 * @param ids
	 * @return
	 */
	public int modifyOwner(Long ownerId, Long[] ids) {
		String hql="update Lead lead set lead.owner.id=? where lead.id in (:list)";
		Query q = createQuery(hql);
		q.setParameter(0, ownerId);
		q.setParameterList("list", ids);
		return q.executeUpdate();
	}
	/**
 	  *重写save方法，设定参数 
	  * @param lead
	  * @return
	  * @see com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl#save(java.lang.Object)
	 */
	public Lead save(Lead lead){
		if(lead.getProvince().getId()==null){
			lead.setProvince(null);
		}
		if(lead.getCity().getId()==null){
			lead.setCity(null);
		}
		if(lead.getCounty().getId()==null){
			lead.setCounty(null);
		}
		return super.save(lead);
	}
	
}
