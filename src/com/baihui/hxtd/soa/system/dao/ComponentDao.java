
package com.baihui.hxtd.soa.system.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.system.entity.Component;
/**
 * 
 * 功能描述：组件表持久化层
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.system.dao.ComponentDao.java
 * @version (版本) 1
 * @date 2014-5-6 下午07:19:30
 */
@Repository
public class ComponentDao extends HibernateDAOImpl<Component, Long>{
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/**
	 * 
	  * getAll(分页查询组件)
	  * @param @param page
	  * @param @return    参数类型
	  * @return HibernatePage<Component>    返回类型
	  * @throws
	 */
	@Override
	public HibernatePage<Component> getAll(HibernatePage<Component> page) {
		logger.info("查询列表信息");
		return super.getAll(page);
	}
	
	
	/**
	 * 
	  * getl(根据ID查询组件信息)
	  * @param @param page
	  * @param @return    参数类型
	  * @return HibernatePage<Component>    返回类型
	  * @throws
	 */
	@Override
	public Component get(Long id) {
		// TODO Auto-generated method stub
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
	public Component save(Component entity) {
		return super.save(entity);
	}

	/**
	 * 
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
