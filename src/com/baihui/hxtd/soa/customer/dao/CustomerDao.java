package com.baihui.hxtd.soa.customer.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.customer.entity.Customer;
/**
 * 
 * 功能描述：客户表持久化层
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.customer.dao.LeadDao.java
 * @version (版本) 1.0
 * @date 2014-5-20 下午05:38:30
 */
@Repository
public class CustomerDao extends HibernateDAOImpl<Customer, Long>{
	/**
	 * get(根据ID查询组客户
	 * 
	 */
	@Override
	public Customer get(Long id) {
		// TODO Auto-generated method stub
		return super.get(id);
	}

	public void updateOwner(Long ownerId, Long[] id) {
		String hql = "update Customer customer set customer.owner.id=:id where customer.id in (:list)";
		Query query = createQuery(hql);
		query.setParameter("id",ownerId);
		query.setParameterList("list", id);
		query.executeUpdate();
		
	}

	public Customer getById(Long id) {
        StringBuffer hql=new StringBuffer("from Customer customer ");
        hql.append("left join fetch customer.owner ");
        hql.append("left join fetch customer.type ");
        hql.append("left join fetch customer.source ");
        hql.append("left join fetch customer.riskGrade ");
        hql.append("left join fetch customer.cardType ");
        hql.append("left join fetch customer.openBank ");
        hql.append("left join fetch customer.ownerShip ");
        hql.append("left join fetch customer.industry ");
        hql.append("left join fetch customer.creator ");
        hql.append("left join fetch customer.modifier ");
        hql.append("left join fetch customer.province ");
        hql.append("left join fetch customer.city ");
        hql.append("left join fetch customer.county ");
        hql.append("left join fetch customer.property ");
        hql.append("where customer.id=? ");
		return findUnique(hql.toString(), id);
	}
	
}
