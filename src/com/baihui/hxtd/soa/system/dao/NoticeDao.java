package com.baihui.hxtd.soa.system.dao;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.system.entity.Notice;
/**
 * 
 * 功能描述：公告表持久化层
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.system.dao.NoticeDao.java
 * @version (版本) 1.0
 * @date 2014-6-3
 */
@Repository
public class NoticeDao extends HibernateDAOImpl<Notice, Long>{

	/**
	 * 根据id得到公告
	 * @param id
	 * @return Notice
	 */
	public Notice getById(Long id) {
		StringBuffer hql=new StringBuffer("from Notice notice ");
        hql.append("left join fetch notice.creator ");
        hql.append("left join fetch notice.modifier ");
        hql.append("where notice.id=? ");
		return findUnique(hql.toString(), id);
	}

}
