package com.baihui.hxtd.soa.system.service;

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
import com.baihui.hxtd.soa.system.dao.AuditLogDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.util.EnumModule;
import com.baihui.hxtd.soa.util.EnumOperationType;
/**
 * 功能描述：审计日志模块service层
 * @author luoxiaoli
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.setting.service.AuditLogService.java
 * @version (版本)1
 * @date 2014-6-20 上午10:48:19
 */
@Service
@Transactional
public class AuditLogService {
	/**
	 * 注入DAO
	 */
	@Resource
	private AuditLogDao auditLogDao;
	
	@Resource
	private UserDao userDao;

	 /**
     * findPage(分页查询组件列表)
     * @param findPage
     * @param @return 参数类型
     * @return HibernatePage<AuditLog>返回类型
     * @throws NoSuchFieldException
     */
    @Transactional(readOnly = true)
    public HibernatePage<AuditLog> findPage(Map<String, Object> searchParams, 
    		HibernatePage<AuditLog> page,DataShift dataShift) throws NoSuchFieldException {
    	DetachedCriteria criteria = DetachedCriteria.forClass(AuditLog.class);
    	criteria.setFetchMode("type", FetchMode.JOIN);
    	criteria.setFetchMode("creator", FetchMode.JOIN);
    	userDao.priviData(criteria, dataShift.renameUserFieldName("creator"));
		Map<String, SearchFilter> filters = Search.parse(searchParams);// 构建参数
		Search.buildCriteria(filters, criteria, AuditLog.class);
        HibernatePage<AuditLog> pageResult=auditLogDao.findPage(page, criteria);
        List<AuditLog> result=pageResult.getResult();
        pageResult.setResult(convertResult(result));
        return pageResult;
    }
    
    /**
     * 枚举类型EnumModule转换成中文
     * @param result
     * @return List<AuditLog>
     */
	 private List<AuditLog> convertResult( List<AuditLog> result){
		 for(int i=0;i<result.size();i++){
			 String modelName=result.get(i).getModuleName().toUpperCase();
			 result.get(i).setModuleName(EnumModule.valueOf(modelName).getModuleChineseName());
         }
		return result;
		 
	 }
    /**
     * 根据属性isDeleted删除
     * @param id
     */
	public void delete(Long... id) {
		auditLogDao.logicalDelete(id);
		
	}
	
	public void save(AuditLog auditLog){
		
		//如果备注为null，设置默认的备注
		if(null==auditLog.getRemark() || "".equals(auditLog.getRemark())){
		auditLog.setRemark(EnumOperationType.values()[auditLog.getType()-1].getOperationChineseName() +
				EnumModule.valueOf(auditLog.getModuleName().toUpperCase()).getModuleChineseName());
		}
		auditLogDao.save(auditLog);
	}

	public void save(List<AuditLog> entities){
		auditLogDao.save(entities);
	}
	
}
