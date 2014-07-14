
package com.baihui.hxtd.soa.project.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.project.entity.Product;


/**
 * 功能描述：产品(基金)模块持久化层实现类
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.Product.dao.ProductDao.java
 * @version (版本) 1
 * @date 2014-5-16 下午04:07:53
 */
@Repository
public class ProductDao extends HibernateDAOImpl<Product, Long> {
	/**
	  * getCount(产品是否关联项目)
	  * @param id 供应商Id
	  * @return 条数 
	 */
	public long getCount(Long[] id){
		String hql = "select count(pro.id) from Product pro where pro.isDeleted=false and  pro.project.id in (:id)";
		Query query = getSession().createQuery(hql);
		query.setParameterList("id", id);
		long count=(Long)query.uniqueResult();
		return count;
	}
	
	/**
	  * getOrdersCount(通过产品id获取订单数量)
	  * @Title: getOrdersCount
	  * @param productIds 产品id 
	  * @return long 返回类型
	 */
	public long getOrdersCount(Long[] productIds){
		String hql = "select count(o.id) from Order o where o.isDeleted=false and o.product.id in (:id)";
		Query query = getSession().createQuery(hql);
		query.setParameterList("id", productIds);
		long count=(Long)query.uniqueResult();
		return count;
	}
}
