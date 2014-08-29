package com.baihui.hxtd.soa.job;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.baihui.hxtd.soa.base.DBDateServiceInjecter;
import com.baihui.hxtd.soa.system.entity.Message;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.MessageService;
import com.baihui.hxtd.soa.system.service.RecycleBinService;
import com.baihui.hxtd.soa.system.service.UserMessageService;
import com.baihui.hxtd.soa.system.service.UserService;

/**
 * @ClassName: CleanRecycleBinJob
 * @Description: 定时清理回收站数据
 * @author Comsys-jason
 * @date 2014-6-30 上午11:33:28
 */

public class CleanRecycleBinJob extends QuartzJobBean  {

	/** log */
	private Logger log = LoggerFactory.getLogger(getClass());  

	@Override
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException {
		// 回收站数据提醒上限
		Long limit = 100000L;
		try {
			log.info("excute CleanRecycleBinJob.");

			SchedulerContext sc = context.getScheduler().getContext();

			RecycleBinService recycleBinService = (RecycleBinService) sc.get("recycleBinService");
			
			
			
			Long recycleBinCount = recycleBinService.getAccount();
			if(recycleBinCount == null || recycleBinCount < limit){
				return;
			}
			MessageService messageService = (MessageService)sc.get("messageService");
			
			UserMessageService userMessageService = (UserMessageService)sc.get("userMessageService");
			
			UserService userService = (UserService)sc.get("userService");
			User superManager = userService.findSupermanager();
			// send msg for admin
			sendMsg2User(recycleBinCount, messageService, userMessageService, superManager);
		} catch (Exception e) {
			log.error("excute DoctorExitQueueJob error occurs.", e);
			throw new JobExecutionException(e);
		}
	}
	
	private void sendMsg2User(Long recycleBinCount, MessageService messageService, UserMessageService userMessageService, User superManager){
		Message message = new Message();
		String title = String.format("清除回收站数据提醒");
		message.setTitle(title);
        String content = String.format("回收站记录已经到达%s条,请系统管理员及时清除回收站数据", recycleBinCount);
        message.setContent(content);
        message.setCreator(null);
        message.setCreatedTime(DBDateServiceInjecter.nowDate());
        message.setModifier(null);
        message.setIsDeleted(false);
        messageService.addMessage(message);
    	userMessageService.add(message, superManager);
	}
	
}
