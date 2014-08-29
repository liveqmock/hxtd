package com.baihui.hxtd.soa.job;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.baihui.hxtd.soa.base.DBDateServiceInjecter;
import com.baihui.hxtd.soa.common.service.WarningService;
import com.baihui.hxtd.soa.system.entity.Message;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.MessageService;
import com.baihui.hxtd.soa.system.service.UserMessageService;
import com.baihui.hxtd.soa.util.CommonCalendar;
import com.baihui.hxtd.soa.util.Tools;

/**
 * @ClassName: CleanRecycleBinJob
 * @Description: 到期提醒-订单 任务
 * @author Comsys-jason
 * @date 2014-6-30 上午11:33:28
 */

public class ReminderOrderJob extends QuartzJobBean  {

	/** log */
	private Logger log = LoggerFactory.getLogger(getClass());  

	@SuppressWarnings("unchecked")
	@Override
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException {

		try {
			log.info("excute ReminderOrderJob.");

			SchedulerContext sc = context.getScheduler().getContext();
			
			WarningService warningService = (WarningService)sc.get("warningService");
			
			MessageService messageService = (MessageService)sc.get("messageService");
			
			UserMessageService userMessageService = (UserMessageService)sc.get("userMessageService");
			
			int beforeDay = 7;
			for(int i=0; i<3; i++){
				if(i==1){
					beforeDay = 15;
				}else if(i == 2){
					beforeDay = 30;
				}
				Date orderEndDate = CommonCalendar.date2Offset(DBDateServiceInjecter.nowDate(), Calendar.DATE, CommonCalendar.MODE_BEHIND, beforeDay);
				orderEndDate = DateUtils.truncate(orderEndDate, Calendar.DATE);
				String orderEndDateStr = Tools.fomatDate(CommonCalendar.FORMAT_YMD2, orderEndDate);
				List list = warningService.findNomarlOrderByEndDate(orderEndDate);
				if(list == null || list.isEmpty()){
					continue;
				}
				int listSize = list.size();
				for(int j=0; j<listSize; j++){
					Object [] objectArr = (Object [])list.get(j);
					User [] orderManagerArr =  {(User)objectArr[2], (User)objectArr[3], (User)objectArr[4],};
					sendMsg2User((Long)objectArr[0], (String)objectArr[1], beforeDay, orderEndDateStr, orderManagerArr, messageService, userMessageService);
				}
			}
		} catch (Exception e) {
			log.error("excute DoctorExitQueueJob error occurs.", e);
			throw new JobExecutionException(e);
		}
	}
	
	private void sendMsg2User(Long id, String code, int beforeDay, String orderEndDateStr, User [] orderManagerArr, 
			MessageService messageService, UserMessageService userMessageService){
		Message message = new Message();
		
        String title = String.format("订单%s只有%s天到期(%s)", code, beforeDay, orderEndDateStr);
        String url = String.format("<a href='../../order/order/toViewPage.do?id=%s'>订单%s</a>", id, code);
        message.setTitle(title);
        String content = String.format("%s只有%s天到期(%s)", url, beforeDay, orderEndDateStr)+", 特发此系统消息提醒您及时跟进客户.";
        message.setContent(content);
        message.setCreator(null);
        message.setCreatedTime(DBDateServiceInjecter.nowDate());
        message.setModifier(null);
        message.setIsDeleted(false);
        messageService.addMessage(message);
        for(User msgUser : orderManagerArr){
        	userMessageService.add(message, msgUser);
        }
	}
	
}
