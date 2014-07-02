package com.baihui.hxtd.soa.customer.dao;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.customer.entity.Contact;

/**
 * 
 * 功能描述：联系人模块持久化层实现类
 * 
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.5
 * @ClassName: com.baihui.hxtd.soa.customer.dao.ContactDao.java
 * @version (版本) 1
 * @date 2014-5-16 下午04:07:53
 */
@Repository
public class ContactDao extends HibernateDAOImpl<Contact, Long> {

	// private Logger logger = LoggerFactory.getLogger(ContactDao.class);

	/**
	 * 
	 * get(根据ID查询联系人信息)
	 * 
	 * @param @param
	 * @param @return 参数类型
	 * @return HibernatePage<Contact> 返回类型
	 * @throws
	 */
	@Override
	public Contact get(Long id) {
		return super.get(id);
	}

	/**
	 * 
	 * save(保存：修改/新建)
	 * 
	 * @Title: save
	 * @param entity
	 *            参数类型
	 * @return void 返回类型
	 * @throws
	 */
	@Override
	public Contact save(Contact entity) {
		return super.save(entity);
	}

	/**
	 * delete(删除联系人)
	 * 
	 * @Title: delete
	 * @param @param id 参数类型
	 * @return void 返回类型
	 * @throws
	 */
	public void delete(Long... id) {
		for (int i = 0; i < id.length; i++) {
			super.logicalDelete(id[i]);
		}
	}

}
