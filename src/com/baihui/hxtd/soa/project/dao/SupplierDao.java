
package com.baihui.hxtd.soa.project.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	
	/**
	 * 
	  * getl(根据ID查询组件信息)
	  * @param @param 
	  * @param @return    参数类型
	  * @return HibernatePage<Component>    返回类型
	  * @throws
	 */
	@Override
	public Supplier get(Long id) {
		logger.info("根据ID查询组件信息");
		return super.get(id);
	}



	/**
	 * 
	  * save(保存：修改/新建)
	  * @Title: save
	  * @param @param entity    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	@Override
	public Supplier save(Supplier entity) {
		return super.save(entity);
	}

	/**
	  * delete(删除组件信息)
	  * @Title: delete
	  * @param @param id    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	public void delete(long... id) {
		for(int i=0;i<id.length;i++){
			super.delete(id[i]);
		}
	}
	
	
}
