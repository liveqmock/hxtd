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

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.financial.dao.ReceivablesDao;
import com.baihui.hxtd.soa.financial.entity.Receivables;
import com.baihui.hxtd.soa.order.dao.OrderDao;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;

/**
 * 
 * 功能描述：收款管理服务类
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
@Transactional
public class ReceivablesService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	private ReceivablesDao receivablesDao;

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
	 * @return HibernatePage<receivables>
	 * @throws NoSuchFieldException
	 */
	@Transactional(readOnly = true)
	public HibernatePage<Receivables> findPage(
			Map<String, Object> searchParams, HibernatePage<Receivables> page)
			throws NoSuchFieldException {
		logger.info("分页查找");
		searchParams.put("EQ_isDeleted", false);
		DetachedCriteria criteria = biuldQuery(searchParams, Receivables.class);
		return receivablesDao.findPage(page, criteria);
	}

	private DetachedCriteria biuldQuery(Map<String, Object> searchParams,
			Class<Receivables> entityClass) throws NoSuchFieldException {
		DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
		criteria.setFetchMode("customer", FetchMode.JOIN);
		criteria.setFetchMode("order", FetchMode.JOIN);
		criteria.setFetchMode("owner", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		Search.buildCriteria(filters, criteria, entityClass);
		return criteria;
	}

	/**
	 * 增加收款单
	 * 
	 * @param receivables
	 * @param auditLog
	 */
	@Transactional(readOnly = false)
	public void add(Receivables receivables, AuditLog auditLog) {
		receivables.setCreatedTime(receivablesDao.getDBNow());
		receivables.setModifiedTime(receivables.getCreatedTime());
		receivables.setOperateTime(receivables.getCreatedTime());
		if (receivables.getActual() == null) {
			receivables.setStatus(false);
		} else {
			receivables.setStatus(true);
		}
		receivablesDao.save(receivables);
		auditLog.setRecordId(receivables.getId());

	}

	/**
	 *根据ID获取收款管理实体类
	 * 
	 * @param id
	 * @return
	 * @throws ParseException
	 */
	@Transactional(readOnly = true)
	public Receivables getById(Long id) throws ParseException {
		String hql = "from Receivables receivables "
				+ " left join fetch receivables.order "
				+ " left join fetch receivables.owner "
				+ " left join fetch receivables.customer "
				+ " left join fetch receivables.modifier "
				+ " left join fetch receivables.creator "
				+ " where receivables.id=?";
		Receivables receivables = receivablesDao.findUnique(hql, id);
		return receivables;
	}

	/**
	 * 修改收款单
	 * 
	 * @param receivables
	 * @param auditLog
	 */
	@Transactional(readOnly = false)
	public void modify(Receivables receivables, AuditLog auditLog) {
		if (receivables.getActual() == null) {
			receivables.setStatus(false);
		} else {
			receivables.setStatus(true);
		}
		receivables.setModifiedTime(receivablesDao.getDBNow());
		receivables.setOperateTime(receivables.getModifiedTime());
		receivablesDao.save(receivables);
		if (receivables.getOrder() != null && receivables.getOrder().getId() != null ){
			orderDao.modifyOrderPayStatusByIdStatus(dictionaryDao
					.getByValue(DictionaryConstant.ORDER_PAY_2_HXTD_STATUS_ALL),
					receivables.getOrder().getId());
		}
	}

	/**
	 * 删除收款单
	 * 
	 * @param id
	 * @param auditLogArr
	 */
	@Transactional(readOnly = false)
	public void delete(Long[] id, AuditLog[] auditLogArr) {
		receivablesDao.logicalDelete(id);
	}

}