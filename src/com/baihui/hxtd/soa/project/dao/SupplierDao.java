
package com.baihui.hxtd.soa.project.dao;


import java.util.Date;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.project.entity.Supplier;
/**
 * 
 * 功能描述：供应商模块持久化层实现类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.customer.dao.SupplierDao.java
 * @version (版本) 1
 * @date 2014-5-16 下午04:07:53
 */
@Repository
public class SupplierDao extends HibernateDAOImpl<Supplier, Long> {
	
	/**
	  *重写save方法，针对于处理一下参数 
	  * @param supplier
	  * @return
	  * @see com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl#save(java.lang.Object)
	 */
	public Supplier save(Supplier supplier){
		Date now = getDBNow();
		supplier.setCreatedTime(now);
		supplier.setModifiedTime(now);
        if(supplier.getProvince()!=null&&supplier.getProvince().getId()==null){
        	supplier.setProvince(null);
        }
        if(supplier.getCity()!=null&&supplier.getCity().getId()==null){
        	supplier.setCity(null);
        }
        if(supplier.getCounty()!=null&&supplier.getCounty().getId()==null){
        	supplier.setCounty(null);
        }
		return super.save(supplier);
	}
}
