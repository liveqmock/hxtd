package com.baihui.hxtd.soa.project.service;

import java.util.Date;
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
import com.baihui.hxtd.soa.project.dao.ProductDao;
import com.baihui.hxtd.soa.project.entity.Product;
import com.baihui.hxtd.soa.project.entity.Project;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;

/**
 * 功能描述：产品(基金)模块service层
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.project.service.ProductService.java
 * @version (版本)1
 * @date 2014-5-16 下午04:48:19
 */
@Service
public class ProductService {
	//private Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 注入DAO
	 */
	@Resource
	private ProductDao productDao;
	//@Resource
	//private UserDao userDao;

	 /**
     * findPage(分页查询产品列表)
     * @param searchParams 过滤条件
     * @param page 分页
     * @return HibernatePage<Product> 列表结果集
	 * @throws NoSuchFieldException 
     */
    @Transactional(readOnly = true)
    public HibernatePage<Product> findPage(Map<String, Object> searchParams, 
    		HibernatePage<Product> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(Product.class);
        criteria.setFetchMode("type", FetchMode.JOIN);//产品分类
        criteria.setFetchMode("saleUnit", FetchMode.JOIN);//期限单位
        criteria.setFetchMode("project", FetchMode.JOIN);//项目
        criteria.setFetchMode("creator", FetchMode.JOIN);//创建者
        criteria.add(Restrictions.eq("isDeleted", false));// 过滤已删除
        
        //DataAuthFliter(criteria, searchParams, dataShift);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Product.class);
        
        return productDao.findPage(page, criteria);
    }
    
    /**
     * export(导出产品3000条)
     * @param searchParams 过滤条件
     * @param dataShift 数据筛选
     * @return List<Product> 返回数据
    */
   @Transactional(readOnly = true)
   public List<Product> export() {
   		DetachedCriteria criteria = DetachedCriteria.forClass(Product.class);
   		criteria.add(Restrictions.eq("isDeleted", false));
   		criteria.setFetchMode("type", FetchMode.JOIN);//产品分类
        criteria.setFetchMode("saleUnit", FetchMode.JOIN);//期限单位
        criteria.setFetchMode("project", FetchMode.JOIN);//项目
        criteria.setFetchMode("creator", FetchMode.JOIN);//创建者
       
   		//DataAuthFliter(criteria, searchParams, dataShift);
        //Map<String, SearchFilter> filters = Search.parse(searchParams);
        //Search.buildCriteria(filters, criteria, Product.class);
       
       	return productDao.find(criteria, 3000);
   }
   
   /**
    * DataAuthFliter(数据级权限过滤)
    * @param criteria 
    * @param searchParams 过滤条件
    * @param dataShift 数据权限
    * @throws NoSuchFieldException
   
   private void DataAuthFliter(DetachedCriteria criteria,
   		Map<String, Object> searchParams,
   		DataShift dataShift) throws NoSuchFieldException {
   	 	Map<String, SearchFilter> filters = Search.parse(searchParams);
   	 	//userDao.visibleData(criteria, dataShift);
        Search.buildCriteria(filters, criteria, Product.class);
   }*/
    
    /**
     * get(根据ID查询产品信息)
     * @param id 主键ID
     * @return Product 产品实体
     */
    @Transactional(readOnly = true)
    public Product get(Long id) {
        String hql = "select product from Product product " +
        				"left join fetch product.project " +
        				"left join fetch product.type " +
        				"left join fetch product.saleUnit" +
        				" where product.id = ?";
        
        return productDao.findUnique(hql, id);
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
	   return productDao.get(id).getName();
   }
    
    /**
     * save(保存：修改/新建)
     * @param entity 产品实体
     * @param user 操作用户
     * @param auditLog 审计日志
     */
    @Transactional
    public void add(Product entity, User user, AuditLog auditLog) {
        productDao.save(entity);
        auditLog.setRecordId(entity.getId());
    }
    
    /**
     * modify
     * @param entity 产品实体
     * @param user 操作用户
     * @param auditLog 审计日志
     */
    @Transactional
    public void modify(Product entity, User user, AuditLog auditLog) {
        productDao.save(entity);
    }
    
    /**
     * delete(根据产品主键ID删除记录，支持批量删除)
     * @param id 产品主键IDS
    */
   @Transactional
   public boolean delete(User user, Long[] ids, AuditLog[] auditLog) {
	   if(productDao.getOrdersCount(ids) == 0){
		   productDao.logicalDelete(ids);
		   return true;
	   } else {
		 return false;  
	   }
	   
   }
   
   @Transactional(readOnly = true)
   public List<Product> findProductByProject(Project project) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Product.class);
  		criteria.add(Restrictions.eq("isDeleted", false));
  		criteria.add(Restrictions.eq("project", project));
		return productDao.find(criteria);
	}

   @Transactional(readOnly = true)
   public Date getDBNow(){
	   return productDao.getDBNow();
   }
   
   @Transactional(readOnly = true)
   public Date getDBNowDate(){
	   return productDao.getDBNowDate();
   }
}
