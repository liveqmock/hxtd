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
import com.baihui.hxtd.soa.system.entity.AuditLog;
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

	 /**
     * findPage(分页查询组件列表)
     * @param findPage
     * @param @return 参数类型
     * @return HibernatePage<AuditLog>返回类型
     * @throws NoSuchFieldException
     */
    @Transactional(readOnly = true)
    public HibernatePage<AuditLog> findPage(Map<String, Object> searchParams, 
    		HibernatePage<AuditLog> page) throws NoSuchFieldException {
    	DetachedCriteria criteria = DetachedCriteria.forClass(AuditLog.class);
    	criteria.setFetchMode("type", FetchMode.JOIN);
    	criteria.setFetchMode("creator", FetchMode.JOIN);
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
        	 if(result.get(i).getModuleName().equals("marketActivity")){
        		 result.get(i).setModuleName("市场活动");
        	 }
        	 if(result.get(i).getModuleName().equals("lead")){
        		 result.get(i).setModuleName("线索");
        	 }
        	 if(result.get(i).getModuleName().equals("contact")){
        		 result.get(i).setModuleName("联系人");
        	 }
        	 if(result.get(i).getModuleName().equals("customer")){
        		 result.get(i).setModuleName("客户");
        	 }
        	 if(result.get(i).getModuleName().equals("supplier")){
        		 result.get(i).setModuleName("供应商");
        	 }
        	 if(result.get(i).getModuleName().equals("project")){
        		 result.get(i).setModuleName("项目");
        	 }
        	 if(result.get(i).getModuleName().equals("product")){
        		 result.get(i).setModuleName("产品");
        	 }
        	 if(result.get(i).getModuleName().equals("order")){
        		 result.get(i).setModuleName("订单");
        	 }
        	 if(result.get(i).getModuleName().equals("user")){
        		 result.get(i).setModuleName("用户");
        	 }
        	 if(result.get(i).getModuleName().equals("role")){
        		 result.get(i).setModuleName("角色");
        	 }
        	 if(result.get(i).getModuleName().equals("menu")){
        		 result.get(i).setModuleName("菜单");
        	 }
        	 if(result.get(i).getModuleName().equals("function")){
        		 result.get(i).setModuleName("功能");
        	 }
        	 if(result.get(i).getModuleName().equals("component")){
        		 result.get(i).setModuleName("组件");
        	 }
        	 if(result.get(i).getModuleName().equals("organization")){
        		 result.get(i).setModuleName("组织机构");
        	 }
        	 if(result.get(i).getModuleName().equals("userMessage")){
        		 result.get(i).setModuleName("系统消息");
        	 }
        	 if(result.get(i).getModuleName().equals("notice")){
        		 result.get(i).setModuleName("系统公告");
        	 }
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
		auditLogDao.save(auditLog);
	}
	
	public void save(List<AuditLog> entities){
		auditLogDao.save(entities);
	}
}
