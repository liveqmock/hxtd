package com.baihui.hxtd.soa.system.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.dao.CommonDao;
import com.baihui.hxtd.soa.system.dao.RecycleBinDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.RecycleBin;
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
@Transactional
public class RecycleBinService {
	
	@Resource
	private RecycleBinDao recycleBinDao;
	
	@Resource
	private CommonDao commonDao;
	
	/**
	 * 分页查找数据
	 * @param searchParams
	 * @param page
	 * @return HibernatePage<RecycleBin>
	 * @throws NoSuchFieldException 
	 */
	public HibernatePage<RecycleBin> findPage(Map<String, Object> searchParams,
			HibernatePage<RecycleBin> page) throws NoSuchFieldException {
		DetachedCriteria criteria = DetachedCriteria.forClass(RecycleBin.class);
    	criteria.setFetchMode("creator", FetchMode.JOIN);
		Map<String, SearchFilter> filters = Search.parse(searchParams);
		Search.buildCriteria(filters, criteria, RecycleBin.class);
//		HibernatePage<RecycleBin> pageResult=recycleBinDao.findPage(page, criteria);
//		List<RecycleBin> result=pageResult.getResult();
//        pageResult.setResult(convertResult(result));
        return recycleBinDao.findPage(page, criteria);
	}
	
	/**
	 * 保存方法
	 * @param recycleBin
	 */
	public void save(RecycleBin recycleBin){
		recycleBinDao.save(recycleBin);
	}
	
	/**
	  * @Title realDelete
	  * @Description 真实删除
	  * @param id    参数类型
	  * @return void    返回类型
	 */
	public void realDelete(Long[] recordid,String entityName,AuditLog [] auditLogArr){
		commonDao.delete(entityName, recordid);
	}
	
	/**
	  * @Title realDeleteBySetTime
	  * @Description 真实删除指定天数之前的数据，例如，删除线索模块30天之前isDelete=true的数据
	  * @param days    参数类型
	  * @return void    返回类型
	 */
	public void deleteRealBySetTime(int days){
		
	}

	/**
	 * 还原数据
	 * @param array
	 * @param string
	 */
	public void recovery(Long[] id, String entityName,AuditLog [] auditLogArr) {
		commonDao.recovery(entityName, id);
		 
	}

	public void delete(Long[] id){
		recycleBinDao.delete(id);
	}
	/**
	 * 根据id数组得到回收站实体类List
	 * @param id
	 * @return
	 */
	public List<RecycleBin> getByIds(long[] id) {
		List<Long> ids=new ArrayList<Long>();
		for(int i=0;i<id.length;i++){
			ids.add(id[i]);
		}
		return recycleBinDao.get(ids);
	}

}
