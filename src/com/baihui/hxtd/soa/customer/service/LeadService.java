package com.baihui.hxtd.soa.customer.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.customer.dao.LeadDao;
import com.baihui.hxtd.soa.customer.entity.Lead;

/**
 * 
 * 功能描述：线索表service层实现
 * 
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.customer.service.LeadService.java
 * @version (版本) 1.0
 * @date 2014-5-13 下午07:28:30
 */
@Service
@Transactional
public class LeadService {
	private Logger logger = LoggerFactory.getLogger(LeadService.class);

	@Resource
	private LeadDao leadDao;

	/**
	 * 根据id查询Lead对象
	 */
	public Lead get(Long id) {
		String hql = " select  lead from Lead lead "
				+ " left join fetch lead.source "
				+ " left join fetch lead.status "
				+ " left join fetch lead.cardType "
				+ " left join fetch lead.industry "
				+ " left join fetch lead.owner " + " where lead.id=?";
		return leadDao.findUnique(hql, id);
	}

	/**
	 * 根据id查询Lead对象
	 */
	public List<Lead> get(List<Long> ids) {
		return leadDao.get(ids);
	}

	/**
	 * 修改
	 * 
	 * @param lead
	 */
	public void modify(Lead lead) {
		logger.info("修改用户");
		leadDao.update(lead);
	}

	public void save(Lead lead) {
		logger.info("保存线索信息{}", lead);
		leadDao.save(lead);

	}

	/**
	 * 分页查找
	 */
	@Transactional(readOnly = true)
	public HibernatePage<Lead> findPage(Map<String, Object> searchParams,
			HibernatePage<Lead> page) throws NoSuchFieldException {
		logger.info("分页查找线索");
		DetachedCriteria criteria = DetachedCriteria.forClass(Lead.class);
		criteria.add(Restrictions.eq("isDeleted", false));
		criteria.setFetchMode("source", FetchMode.JOIN);
		criteria.setFetchMode("status", FetchMode.JOIN);
		criteria.setFetchMode("industry", FetchMode.JOIN);
		criteria.setFetchMode("cardType", FetchMode.JOIN);
		criteria.setFetchMode("owner", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		Search.buildCriteria(filters, criteria, Lead.class);
		return leadDao.findPage(page, criteria);
	}

	public List<Lead> export(Map<String, Object> searchParams)
			throws NoSuchFieldException {
		DetachedCriteria criteria = DetachedCriteria.forClass(Lead.class);
		criteria.add(Restrictions.eq("isDeleted", false));
		criteria.setFetchMode("source", FetchMode.JOIN);
		criteria.setFetchMode("status", FetchMode.JOIN);
		criteria.setFetchMode("industry", FetchMode.JOIN);
		criteria.setFetchMode("cardType", FetchMode.JOIN);
		criteria.setFetchMode("owner", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		Search.buildCriteria(filters, criteria, Lead.class);
		return leadDao.find(criteria, 3000);
	}

	/**
	 * delete(删除线索信息)
	 * 
	 * @param id
	 */
	public void delete(Long... id) {
		leadDao.delete(id);
	}

	public int modifyOwner(Long ownerId, Long... ids) {
		return leadDao.modifyOwner(ownerId, ids);

	}

	public LeadDao getLeadDao() {
		return leadDao;
	}

	public void setLeadDao(LeadDao leadDao) {
		this.leadDao = leadDao;
	}

}
