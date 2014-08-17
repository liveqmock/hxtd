package com.baihui.hxtd.soa.order.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
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
import com.baihui.hxtd.soa.order.dao.ContractDao;
import com.baihui.hxtd.soa.order.entity.Contract;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.service.DataShift;

@Service
@Transactional
public class ContractService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private UserDao userDao;
	
	@Resource
	private ContractDao contractDao;
	
	
	/**
	 * 分页查询
	 * @param searchParams
	 * @param dataShift
	 * @param page
	 * @return HibernatePage<Contract>
	 * @throws NoSuchFieldException 
	 */
	public HibernatePage<Contract> findPage(Map<String, Object> searchParams,
		DataShift dataShift, HibernatePage<Contract> page) throws NoSuchFieldException {
		logger.info("分页查找");
		searchParams.put("EQ_isDeleted", false);
		DetachedCriteria criteria = biuldQuery(searchParams,dataShift,Contract.class);
		return contractDao.findPage(page, criteria);
	}

	private DetachedCriteria biuldQuery(Map<String, Object> searchParams,DataShift dataShift,Class<Contract> entityClass) throws NoSuchFieldException{
		DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
		criteria.setFetchMode("customer", FetchMode.JOIN);
		criteria.setFetchMode("order", FetchMode.JOIN);
		criteria.setFetchMode("type", FetchMode.JOIN);
		criteria.setFetchMode("redeemType", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		userDao.visibleData(criteria, dataShift.renameUserFieldName("creator"));
		Search.buildCriteria(filters, criteria, entityClass);
		return criteria;
	}

	public void add(Contract contract,AuditLog auditLog ) {
		contract.setCreatedTime(contractDao.getDBNow());
		contract.setModifiedTime(contract.getCreatedTime());
		contractDao.save(contract);
		auditLog.setRecordId(contract.getId());
		
	}

	/**
	 *根据ID获取合同实体类
	 * @param id
	 * @return
	 * @throws ParseException 
	 */
	public Contract getById(Long id) throws ParseException {
		String hql = "from Contract con "
			+ " left join fetch con.order "
			+ " left join fetch con.type " 
			+ " left join fetch con.customer " 
			+ " left join fetch con.redeemType " 
			+ " left join fetch con.modifier " 
			+ " left join fetch con.creator " 
			+ " where con.id=?";
		 Contract contract=contractDao.findUnique(hql, id);
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		 contract.setSignTime(format.parse(contract.getSignTime().toString()));
		 contract.setSignTime(format.parse(contract.getEffectTime().toString()));
		 contract.setSignTime(format.parse(contract.getBereftTime().toString()));
		 return contract;
	}

	public void modify(Contract contract,AuditLog auditLog ) {
		contract.setModifiedTime(contractDao.getDBNow());
		contractDao.save(contract);
	}

	/**
	 * 删除合同
	 * @param id
	 * @param auditLogArr
	 */
	public void delete(Long[] id, AuditLog[] auditLogArr) {
		contractDao.logicalDelete(id);
	}

	/**
	 * 导出数据
	 * @param searchParams
	 * @param dataShift
	 * @return List<Contract>
	 * @throws NoSuchFieldException 
	 */
	public List<Contract> export(Map<String, Object> searchParams,
			DataShift dataShift) throws NoSuchFieldException {
		DetachedCriteria criteria = biuldQuery(searchParams,dataShift,Contract.class);
		return contractDao.find(criteria, 3000);
	}
}
