package com.baihui.hxtd.soa.common.dao;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;


@Repository
public class ImportDao extends HibernateDAOImpl<Object, Long>{

	/**
	 * 根据一个或多个主键查询数据库
	 * @param t
	 * @param typeList
	 * @return 实体类集合
	 */
	
	public Object getByUnique(String entityName, String paramter, String... value){
		String hql = String.format("select entity from %s entity where entity.isDeleted=false %s", entityName,paramter);
		List list = find(hql,value);
		return (list==null||list.size()==0)?null:list.get(0);
	}
	
	/**
	 * 批量新增或保存数据
	 */
	public List<Object> saveOrUpdate(List<Object> entities){
		//清楚缓存，否则第二次导入重复数据的时候，会直接去缓存中读取。
		getSession().clear();
		return merge(entities);
	}
	
}
