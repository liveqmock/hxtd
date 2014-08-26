package com.baihui.hxtd.soa.system.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.system.dao.NoticeDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Notice;
import com.baihui.hxtd.soa.system.entity.User;

/**
 * 公告服务类
 *
 * @author huizijing
 * @date 2014/4/24
 */
@Service
@Transactional
public class NoticeService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	private NoticeDao noticeDao;
	
	private Integer exportCounts = 5000;
	/**
	 * 分页查找公告
	 * @param searchParams
	 * @param page
	 * @return HibernatePage<Notice>
	 * @throws NoSuchFieldException 
	 */
	@Transactional(readOnly = true)
	public HibernatePage<Notice> findPage(Map<String, Object> searchParams,
			HibernatePage<Notice> page,String type) throws NoSuchFieldException {
		    logger.info("分页查找");
	        DetachedCriteria criteria = DetachedCriteria.forClass(Notice.class);
	        criteria.setFetchMode("creator", FetchMode.JOIN);
	        criteria.setFetchMode("modifier", FetchMode.JOIN);
	        Date now = noticeDao.getDBNow();
	        if("all".equals(type)){
	        	//查看所有信息
	        	searchParams.put("GTE_deadTime", now);
	        }else if("unsend".equals(type)){
	        	//未发送且未过期
	        	searchParams.put("GTE_sentTime", now);
	        	searchParams.put("GTE_deadTime", now);
	        }
	        else if("sended".equals(type)){
	        	if(!searchParams.containsKey("GTE_sentTime")&&
	        			!searchParams.containsKey("LTE_sentTime")){
	        		searchParams.put("LTE_sentTime", now);
	        	}
	        	//默认查未过期且已发送的公告
        		searchParams.put("GTE_deadTime", now);
	        }
	        else if("dead".equals(type)){
	        	searchParams.put("LTE_deadTime", now);
	        }
	        searchParams.put("EQ_isDeleted", false);
	        Map<String, SearchFilter> filters = Search.parse(searchParams);
	        Search.buildCriteria(filters, criteria, Notice.class);
	        return noticeDao.findPage(page, criteria);
	}

	/**
	 * 根据id获取公告
	 * @param id
	 * @return
	 */
	public Notice getById(Long id) {
		logger.info("getById得到公告信息{}", id);
		return noticeDao.getById(id);
	}

	/**
	 * 保存公告信息
	 * @param notice
	 */
	public void add(Notice notice, User user,AuditLog auditLog) {
		logger.info("保存公告信息{}", notice);
		notice.setIsDeleted(false);
		notice.setCreatedTime(noticeDao.getDBNow());
		notice.setModifieTime(noticeDao.getDBNow());
		noticeDao.save(notice);
		auditLog.setRecordId(notice.getId());
	}
	
	public void modify(Notice notice, User user,AuditLog auditLog) {
		logger.info("修改公告信息{}", notice);
		notice.setModifieTime(noticeDao.getDBNow());
		notice.setIsDeleted(false);
		noticeDao.save(notice);
		
	}


	/**
	 * 删除公告
	 * @param id
	 */
	public void delete(User user, Long[] id, AuditLog [] auditLog) {
		noticeDao.logicalDelete(id);
		
	}

	/**
     * 新增
     */
   /* @Transactional
    public void add(List<Notice> notices) {
        logger.info("批量新增");
        for (Notice notice : notices) {
            add(notice);
        }
    }*/

	 /**
     * 新增
     */
    /*@Transactional
    public void add(Notice notice) {
        logger.info("添加默认属性值");
        notice.setIsDeleted(false);
        notice.setCreatedTime(new Date());
        logger.debug("创建时间为当前时间“{}”", notice.getCreatedTime());
        notice.setModifieTime(notice.getCreatedTime());
        logger.debug("修改时间为当前时间“{}”", notice.getModifieTime());
        logger.debug("是否删除的为“{}”", notice.getIsDeleted());
        noticeDao.save(notice);
    }*/

    /**
     * 导出全部
     * @return
     */
	@SuppressWarnings("unchecked")
	public List<Notice> find(){
	    logger.info("查找");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Notice.class);
        detachedCriteria.setFetchMode("creator", FetchMode.JOIN);
        detachedCriteria.setFetchMode("modifier", FetchMode.JOIN);
        detachedCriteria.add(Restrictions.eq("isDeleted", false));

        Criteria criteria = detachedCriteria.getExecutableCriteria(noticeDao.getSession());
        criteria.setMaxResults(exportCounts);
        return (List<Notice>) criteria.list();
	}

	/**
	 * 按条件查找，不分页
	 * @param searchParams
	 * @return List<Notice>
	 * @throws NoSuchFieldException 
	 */
	public List<Notice> find(Map<String, Object> searchParams) throws NoSuchFieldException {
		logger.info("查找");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Notice.class);
        detachedCriteria.setFetchMode("creator", FetchMode.JOIN);
        detachedCriteria.setFetchMode("modifier", FetchMode.JOIN);
        detachedCriteria.add(Restrictions.eq("isDeleted", false));

        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, detachedCriteria, Notice.class);

        detachedCriteria.addOrder(Order.asc("sentTime"));
        return noticeDao.find(detachedCriteria, exportCounts);
	}

	/**
      * getTitleById
      * @Title: getTitleById
      * @Description: 通过id获取名称
      * @param id
      * @return String
     */
    public String getTitleById(Long id){
    	return noticeDao.get(id).getTitle();
    }
}
