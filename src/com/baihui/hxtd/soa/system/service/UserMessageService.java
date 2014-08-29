package com.baihui.hxtd.soa.system.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.system.dao.UserMessageDao;
import com.baihui.hxtd.soa.system.entity.Message;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.entity.UserMessage;
/**
 * 系统消息服务类
 * @author huizijing
 * @date 2014/4/24
 */
@Service
public class UserMessageService {

	@Resource
	private UserMessageDao userMessageDao;
	
	@Transactional
	public void add(Message message,User user) {
		UserMessage userMessage=new UserMessage();
		userMessage.setMessage(message);
		userMessage.setStatus(false);
		userMessage.setCreatedTime(userMessageDao.getDBNow());
		userMessage.setUser(user);
		userMessage.setType(true);
		userMessage.setIsDeleted(false);
		userMessageDao.saveUserMessage(userMessage);
		UserMessage um=new UserMessage();
		um.setMessage(message);
		um.setStatus(false);
		um.setCreatedTime(userMessageDao.getDBNow());
		um.setUser(user);
		um.setType(false);
		um.setIsDeleted(false);
		userMessageDao.saveUserMessage(um);
	}
}
