
package com.baihui.hxtd.soa.common.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.dao.AttachmentDao;
import com.baihui.hxtd.soa.common.entity.Attachment;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
/**
 * 
 * 功能描述：附件表service层
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.service.AttachmentService.java
 * @version (版本)1 
 * @date 2014-5-26 上午11:16:20
 */
@Service
@Transactional
public class AttachmentService {
	
	private Logger logger = LoggerFactory.getLogger(AttachmentService.class);
	
	@Resource
	private AttachmentDao attachementDao;
	/**
	 * 
	  * query(查询信息相关的附件)
	  * @Title: query
	  * @param @return    参数类型
	  * @return List<Attachment>    返回类型
	  * @throws
	 */
	public List<Attachment> query(Long moduleId,Long recordId){
		logger.info("附件模块列表查询moduleId={},type={}",moduleId,recordId);
		DetachedCriteria criteria = DetachedCriteria.forClass(Attachment.class);
		criteria.add(Restrictions.eq("module.id", moduleId));
		criteria.add(Restrictions.eq("recordId", recordId));
		criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("dict", FetchMode.JOIN);
        criteria.setFetchMode("type", FetchMode.JOIN);
        return attachementDao.find(criteria);
	}
	/**
	 * 
	  * view(预览附件)
	  * @Title: view
	  * @Description: TODO//待实现
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	public Attachment view(Long id){
		return attachementDao.get(id);
	}
	/**
	 * 
	  * save2DB(保存附件信息到数据库)
	  * @Title: save2DB
	  * @param @param att    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	public void add(Attachment att,User user, AuditLog auditLog){
		attachementDao.save(att);
	}
	
	/**
	 * 分页查询附件列表
	 * @param searchParams
	 * @param page
	 * @author huizijing
	 * @return HibernatePage<Attachment>
	 * @throws NoSuchFieldException 
	 */
	public HibernatePage<Attachment> findPage(Map<String, Object> searchParams,
			HibernatePage<Attachment> page) throws NoSuchFieldException {
		logger.info("分页查找");
        DetachedCriteria criteria = DetachedCriteria.forClass(Attachment.class);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        searchParams.put("EQ_isDeleted", false);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria,Attachment.class);
        return attachementDao.findPage(page, criteria);
	}
	
	
	/**
	 * 根据id查询附件
	 * @param id
	 * @return
	 */
	public Attachment getById(Long id) {
		logger.info("getById得到公告信息{}", id);
		return attachementDao.getById(id);
	}
	
	/**
	 * 
	  * delete(删除的方法)
	  * @Title: delete
	  * @param @param id    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	public void delete(User user, Long[] id, AuditLog[] auditLog){
		for(int i=0;i<id.length;i++){
			Attachment att = this.getById(id[i]);
			File f = new File(att.getAddress());
			if(f.delete()){
				attachementDao.logicalDelete(id[i]);
			}
		}
		
	}
	
	
}
