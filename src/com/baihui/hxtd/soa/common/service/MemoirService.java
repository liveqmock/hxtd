
package com.baihui.hxtd.soa.common.service;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.common.dao.MemoirDao;
import com.baihui.hxtd.soa.common.entity.Memoir;
/**
 * 
 * 功能描述：联系纪要service层
 * @author lihua 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.service.AttachmentService.java
 * @version (版本)1 
 * @date 2014-5-26 上午11:16:20
 */
@Service
@Transactional
public class MemoirService {
	
	//private Logger logger = LoggerFactory.getLogger(MemoirService.class);
	
	@Resource
	private MemoirDao memoirDao;
	
	/**
	  * findPage(查询模块相关联系纪要)
	  * @Description: 查询模块相关联系纪要
	  * @param moduleId 模块主键id
	  * @param moduleType 模块
	  * @param page 分页数据集
	  * @throws
	 */
	public void findPage(Long moduleId, Long moduleType, HibernatePage<Memoir> page){
		DetachedCriteria criteria = DetachedCriteria.forClass(Memoir.class);
		criteria.setFetchMode("employee", FetchMode.JOIN);
		
		criteria.add(Restrictions.eq("moduleId", moduleId));
		criteria.createAlias("type", "dic");
        criteria.add(Restrictions.eq("dic.id", moduleType));
        
        criteria.add(Restrictions.eq("isDeleted", false));// 过滤已删除
		
        memoirDao.findPage(page, criteria);
	}
	
	public void save(Memoir att){
		memoirDao.save(att);
	}
	/**
     * get(根据ID查询联系纪要)
     * @param id 联系纪要主键ID
     * @return MarketActivity 联系纪要实体
     */
    public Memoir get(Long id) {
    	String hql = "select memoir from Memoir memoir where memoir.id = ?";
        return memoirDao.findUnique(hql, id);
    }
	/**
     * delete(删除联系纪要)
     * @Description: 根据联系纪要主键ID删除记录
     * @param id 联系纪要主键ID
    */
   public void delete(long... id) {
	   memoirDao.delete(id);
   }
	
	public Memoir view(Long id){
		return memoirDao.get(id);
	}
	
}
