package com.baihui.hxtd.soa.customer.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Criteria;
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
import com.baihui.hxtd.soa.customer.dao.CustomerDao;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.Notice;
import com.baihui.hxtd.soa.system.service.DataShift;

/**
 * 功能描述：客户模块service层
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.customer.service.CustomerServlet.java
 * @version (版本)1
 * @date 2014-5-20 下午03:32:19
 */
@Service
@Transactional
public class CustomerService {

	private Logger logger = LoggerFactory.getLogger(LeadService.class);

	@Resource
	private CustomerDao customerDao;
	 @Resource
	    private UserDao userDao;
	private Integer exportCounts = 5000;
	/**
     * 分页查找
     */
    @Transactional(readOnly = true)
    public HibernatePage<Customer> findPage(Map<String, Object> searchParams, HibernatePage<Customer> page,DataShift dataShift) throws NoSuchFieldException {
        logger.info("分页查找客户");
        DetachedCriteria criteria = DetachedCriteria.forClass(Customer.class);
        criteria.setFetchMode("owner", FetchMode.JOIN);
        criteria.setFetchMode("type", FetchMode.JOIN);
        criteria.setFetchMode("source", FetchMode.JOIN);
        criteria.setFetchMode("riskGrade", FetchMode.JOIN);
        criteria.setFetchMode("cardType", FetchMode.JOIN);
        criteria.setFetchMode("openBank", FetchMode.JOIN);
        criteria.setFetchMode("industry", FetchMode.JOIN);
        criteria.setFetchMode("province", FetchMode.JOIN);
        criteria.setFetchMode("city", FetchMode.JOIN);
		criteria.setFetchMode("county", FetchMode.JOIN);
		criteria.setFetchMode("creator", FetchMode.JOIN);
		criteria.setFetchMode("modifier", FetchMode.JOIN);
		userDao.visibleData(criteria, dataShift);
		searchParams.put("EQ_isDeleted", false);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Customer.class);
        return customerDao.findPage(page, criteria);
    }
    
    
    /**
	 * 根据id查询Customer对象
	 */
	public Customer get(Long id) {
		return customerDao.get(id);
	}
	
    /**
     * 保存客户信息
     * @param lead
     */
	public void save(Customer customer) {
		logger.info("保存客户信息{}", customer);
		customer.setIsDeleted(false);
		customerDao.save(customer);

	}
	
	 /**
     * delete(删除客户信息)
     * @param id
     */
    public void delete(Long... id) {
    	customerDao.logicalDelete(id);
    }
    
    /**
     * 修改客户所有者
     * @param ownerId
     * @param id
     */
    public void modifyOwner(Long ownerId, Long[] id) {
    	customerDao.updateOwner(ownerId,id);
		
	}


    /**
     * 根据id查询客户
     * @author huizijing
     * @param id
     * @return Customer
     */
	public Customer getById(Long id) {
		return customerDao.getById(id);
	}


	@SuppressWarnings("unchecked")
	public List<Customer> find() {
		logger.info("查找");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Notice.class);
        detachedCriteria.setFetchMode("owner", FetchMode.JOIN);
        detachedCriteria.setFetchMode("creator", FetchMode.JOIN);
        detachedCriteria.setFetchMode("type", FetchMode.JOIN);
        detachedCriteria.setFetchMode("modifier", FetchMode.JOIN);
        detachedCriteria.add(Restrictions.eq("isDeleted", false));

        Criteria criteria = detachedCriteria.getExecutableCriteria(customerDao.getSession());
        criteria.setMaxResults(exportCounts);
        return (List<Customer>) criteria.list();
	}


	public List<Customer>  find(Map<String, Object> searchParams) throws NoSuchFieldException {
		logger.info("分页查找用户");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Customer.class);
        detachedCriteria.setFetchMode("owner", FetchMode.JOIN);
        detachedCriteria.setFetchMode("creator", FetchMode.JOIN);
        detachedCriteria.setFetchMode("type", FetchMode.JOIN);
        detachedCriteria.setFetchMode("modifier", FetchMode.JOIN);
        detachedCriteria.add(Restrictions.eq("isDeleted", false));
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        
        Search.buildCriteria(filters, detachedCriteria, Customer.class);
        return customerDao.find(detachedCriteria, exportCounts);

	}


	}



