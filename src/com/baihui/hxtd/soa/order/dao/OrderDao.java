
package com.baihui.hxtd.soa.order.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.order.entity.Order;
/**
 * 
 * 功能描述：订单持久化类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.order.dao.OrderDao.java
 * @version (版本) 1
 * @date 2014-6-30 上午11:10:28
 */
@Repository
public class OrderDao extends HibernateDAOImpl<Order, Long> {
	
	
	public void delete(Long... id) {
		for (int i = 0; i < id.length; i++) {
			super.logicalDelete(id[i]);
		}
	}

	public Long getCount(Long[] id, String module) {
		String hql="select count(con.id) as count from Order con where con.isDeleted=false and con."+module+".id in(:id)";
		Query query=getSession().createQuery(hql);
		query.setParameterList("id", id);
		long count=(Long)query.uniqueResult();
		return count;
	}
	
	
	public Order save(Order order){
		if(order.getStatus()!=null&&order.getStatus().getId()==null){
			order.setStatus(null);
		}
		return super.save(order);
	}
	
	
}
