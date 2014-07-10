package com.baihui.hxtd.soa.system.dao;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.Workbanch;
@Repository
public class WorkbanchDao extends HibernateDAOImpl<Workbanch, Long>{

	
	public void modifyOrder(Long[] ids){
		String hql = "update Workbanch work set work.orderIndex = ? where work.id=?"; 
		for(int i=0;i<ids.length;i++){
			batchExecute(hql,Long.valueOf(i),ids[i]);
		}  
	}
}
