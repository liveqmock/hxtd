
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
import com.baihui.hxtd.soa.project.dao.ProductDao;
import com.baihui.hxtd.soa.project.dao.ProjectDao;
import com.baihui.hxtd.soa.project.entity.Project;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.service.DataShift;
/**
 * 
 * 功能描述：项目模块业务层
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.project.service.ProjectService.java
 * @version (版本)1 
 * @date 2014-6-8 上午09:51:19
 */
@Service
@Transactional
public class ProjectService {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	/**
	 * DAO注入
	 */
	@Resource
	private ProjectDao projectDao;
	
	@Resource
	private ProductDao productDao;
	/**
	 * 
	  * findPage(分页查询)
	  * @Title: findPage
	  * @param @param searchParams
	  * @param @param page
	  * @param @throws NoSuchFieldException    参数类型
	  * @return HibernatePage<Project>    返回类型
	  * @throws
	 */
	@Transactional(readOnly = true)
    public HibernatePage<Project> findPage(Map<String, Object> searchParams, HibernatePage<Project> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(Project.class);
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("supplier", FetchMode.JOIN);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Project.class);
        return projectDao.findPage(page, criteria);
    }
	
	
	 /**
     * getl(根据ID查询信息)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
     * @throws
     */
    public Project get(Long id) {
        logger.info("查询单个信息{}", id);
        String hql = " select project from Project project  " +
        				" left join fetch project.supplier  " +
        				" left join fetch project.payType  " +
        				" where  project.id = ? ";
        return projectDao.findUnique(hql,id);
    }
    
    /**
     * 
      * save(新建或修改)
      * @Title: save
      * @param @param project    参数类型
      * @return void    返回类型
      * @throws
     */
	public void add(Project project,AuditLog auditLog){
    	projectDao.save(project);
    }
	
	public void modify(Project project,AuditLog auditLog){
    	projectDao.save(project);
    }
	
	/**
	  * delete(删除)
	  * @Title: delete
	  * @param @param id    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	public boolean delete(AuditLog[] auditLogArr,Long[] id){
		if(productDao.getCount(id)==0){
			projectDao.logicalDelete(id);
			return true;
		}else{
			return false;
		}
	}
	
	
	public List<Project> export(Map<String, Object> searchParams,DataShift dataShift) throws NoSuchFieldException{
		DetachedCriteria criteria = DetachedCriteria.forClass(Project.class);
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("supplier", FetchMode.JOIN);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Project.class);
        return projectDao.find(criteria,3000);
	}
	
	
}
