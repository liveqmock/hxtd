
package com.baihui.hxtd.soa.sales.service;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.sales.dao.SalesTargetDao;
import com.baihui.hxtd.soa.sales.entity.SalesTarget;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;

@Service
@Transactional
public class SalesTargetService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private SalesTargetDao salesTargetDao;
	@Resource
	private UserDao userDao;
	 /**
     * findPage(分页查询供应商列表)
     *
     * @param @param  findPage
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
	 * @throws NoSuchFieldException 
     * @throws
     * @Title: getAll
     */
    @Transactional(readOnly = true)
    public HibernatePage<SalesTarget> findPage(Map<String, Object> searchParams,DataShift dataShift, HibernatePage<SalesTarget> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(SalesTarget.class);
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("owner", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        userDao.visibleData(criteria, dataShift);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, SalesTarget.class);
        return salesTargetDao.findPage(page, criteria);
    }
    
    
    /**
     * getl(根据ID查询供应商信息)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
     * @throws
     */
    public SalesTarget get(Long id) {
        logger.info("查询单个供应商信息{}", id);
        String hql = "select entity from SalesTarget entity  " +
        				"left join fetch entity.owner where entity.id = ?";
        return salesTargetDao.findUnique(hql,id);
    }
	
	public void add(SalesTarget entity,String[] owners,AuditLog [] auditLogArr){
		setDBTime(entity);
		SalesTarget salesTmp = null;
		for(int i=0;i<owners.length;i++){
			salesTmp = new SalesTarget();
			BeanUtils.copyProperties(entity, salesTmp);
			salesTmp.setOwner(new User(Long.valueOf(owners[i])));
			salesTargetDao.save(salesTmp);
			auditLogArr[i].setRecordId(salesTmp.getId());
		}
	}
	
	public void modify(SalesTarget entity,AuditLog auditLog){
		setDBTime(entity);
		salesTargetDao.save(entity);
	}
	
	public void delete(Long[] id,AuditLog[] auditLogArr){
		salesTargetDao.delete(id);
	}
	
	private void setDBTime(SalesTarget entity){
		Date now = salesTargetDao.getDBNow();
		entity.setCreatedTime(now);
		entity.setModifiedTime(now);
	}
}
