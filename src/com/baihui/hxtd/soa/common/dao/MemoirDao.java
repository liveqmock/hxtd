
package com.baihui.hxtd.soa.common.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.Memoir;
import com.baihui.hxtd.soa.customer.entity.Contact;
import com.baihui.hxtd.soa.customer.entity.Lead;
/**
 * 
 * 功能描述：联系纪要持久化层
 * @author lihua 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.dao.MemoirDao.java
 * @version (版本)1 
 * @date 2014-5-26 上午11:15:52
 */
@Repository
public class MemoirDao extends HibernateDAOImpl<Memoir, Long> {
	/**
	 * delete(删除联系纪要)
	 * @Title: delete
	 * @param id 参数类型
	 * @return void 返回类型
	 * @throws
	 */
	public void delete(long... id) {
		for (int i = 0; i < id.length; i++) {
			super.logicalDelete(id[i]);
		}
	}
	
	public void leadConverter(Lead l,Contact c){
		String hql = "update Memoir m set m.moduleId=? , m.type = 11010104 " +
				"where m.type=11010103 and m.moduleId=?";
		Query query = createQuery(hql);
		query.setParameter(0, c.getId());
		query.setParameter(1, l.getId());
		query.executeUpdate();
	}
	
	
}
