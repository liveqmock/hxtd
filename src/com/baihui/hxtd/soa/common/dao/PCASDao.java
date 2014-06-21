
package com.baihui.hxtd.soa.common.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.PCAS;
/**
 * 
 * 功能描述：三级联动持久化层
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.dao.PCASDao.java
 * @version (版本)1 
 * @date 2014-5-30 下午01:42:39
 */
@Repository
public class PCASDao extends HibernateDAOImpl<PCAS, Long> {

	/**
	 * 
	  * getChildren(根据父节点查询所有的子节点)
	  * @Title: getChildren
	  * @param @param pid
	  * @param @return    参数类型
	  * @return List<PCAS>    返回类型
	  * @throws
	 */
	public List<PCAS> getChildren(Long pid){
		String hql = "select pcas from PCAS pcas where pcas.pid = ?";
		return find(hql,pid);
	}
	
}
