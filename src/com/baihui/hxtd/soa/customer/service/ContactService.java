package com.baihui.hxtd.soa.customer.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.customer.dao.ContactDao;
import com.baihui.hxtd.soa.customer.entity.Contact;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;

/**
 * 功能描述：供应商模块service层
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.customer.service.ContactService.java
 * @version (版本)1
 * @date 2014-5-16 下午04:48:19
 */
@Service
public class ContactService {
	
	//private Logger logger = LoggerFactory.getLogger(ContactService.class);

	/**
	 * 注入DAO
	 */
	@Resource
	private ContactDao contactDao;
	@Resource
	private UserDao userDao;
	
	 /**
     * findPage(分页查询组件列表)
     * @param findPage
     * @param @return 参数类型
     * @return HibernatePage<Contact>返回类型
     * @throws NoSuchFieldException
     * 
     */
    @Transactional(readOnly = true)
    public HibernatePage<Contact> findPage(Map<String, Object> searchParams,
    		DataShift dataShift,
    		HibernatePage<Contact> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(Contact.class);
        criteria.add(Restrictions.eq("isDeleted", false));// 过滤已删除
        
        DataAuthFliter(criteria, searchParams, dataShift);
		
        return contactDao.findPage(page, criteria);
    }
    
    /**
     * export(导出联系人3000条)
     * @param searchParams 过滤条件
     * @param dataShift 数据筛选
     * @return List<Contact> 返回数据
     * @throws NoSuchFieldException
    */
   @Transactional
   public List<Contact> export(Map<String, Object> searchParams,
   		DataShift dataShift) throws NoSuchFieldException {
   		DetachedCriteria criteria = DetachedCriteria.forClass(Contact.class);
   		criteria.add(Restrictions.eq("isDeleted", false));
       
   		DataAuthFliter(criteria, searchParams, dataShift);
       
       	return contactDao.find(criteria, 3000);
   }
   
   /**
    * DataAuthFliter(数据级权限过滤)
    * @param criteria 
    * @param searchParams 过滤条件
    * @param dataShift 数据权限
    * @throws NoSuchFieldException
   */
   private void DataAuthFliter(DetachedCriteria criteria,
   		Map<String, Object> searchParams,
   		DataShift dataShift) throws NoSuchFieldException {
   	 	Map<String, SearchFilter> filters = Search.parse(searchParams);
   	 	userDao.visibleData(criteria, dataShift);
        Search.buildCriteria(filters, criteria, Contact.class);
   }
    

    /**
     * get(根据ID查询组件信息)
     * @param page
     * @param @return 参数类型
     * @return HibernatePage<contact>返回类型
     */
   	@Transactional(readOnly = true)
    public Contact get(long id) {
    	String hql = "select contact from Contact contact " +
    			"left join fetch contact.supplier " +
    			"left join fetch contact.customer " +
    			"left join fetch contact.owner " +
    			"left join fetch contact.source " +
    			"left join fetch contact.province " +
    			"left join fetch contact.city " +
    			"left join fetch contact.county " +
    			"where contact.id = ?";
    	
        return contactDao.findUnique(hql, id);
    }

    /**
     * getNameById
     * @Title: getNameById
     * @Description: 通过id获取名称
     * @param id
     * @return String
    */
   	@Transactional(readOnly = true)
    public String getNameById(Long id){
    	return contactDao.get(id).getName();
    }
    
    /**
     * save(保存：修改/新建)
     * @param entity 参数类型
     * @return void 返回类型
     * modifier:xiaoli.luo
     */
   	@Transactional
    public void add(Contact entity, User user, AuditLog auditLog) {
        contactDao.save(entity);
        auditLog.setRecordId(entity.getId());
    }
    /**
     *  modifier:xiaoli.luo
     * @param entity
     * @param userId
     */
   	@Transactional
    public void modify(Contact entity, User user, AuditLog auditLog) {
        contactDao.save(entity);
        auditLog.setRecordId(entity.getId());
    }

    /**
     * delete(删除联系人信息)
     * @param id 参数类型
     * @return void 返回类型
     */
   	@Transactional
    public void delete(User user, Long[] id, AuditLog [] auditLog) {
        contactDao.delete(id);
    }

    /**
     * 根据客户查找联系人
     * @param customer
     * @return
     */
   	@Transactional(readOnly = true)
	public List<Contact> findContactByCustomer(Customer customer) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Contact.class);
		criteria.setFetchMode("customer", FetchMode.JOIN);
   		criteria.add(Restrictions.eq("isDeleted", false));
   		criteria.add(Restrictions.eq("customer", customer));
		return contactDao.find(criteria);
	}
	
	 /**
     * 根据客户查找联系人
     * @param customer
     * @return
     */
   	@Transactional(readOnly = true)
	public List<Contact> findContactBySupplier(Supplier supplier) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Contact.class);
   		criteria.add(Restrictions.eq("isDeleted", false));
   		criteria.add(Restrictions.eq("supplier", supplier));
		return contactDao.find(criteria);
	}
}
