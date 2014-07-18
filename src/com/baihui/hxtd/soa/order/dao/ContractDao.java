package com.baihui.hxtd.soa.order.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.order.entity.Contract;

@Repository
public class ContractDao extends HibernateDAOImpl<Contract, Long>{

	public long getCount(Long[] id,String module){
		String hql="select count(con.id) as count from Contract con where con.isDeleted=false and con."+module+".id in(:id)";
		Query query=getSession().createQuery(hql);
		query.setParameterList("id", id);
		long count=(Long)query.uniqueResult();
		return count;
	}

	
}
