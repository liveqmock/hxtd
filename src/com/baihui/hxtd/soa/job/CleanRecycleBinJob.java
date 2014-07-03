package com.baihui.hxtd.soa.job;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.baihui.hxtd.soa.common.service.CommonService;

/**
 * @ClassName: ClearRecycleBinJob
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

			CommonService service = (CommonService) sc.get("commonService");
			String kickOutTimeout = (String) sc.get("test.timeout");
			// TODO 调用回收站表，删除大于指定时间的数据
		} catch (Exception e) {
			log.error("excute DoctorExitQueueJob error occurs.", e);
			throw new JobExecutionException(e);
		}
	}
	
}
