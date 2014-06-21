
package com.baihui.hxtd.soa.common.dao;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.Attachment;
/**
 * 
 * 功能描述：附件持久化层
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.dao.AttachmentDao.java
 * @version (版本)1 
 * @date 2014-5-26 上午11:15:52
 */
@Repository
public class AttachmentDao extends HibernateDAOImpl<Attachment, Long> {
	
	
	/**
	 * 根据id查询附件
	 * @param id
	 * @return
	 */
	public Attachment getById(Long id) {
		StringBuffer hql=new StringBuffer("from Attachment attachment ");
        hql.append("left join fetch attachment.creator ");
        hql.append("left join fetch attachment.modifier ");
        hql.append("where attachment.id=? ");
		return findUnique(hql.toString(), id);
	}

}
