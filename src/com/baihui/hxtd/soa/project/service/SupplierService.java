package com.baihui.hxtd.soa.project.service;

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
import com.baihui.hxtd.soa.project.dao.ProjectDao;
import com.baihui.hxtd.soa.project.dao.SupplierDao;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.service.DataShift;

/**
 * 功能描述：供应商模块service层
 * @author ruisong.luan
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.customer.service.SupplierService.java
 * @version (版本)1
 * @date 2014-5-16 下午04:48:19
 */
@Service
@Transactional
public class SupplierService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 注入DAO
	 */
	@Resource
	private SupplierDao supplierDao;
	
	@Resource
	private ProjectDao projectDao;

	@Resource
	private UserDao userDao;
	 /**
     * findPage(分页查询组件列表)
     *
     * @param @param  findPage
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
	 * @throws NoSuchFieldException 
     * @throws
     * @Title: getAll
     */
    @Transactional(readOnly = true)
    public HibernatePage<Supplier> findPage(Map<String, Object> searchParams,DataShift dataShift, HibernatePage<Supplier> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(Supplier.class);
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("type", FetchMode.JOIN);
        criteria.setFetchMode("owner", FetchMode.JOIN);
        userDao.visibleData(criteria, dataShift);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Supplier.class);
        return supplierDao.findPage(page, criteria);
    }
    
    
    /**
     * getl(根据ID查询组件信息)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
     * @throws
     */
    public Supplier get(Long id) {
        logger.info("查询单个组件信息{}", id);
        String hql = "select supplier from Supplier supplier  " +
        				"left join fetch supplier.type " +
        				"left join fetch supplier.owner " +
        				"left join fetch supplier.cardType " +
        				"left join fetch supplier.province " +
        				"left join fetch supplier.city " +
        				"left join fetch supplier.county where supplier.id = ?";
        return supplierDao.findUnique(hql,id);
    }

    /**
     * save(保存：修改/新建)
     *
     * @param @param entity    参数类型
     * @return void    返回类型
     * @throws
     * @Title: save
     */
    public void add(Supplier entity,AuditLog auditLog) {
        logger.info("保存组件信息{}", entity);
        supplierDao.save(entity);
    }
    
    public void modify(Supplier entity,AuditLog auditLog) {
        logger.info("保存组件信息{}", entity);
        supplierDao.save(entity);
    }

    /**
     * delete(删除组件信息)
     *
     * @param @param id    参数类型
     * @return void    返回类型
     * @throws
     * @Title: delete
     */
    public boolean delete(AuditLog[] auditLogArr, Long[] id) {
    	if(projectDao.getCount(id)==0){
    		supplierDao.logicalDelete(id);
    		return true;
    	}
    	return false;
    }

    public List<Supplier> export(Map<String, Object> searchParams,DataShift dataShift) throws NoSuchFieldException {
    	DetachedCriteria criteria = DetachedCriteria.forClass(Supplier.class);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("owner", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("type", FetchMode.JOIN);
        criteria.setFetchMode("province", FetchMode.JOIN);
        criteria.setFetchMode("city", FetchMode.JOIN);
        criteria.setFetchMode("county", FetchMode.JOIN);
        userDao.visibleData(criteria, dataShift);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Supplier.class);
        return supplierDao.find(criteria,3000);
    }

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public SupplierDao getSupplierDao() {
		return supplierDao;
	}

	public void setSupplierDao(SupplierDao supplierDao) {
		this.supplierDao = supplierDao;
	}

}
