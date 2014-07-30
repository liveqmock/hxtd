package com.baihui.hxtd.soa.system.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.baihui.hxtd.soa.common.dao.CommonDao;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.customer.service.LeadService;
import com.baihui.hxtd.soa.system.dao.RecycleBinDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.RecycleBin;
import com.baihui.hxtd.soa.util.CommonCalendar;
import com.baihui.hxtd.soa.util.EnumModule;
/**
 * 功能描述：审计日志模块service层
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.setting.service.AuditLogService.java
 * @version (版本)1
 * @date 2014-7-7 上午11:41:19
 */
@Service
@Transactional(readOnly = true)
public class RecycleBinService {
	
	private Logger logger = LoggerFactory.getLogger(RecycleBinService.class);
	
	@Resource
	private RecycleBinDao recycleBinDao;
	
	@Resource
	private CommonDao commonDao;
	
	@Resource
	private UserDao userDao;
	
	private Integer exportCounts = 5000;
	
	/**
	 * 分页查找数据
	 * @param searchParams
	 * @param page
	 * @return HibernatePage<RecycleBin>
	 * @throws NoSuchFieldException 
	 */
	public HibernatePage<RecycleBin> findPage(Map<String, Object> searchParams,
			HibernatePage<RecycleBin> page,DataShift dataShift) throws NoSuchFieldException {
		DetachedCriteria criteria = DetachedCriteria.forClass(RecycleBin.class);
    	criteria.setFetchMode("creator", FetchMode.JOIN);
    	userDao.priviData(criteria, dataShift.renameUserFieldName("creator"));
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		Search.buildCriteria(filters, criteria, RecycleBin.class);
		HibernatePage<RecycleBin> pageResult=recycleBinDao.findPage(page, criteria);
        List<RecycleBin> result=pageResult.getResult();
        pageResult.setResult(convertResult(result));
        return pageResult;
	}
	
	/**
     * 枚举类型EnumModule转换成中文
     * @param result
     * @return List<RecycleBin>
     */
	 private List<RecycleBin> convertResult( List<RecycleBin> result){
		 for(int i=0;i<result.size();i++){
			 String modelName=result.get(i).getModuleName().toUpperCase();
			 result.get(i).setModuleName(EnumModule.valueOf(modelName).getModuleChineseName());
         }
		return result;
	 }

	/**
	 * 保存方法
	 * @param recycleBin
	 */
	@Transactional(readOnly = false)
	public void save(RecycleBin recycleBin){
		if(recycleBin.getRemark()==null||("").equals(recycleBin.getRemark())){
			recycleBin.setRemark("删除"+EnumModule.valueOf(recycleBin.getModuleName().toUpperCase()).getModuleChineseName());
		}
		recycleBinDao.save(recycleBin);
	}
	
	/**
	 * @Title realDelete
	 * @Description 真实删除
	 * @param id    参数类型
	 * @return void    返回类型
	 */
	@Transactional(readOnly = false)
	public void realDelete(String entityName, Long[] recordid, AuditLog [] auditLogArr){
		commonDao.delete(entityName, recordid);
	}
	
	/**
	 * @Title realDeleteBySetTime
	 * @Description 真实删除指定天数之前的数据，例如，删除线索模块30天之前isDelete=true的数据
	 * @param days    参数类型
	 * @return void    返回类型
	 */
	@Transactional(readOnly = false)
	public void deleteRealBySetTime(int days, AuditLog auditLogArr){
		int pageSize = 200;
		HibernatePage<RecycleBin> page = new HibernatePage<RecycleBin>(pageSize);
		while (page.isHasNext()) {
			Date bigenDelteDate = CommonCalendar.date2Offset(recycleBinDao.getDBNow(), Calendar.DATE, CommonCalendar.MODE_AHEAD, days);
			// 查需要删除的数据
			String hql = "select recycleBin.id, recycleBin.moduleName, recycleBin.recordId from RecycleBin recycleBin where CREATED_TIME<? order by recycleBin.moduleName";
			recycleBinDao.findPage(page, hql, bigenDelteDate);
			// 执行realDelete
			List<RecycleBin> recycleBinList = page.getResult();
			if(recycleBinList != null && !recycleBinList.isEmpty() ){
				int recycleBinListLength = recycleBinList.size();
				List<Long> idList = new ArrayList<Long>();
				if(recycleBinListLength == 1){
					RecycleBin recycleBin = recycleBinList.get(0);
					realDelete(recycleBin.getModuleName(), new Long []{recycleBin.getRecordId()}, null);
				}
				for(int i=1; i<recycleBinListLength; i++){
					List<Long> recordIdList = new ArrayList<Long>();
					RecycleBin beforRecycleBin = recycleBinList.get(i-1);
					idList.add(beforRecycleBin.getId());
					recordIdList.add(beforRecycleBin.getRecordId());
					RecycleBin recycleBin = recycleBinList.get(i);
						
					if(!beforRecycleBin.getModuleName().equals(recycleBin.getModuleName())){
						realDelete(beforRecycleBin.getModuleName(), (Long[])recordIdList.toArray(), null);
					}
					if( i == recycleBinListLength -1){
						idList.add(recycleBin.getId());
						if(beforRecycleBin.getModuleName().equals(recycleBin.getModuleName())){
							recordIdList.add(recycleBin.getRecordId());
							realDelete(beforRecycleBin.getModuleName(), (Long[])recordIdList.toArray(), null);
						}else{
							realDelete(beforRecycleBin.getModuleName(), new Long [] {recycleBin.getRecordId()}, null);
						}
					}
				}
				delete((Long [] )idList.toArray());
			}
		}
		
	}

	/**
	 * 还原数据
	 * @param array
	 * @param string
	 */
	@Transactional(readOnly = false)
	public void recovery(Long[] id, String entityName,AuditLog [] auditLogArr) {
		commonDao.recovery(entityName, id);
		 
	}

	@Transactional(readOnly = false)
	public void delete(Long[] id){
		recycleBinDao.delete(id);
	}
	
	/**
	 * 根据id数组得到回收站实体类List
	 * @param id
	 * @return
	 */
	public List<RecycleBin> getByIds(Long[] id) {
		List<Long> ids=new ArrayList<Long>();
		for(int i=0;i<id.length;i++){
			ids.add(id[i]);
		}
		return recycleBinDao.get(ids);
	}

	/**
	 * 分页查找回收站数据
	 * @param searchParams
	 * @return
	 * @throws NoSuchFieldException 
	 */
	public List<RecycleBin> find(Map<String, Object> searchParams) throws NoSuchFieldException {
		logger.info("分页查找回收站数据");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(RecycleBin.class);
        detachedCriteria.setFetchMode("creator", FetchMode.JOIN);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, detachedCriteria, RecycleBin.class);
        List<RecycleBin> recycleBins=recycleBinDao.find(detachedCriteria, exportCounts);
        for (int i = 0; i < recycleBins.size(); i++) {
        	recycleBins.get(i).setModuleName(EnumModule.valueOf(recycleBins.get(i).getModuleName())
        			.getModuleChineseName());
		}
        return recycleBins;
	}

}
