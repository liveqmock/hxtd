package com.baihui.hxtd.soa.customer.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.dao.AttachmentDao;
import com.baihui.hxtd.soa.common.dao.MemoirDao;
import com.baihui.hxtd.soa.customer.dao.ContactDao;
import com.baihui.hxtd.soa.customer.dao.CustomerDao;
import com.baihui.hxtd.soa.customer.dao.LeadDao;
import com.baihui.hxtd.soa.customer.entity.Contact;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.customer.entity.Lead;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;

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
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	private LeadDao leadDao;
	
	@Resource
	private UserDao userDao;
	
	@Resource
	private CustomerDao customerDao;
	
	@Resource
	private ContactDao contactDao;

	@Resource
	private AttachmentDao attachementDao;

	@Resource
	private MemoirDao memoirDao;
	/**
	 * 根据id查询Lead对象
	 */
	public Lead get(Long id) {
		String hql = " select  lead from Lead lead "
				+ " left join fetch lead.source "
				+ " left join fetch lead.status "
				+ " left join fetch lead.cardType "
				+ " left join fetch lead.industry "
				+ " left join fetch lead.province "
				+ " left join fetch lead.city " 
				+ " left join fetch lead.county " 
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

	public void add(Lead lead,User u) {
		logger.info("保存线索信息{}", lead);
		if(lead.getProvince().getId()==null){
			lead.setProvince(null);
		}
		if(lead.getCity().getId()==null){
			lead.setCity(null);
		}
		if(lead.getCounty().getId()==null){
			lead.setCounty(null);
		}
		leadDao.save(lead);
	}
	
	public void modify(Lead lead, User u) {
		logger.info("保存线索信息{}", lead);
		if(lead.getProvince().getId()==null){
			lead.setProvince(null);
		}
		if(lead.getCity().getId()==null){
			lead.setCity(null);
		}
		if(lead.getCounty().getId()==null){
			lead.setCounty(null);
		}
		leadDao.save(lead);
	}

	/**
	 * 分页查找
	 */
	@Transactional(readOnly = true)
	public HibernatePage<Lead> findPage(Map<String, Object> searchParams,DataShift dataShift,
			HibernatePage<Lead> page) throws NoSuchFieldException {
		logger.info("分页查找线索");
		DetachedCriteria criteria = biuldQuery(searchParams,dataShift,Lead.class);
		return leadDao.findPage(page, criteria);
	}
	
	public List<Lead> export(Map<String, Object> searchParams,DataShift dataShift)
			throws NoSuchFieldException {
		DetachedCriteria criteria = biuldQuery(searchParams,dataShift,Lead.class);
		return leadDao.find(criteria, 3000);
	}

	
	@SuppressWarnings("unchecked")
	private DetachedCriteria biuldQuery(Map<String, Object> searchParams,DataShift dataShift,Class entityClass) throws NoSuchFieldException{
		DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
		criteria.setFetchMode("source", FetchMode.JOIN);
		criteria.setFetchMode("status", FetchMode.JOIN);
		criteria.setFetchMode("industry", FetchMode.JOIN);
		criteria.setFetchMode("cardType", FetchMode.JOIN);
		criteria.setFetchMode("owner", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		userDao.visibleData(criteria, dataShift);
		Search.buildCriteria(filters, criteria, entityClass);
		return criteria;
	}
	/**
	 * delete(删除线索信息)
	 * 
	 * @param id
	 */
	public void delete(User user, Long... id) {
		leadDao.logicalDelete(id);
	}

	/**
	 * 
	  * leadConverter(线索转换为客户和联系人)
	  * @Title: leadConverter
	  * @param @param id    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	public void leadConverter(User user, Long id){
		logger.info("线索转换开始，ID={}",id);
		Lead lead = this.get(id);
		
		logger.debug("转换客户信息");
		Customer cus = new Customer();
		BeanUtils.copyProperties(lead, cus);
		logger.debug("客户来源指定为线索转换");
		cus.setSource(new Dictionary(4030206L));
		cus.setId(null);
		customerDao.save(cus);
		
		logger.debug("转换联系人信息");
		Contact con = new Contact();
		BeanUtils.copyProperties(lead, con);
		con.setSource(null);
		con.setId(null);
		con.setCustomer(cus);
		contactDao.save(con);
		
		logger.debug("修改线索的附件以及联系纪要给联系人");
		attachementDao.leadConverter(lead, con);
		memoirDao.leadConverter(lead, con);
		
		logger.info("删除线索信息 ID={}",id);
		this.delete(user, id);
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

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

}
