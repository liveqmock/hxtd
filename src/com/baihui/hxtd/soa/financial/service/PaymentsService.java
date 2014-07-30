package com.baihui.hxtd.soa.financial.service;

import java.text.ParseException;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.financial.dao.PaymentsDao;
import com.baihui.hxtd.soa.financial.entity.Payments;
import com.baihui.hxtd.soa.order.dao.OrderDao;
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;

/**
 * 
 * 功能描述：付款管理服务类
 * 
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.order.dao.OrderDao.java
 * @version (版本) 1
 * @date 2014-7-27 上午11:10:28
 */

@Service
@Transactional(readOnly = true)
public class PaymentsService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	private PaymentsDao paymentsDao;
	
	@Resource
	private OrderDao orderDao;

	@Resource
	private DictionaryDao dictionaryDao;

	/**
	 * 分页查询
	 * 
	 * @param searchParams
	 * @param dataShift
	 * @param page
	 * @return HibernatePage<Receivables>
	 * @throws NoSuchFieldException
	 */
	public HibernatePage<Payments> findPage(Map<String, Object> searchParams,
			HibernatePage<Payments> page) throws NoSuchFieldException {
		logger.info("分页查找");
		searchParams.put("EQ_isDeleted", false);
		DetachedCriteria criteria = biuldQuery(searchParams, Payments.class);
		return paymentsDao.findPage(page, criteria);
	}

	private DetachedCriteria biuldQuery(Map<String, Object> searchParams,
			Class<Payments> entityClass) throws NoSuchFieldException {
		DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
		criteria.setFetchMode("customer", FetchMode.JOIN);
		criteria.setFetchMode("order", FetchMode.JOIN);
		criteria.setFetchMode("owner", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		criteria.setFetchMode("openBank", FetchMode.JOIN);
		criteria.setFetchMode("payType", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		Search.buildCriteria(filters, criteria, entityClass);
		return criteria;
	}

	@Transactional(readOnly = false)
	public void add(Payments payments, AuditLog auditLog) {
		payments.setCreatedTime(paymentsDao.getDBNow());
		payments.setModifiedTime(payments.getCreatedTime());
		payments.setOperateTime(payments.getCreatedTime());
		if (payments.getActual() == null) {
			payments.setStatus(false);
		} else {
			payments.setStatus(true);
		}
		paymentsDao.save(payments);
		auditLog.setRecordId(payments.getId());

	}

	/**
	 *根据ID获取付款实体类
	 * 
	 * @param id
	 * @return
	 * @throws ParseException
	 */
	public Payments getById(Long id) throws ParseException {
		String hql = "from Payments payments "
				+ " left join fetch payments.order "
				+ " left join fetch payments.owner "
				+ " left join fetch payments.customer "
				+ " left join fetch payments.modifier "
				+ " left join fetch payments.creator "
				+ " left join fetch payments.openBank "
				+ " left join fetch payments.payType " + " where payments.id=?";
		Payments payments = paymentsDao.findUnique(hql, id);
		return payments;
	}

	/**
	 * 修改付款管理
	 * 
	 * @param id
	 * @return
	 * @throws ParseException
	 */
	@Transactional(readOnly = false)
	public void modify(Payments payments, AuditLog auditLog) {
		if (payments.getActual() == null) {
			payments.setStatus(false);
		} else {
			payments.setStatus(true);
		}
		payments.setModifiedTime(paymentsDao.getDBNow());
		payments.setOperateTime(payments.getModifiedTime());
		paymentsDao.save(payments);
		if (payments.getOrder() != null && payments.getOrder().getId() != null ){
			orderDao.modifyOrderPayStatusByIdStatus(dictionaryDao
					.getByValue(DictionaryConstant.ORDER_PAY_CUSTOMER_HXTD_STATUS_ALL),
					payments.getOrder().getId());
		}
	}

	/**
	 * 删除
	 * 
	 * @param id
	 * @param auditLogArr
	 */
	@Transactional(readOnly = false)
	public void delete(Long[] id, AuditLog[] auditLogArr) {
		paymentsDao.logicalDelete(id);
	}

	
}