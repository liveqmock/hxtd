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
import com.baihui.hxtd.soa.system.dao.MessageDao;
import com.baihui.hxtd.soa.system.dao.UserMessageDao;
import com.baihui.hxtd.soa.system.entity.Message;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.entity.UserMessage;
/**
 * 系统消息服务类
 *
 * @author huizijing
 * @date 2014/4/24
 */
@Service
@Transactional
public class MessageService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	private MessageDao messageDao;

	@Resource
	private UserMessageDao userMessageDao;
	private Integer exportCounts = 5000;
	
	/**
	 * 分页查找系统消息
	 * @param searchParams
	 * @param page
	 * @return HibernatePage<Message>
	 * @throws NoSuchFieldException
	 */
	@Transactional(readOnly = true)
	public HibernatePage<UserMessage> findRecivePage(Map<String, Object> searchParams,
			HibernatePage<UserMessage> page,User user) throws NoSuchFieldException {
		    logger.info("分页查找");
	        DetachedCriteria criteria = DetachedCriteria.forClass(UserMessage.class);
	        criteria.setFetchMode("message", FetchMode.JOIN);
            criteria.setFetchMode("message.creater",FetchMode.JOIN);
	        criteria.setFetchMode("user", FetchMode.JOIN);
	        searchParams.put("EQ_type", false);
	        searchParams.put("EQ_user", user);
	        searchParams.put("EQ_isDeleted", false);
	        Map<String, SearchFilter> filters = Search.parse(searchParams);
	        Search.buildCriteria(filters, criteria, UserMessage.class);
	        page=userMessageDao.findPage(page, criteria);
	        return page;
	}

	@Transactional(readOnly = true)
	public HibernatePage<UserMessage> findSendPage(Map<String, Object> searchParams,
			HibernatePage<UserMessage> page,User user) throws NoSuchFieldException {
		    logger.info("分页查找");
	        DetachedCriteria criteria = DetachedCriteria.forClass(UserMessage.class);
	        criteria.setFetchMode("message", FetchMode.JOIN);
            criteria.setFetchMode("message.creater",FetchMode.JOIN);
	        criteria.setFetchMode("user", FetchMode.JOIN);
	        searchParams.put("EQ_type", true);
	        searchParams.put("EQ_message.creater", user);
	        searchParams.put("EQ_isDeleted", false);
	        Map<String, SearchFilter> filters = Search.parse(searchParams);
	        Search.buildCriteria(filters, criteria, UserMessage.class);
	        page=userMessageDao.findPage(page, criteria);
	        return page;
	}
	
	
	/**
	 * 根据id获取系统消息
	 * @param id
	 * @return
	 */
	public UserMessage getById(Long id) {
		logger.info("getById得到系统消息信息{}", id);
		UserMessage userMessage=userMessageDao.getById(id);
		userMessage.setStatus(true);
		userMessageDao.saveUserMessage(userMessage);
		return userMessage;
	}

	/**
	 * 保存系统消息信息
	 * @param Message
	 * @param userId
	 */
	public Message save(Message message) {
		logger.info("保存系统消息信息{}", message);
		message.setCreatedTime(new Date());
		message.setModifiedTime(new Date());
		message.setIsDeleted(false);
		return messageDao.save(message);

	}


	/**
	 * 删除系统消息
	 * @param id
	 */
	public void delete(Long[] id) {
		userMessageDao.logicalDelete(id);

	}

	/**
	 * 保存消息关系表
	 * @param userMessage
	 */
	public void saveShip(Message message,User user) {
		UserMessage userMessage=new UserMessage();
		userMessage.setMessage(message);
		userMessage.setStatus(false);
		userMessage.setCreatedTime(new Date());
		userMessage.setUser(user);
		userMessage.setType(true);
		userMessage.setIsDeleted(false);
		userMessageDao.saveUserMessage(userMessage);
		UserMessage um=new UserMessage();
		um.setMessage(message);
		um.setStatus(false);
		um.setCreatedTime(new Date());
		um.setUser(user);
		um.setType(false);
		um.setIsDeleted(false);
		userMessageDao.saveUserMessage(um);

	}

	/**
	 * 查询已发信息
	 * @param searchParams
	 * @param page
	 * @param user
	 * @return HibernatePage<Message>
	 * @throws NoSuchFieldException 
	 */
	public HibernatePage<Message> findPageSend(Map<String, Object> searchParams,
			HibernatePage<Message> page, User user) throws NoSuchFieldException {
		    logger.info("分页查找");
	        DetachedCriteria criteria = DetachedCriteria.forClass(Message.class);
	        criteria.setFetchMode("creater", FetchMode.JOIN);
	        searchParams.put("EQ_creater", user);
	        searchParams.put("EQ_isDeleted", false);
	        Map<String, SearchFilter> filters = Search.parse(searchParams);
	        Search.buildCriteria(filters, criteria, Message.class);
	        page=messageDao.findPage(page, criteria);
	        return page;
	}

	/**
	 * 按条件导出
	 * @param searchParams
	 * @param ty
	 * @param user
	 * @return
	 * @throws NoSuchFieldException 
	 */
	public List<UserMessage> find(Map<String, Object> searchParams, String ty,
			User user) throws NoSuchFieldException {
		logger.info("查找");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserMessage.class);
        detachedCriteria.setFetchMode("message", FetchMode.JOIN);
        detachedCriteria.setFetchMode("message.creater",FetchMode.JOIN);
        detachedCriteria.setFetchMode("user", FetchMode.JOIN);
        detachedCriteria.add(Restrictions.eq("isDeleted", false));
        if("recived".equals(ty)){
        	
        	searchParams.put("EQ_type", false);
        	searchParams.put("EQ_user", user);
        }else{
        	searchParams.put("EQ_type", true);
	        searchParams.put("EQ_message.creater", user);
        }
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, detachedCriteria, UserMessage.class);

        detachedCriteria.addOrder(Order.asc("createdTime"));
        return userMessageDao.find(detachedCriteria, exportCounts);
	}

	/**
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<UserMessage> find() {
		logger.info("查找");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserMessage.class);
        detachedCriteria.setFetchMode("creater", FetchMode.JOIN);
        detachedCriteria.setFetchMode("modifier", FetchMode.JOIN);
        detachedCriteria.add(Restrictions.eq("isDeleted", false));

        Criteria criteria = detachedCriteria.getExecutableCriteria(userMessageDao.getSession());
        criteria.setMaxResults(exportCounts);
        return (List<UserMessage>) criteria.list();
	}



}
