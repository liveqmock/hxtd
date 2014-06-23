
package com.baihui.hxtd.soa.project.dao;

import java.util.List;

import org.hibernate.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.project.entity.Project;
@Repository
public class ProjectDao extends HibernateDAOImpl<Project, Long> {
	
	
	
	
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public long getCount(Long[] id){
		String hql="select count(pro.id) as count from Project pro where pro.isDeleted=false and pro.supplier.id in(:id)";
		Query query=getSession().createQuery(hql);
		query.setParameterList("id", id);
		long count=(Long)query.uniqueResult();
		return count;
	}
	
	
	
}
