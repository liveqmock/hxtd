package com.baihui.hxtd.soa.common.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.common.entity.Common;

import org.apache.poi.ss.formula.functions.T;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springside.modules.persistence.SearchFilter;


@Repository
@SuppressWarnings("unchecked")
public class CommonDao extends HibernateDAOImpl<Common, Long> {

    /**
     * 获取实体通过主键编号
     */
    public <T> T get(String entityName, Long id) {
        String hql = String.format("select entity from %s entity where entity.id=?", entityName);
        return (T) createQuery(hql, id).uniqueResult();
    }

    /**
     * 获取序号通过主键编号
     */
    public Long getOrderById(String entityName, Long id) {
        String hql = String.format("select entity.order from %s entity where entity.id=?", entityName);
        return findUnique(hql, id);
    }

    /**
     * 更新序号根据主键编号
     */
    public int updateOrderById(String entityName, Long id, Long order) {
        String hql = String.format("update %s entity set entity.order=? where id=?", entityName);
        return createQuery(hql, order, id).executeUpdate();
    }

    /**
     * 增长序号根据序号范围
     * //TODO 不能设置order的唯一约束
     */
    public int increaseOrderByOrderRange(String entityName, long orderMin, long orderMax, long increase) {
        String hql = String.format("update %s entity set entity.order=entity.order+? where entity.order between ? and ?", entityName);
        return createQuery(hql, increase, orderMin, orderMax).executeUpdate();
    }

    /**
     * 增长级别根据序号范围
     */
    public int increaseLevelByOrderRange(String entityName, long orderMin, long orderMax, int increase) {
        String hql = String.format("update %s entity set entity.level=entity.level+? where entity.order between ? and ?", entityName);
        return createQuery(hql, increase, orderMin, orderMax).executeUpdate();
    }

    /**
     * 更新父节点通过唯一编号
     */
    public int updateParentById(String entityName, Long id, Long parentId) {
        String hql = String.format("update %s entity set entity.parent.id=? where entity.id=?", entityName);
        return createQuery(hql, parentId, id).executeUpdate();
    }

    /**
     * 更新是否叶子节点通过唯一编号
     */
    public int updateIsLeafById(String entityName, Long id, boolean isLeaf) {
        String hql = String.format("update %s entity set entity.isLeaf=? where entity.id=?", entityName);
        return createQuery(hql, isLeaf, id).executeUpdate();
    }
    
    /**
     * 查询已删除的数据
     */
    public  HibernatePage<T> getDeletedDate(HibernatePage<T> page, String entityName, String recordName,Long deletorId, Date gteModifiedTime, Date lteModifiedTime) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    	
    	String hql = String.format("select entity from %s entity inner join fetch entity.modifier where entity.isDeleted=true ", entityName);
    	List<Object> listParams = new ArrayList<Object>();
        //删除者
        if(null != deletorId){
        	hql += " and entity.modifier.id = ?";
        	listParams.add(Long.valueOf(deletorId));
        }
      //记录名称
        if(null != recordName && !recordName.isEmpty()){
        	hql += " and entity.name = ?";
        	listParams.add(recordName);
        }
      //大于删除时间
        if(null != gteModifiedTime){
			hql += " and entity.modifiedTime>?";
			listParams.add(gteModifiedTime);
			
        }
      //小于删除时间
        if(null != gteModifiedTime){
			hql += " and entity.modifiedTime<?";
			listParams.add(gteModifiedTime);
        }
        Object[] o = listParams.toArray();
        page.setResult(createQuery(hql, o).list());
        return page;
    }

}
