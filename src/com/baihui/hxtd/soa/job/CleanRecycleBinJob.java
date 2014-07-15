package com.baihui.hxtd.soa.job;

import java.util.Calendar;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.baihui.hxtd.soa.common.service.CommonService;
import com.baihui.hxtd.soa.util.CommonCalendar;

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

		try {
			log.info("excute DoctorExitQueueJob.");

			SchedulerContext sc = context.getScheduler().getContext();

			CommonService commonService = (CommonService) sc.get("commonService");
			
			int clearTimeout = (Integer) sc.get("test.timeout");
			CommonCalendar.date2Offset(commonService.getNow(), Calendar.DATE, CommonCalendar.MODE_AHEAD, clearTimeout);
			// TODO 调用回收站表，删除大于指定时间的数据
//			deleteRealBySetTime
		} catch (Exception e) {
			log.error("excute DoctorExitQueueJob error occurs.", e);
			throw new JobExecutionException(e);
		}
	}
	
}
