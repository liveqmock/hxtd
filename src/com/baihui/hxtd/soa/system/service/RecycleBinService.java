package com.baihui.hxtd.soa.system.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.system.dao.RecycleBinDao;
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
	
	/**
	 * 保存方法
	 * @param recycleBin
	 */
	public void save(RecycleBin recycleBin){
		
	}
	
	/**
	  * @Title realDelete
	  * @Description 真实删除
	  * @param id    参数类型
	  * @return void    返回类型
	 */
	public void deleteReal(Long [] id){
		
	}
	
	/**
	  * @Title realDeleteBySetTime
	  * @Description 真实删除指定天数之前的数据，例如，删除线索模块30天之前isDelete=true的数据
	  * @param days    参数类型
	  * @return void    返回类型
	 */
	public void deleteRealBySetTime(int days){
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	/**
//	 * 注入DAO
//	 */
//	@Resource
//	private AuditLogDao auditLogDao;
//
//	 /**
//     * findPage(分页查询组件列表)
//     * @param findPage
//     * @param @return 参数类型
//     * @return HibernatePage<AuditLog>返回类型
//     * @throws NoSuchFieldException
//     */
//    @Transactional(readOnly = true)
//    public HibernatePage<AuditLog> findPage(Map<String, Object> searchParams, 
//    		HibernatePage<AuditLog> page) throws NoSuchFieldException {
//    	DetachedCriteria criteria = DetachedCriteria.forClass(AuditLog.class);
//    	criteria.setFetchMode("type", FetchMode.JOIN);
//    	criteria.setFetchMode("operator", FetchMode.JOIN);
//		Map<String, SearchFilter> filters = Search.parse(searchParams);// 构建参数
//		Search.buildCriteria(filters, criteria, AuditLog.class);
//        return auditLogDao.findPage(page, criteria);
//    }
//
//    /**
//     * get(根据ID查询组件信息)
//     * @param page
//     * @param @return 参数类型
//     * @return HibernatePage<AuditLog>返回类型
//     */
//    public Contact get(Long id) {
//    	String hql = "select contact from Contact contact " +
//    			"left join fetch contact.supplier " +
//    			"left join fetch contact.customer " +
//    			"left join fetch contact.owner " +
//    			"left join fetch contact.source " +
//    			"left join fetch contact.province " +
//    			"left join fetch contact.city " +
//    			"left join fetch contact.county " +
//    			"where contact.id = ?";
//    	
//        return auditLogDao.findUnique(hql, id);
//    }
//
//    /**
//     * 根据属性isDeleted删除
//     * @param id
//     */
//	public void delete(Long... id) {
//		auditLogDao.logicalDelete(id);
//		
//	}
}
