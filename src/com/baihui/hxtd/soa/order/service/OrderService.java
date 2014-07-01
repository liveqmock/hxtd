
package com.baihui.hxtd.soa.order.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.order.dao.OrderDao;
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.order.util.Contacts;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.service.DataShift;
import com.baihui.hxtd.soa.util.Tools;

/**
 * 
 * 功能描述：order表service层
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.order.service.OrderService.java
 * @version (版本)1 
 * @date 2014-6-30 下午02:22:01
 */
@Service
@Transactional
public class OrderService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Resource
	private OrderDao orderDao;
	
	@Resource
	private UserDao userDao;
	
	@SuppressWarnings("unchecked")
	private DetachedCriteria biuldQuery(Map<String, Object> searchParams,DataShift dataShift,Class entityClass) throws NoSuchFieldException{
		DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
		criteria.setFetchMode("product", FetchMode.JOIN);
		criteria.setFetchMode("status", FetchMode.JOIN);
		criteria.setFetchMode("customer", FetchMode.JOIN);
		criteria.setFetchMode("investmentWay", FetchMode.JOIN);
		criteria.setFetchMode("owner", FetchMode.JOIN);
		criteria.setFetchMode("salesManager", FetchMode.JOIN);
		criteria.setFetchMode("salesMajordomo", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		userDao.visibleData(criteria, dataShift);
		Search.buildCriteria(filters, criteria, entityClass);
		return criteria;
	}
	
	
	/**
	 * 分页查找
	 */
	@Transactional(readOnly = true)
	public HibernatePage<Order> findPage(Map<String, Object> searchParams,DataShift dataShift,
			HibernatePage<Order> page) throws NoSuchFieldException {
		logger.info("分页查找线索");
		DetachedCriteria criteria = biuldQuery(searchParams,dataShift,Order.class);
		return orderDao.findPage(page, criteria);
	}
	
	/**
	 *导出 
	 */
	public List<Order> export(Map<String, Object> searchParams,DataShift dataShift)
			throws NoSuchFieldException {
		DetachedCriteria criteria = biuldQuery(searchParams,dataShift,Order.class);
		return orderDao.find(criteria, 3000);
	}
	
	
	public Order get(Long id) {
		String hql = " select ord from Order ord "
					+ " left join fetch ord.status "
					+ " left join fetch ord.product " 
					+ " left join fetch ord.customer " 
					+ " left join fetch ord.investmentWay " 
					+ " left join fetch ord.owner " 
					+ " left join fetch ord.salesManager " 
					+ " left join fetch ord.salesMajordomo " 
					+ " where ord.id=?";
		return orderDao.findUnique(hql, id);
	}
	
	
	
	public void save(Order order){
		order.setCode(getOrderCode());
		orderDao.save(order);
	}
	
	private String getOrderCode(){
		StringBuffer orderCode = new StringBuffer();
		orderCode.append(Contacts.ORDER_PREFIX);
		String dateFomat = Tools.fomatDate("yyyyMMdd");
		String hql = "select order.code from Order order where order.code like ? " +
						" and isDeleted = false order by order.code desc";
		List<String> l = orderDao.find(hql, Contacts.ORDER_PREFIX+dateFomat+"%");
		if(l==null||l.isEmpty()){
			orderCode.append(dateFomat);
			orderCode.append("0001");
		}else{
			String code = l.get(0);
			orderCode.append(Long.valueOf(code.substring(2))+1);
		}
		return orderCode.toString();
	}
	
	
	public void delete(Long[] ids){
		orderDao.delete(ids);
	}
}
