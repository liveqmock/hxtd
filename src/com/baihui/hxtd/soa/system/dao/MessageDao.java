package com.baihui.hxtd.soa.system.dao;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.system.entity.Message;
import com.baihui.hxtd.soa.system.entity.UserMessage;
/**
 * 
 * 功能描述：系统消息表持久化层
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.system.dao.MessageDao.java
 * @version (版本) 1.0
 * @date 2014-6-3
 */
@Repository
public class MessageDao extends HibernateDAOImpl<Message, Long>{

	/**
	 * 根据id得到系统消息
	 * @param id
	 * @return Message
	 */
	public Message getById(Long id) {
		StringBuffer hql=new StringBuffer("from Message message ");
        hql.append("left join fetch message.creater ");
        hql.append("left join fetch message.modifier ");
        hql.append("where message.id=? ");
		return findUnique(hql.toString(), id);
	}

}
