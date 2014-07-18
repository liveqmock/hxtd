package com.baihui.hxtd.soa.system.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.system.dao.WorkbanchDao;
import com.baihui.hxtd.soa.system.entity.Workbanch;

@Service
@Transactional
public class WorkbanchService {

	@Resource
	private WorkbanchDao workbanchDao;
	
	/**
	 * 查询当前用户的工作台
	 * @param ownerId
	 * @return
	 */
	public List<Workbanch> getMyWorkbanchs(Long ownerId){
		String hql = "select work from Workbanch work where " +
				 "work.owner=? and work.isDeleted=false " +
				 "order by work.orderIndex asc";
		return workbanchDao.find(hql, ownerId);
	}
	
	/**
	 * 记忆工作台位置
	 * @param ids
	 */
	public void modifyOrder(Long[] ids){
		workbanchDao.modifyOrder(ids);
	}
	/**
	 * 删除工作台
	 * @param id
	 */
	public void delete(Long[] id){
		workbanchDao.logicalDelete(id);
	}
	/**
	 * 添加工作台
	 * @param workbanch
	 */
	public void add(Workbanch workbanch,Long ownerId){
		setDBTime(workbanch);
		workbanch.setWidth(workbanch.getWidth()+"%");
		workbanch.setOwner(ownerId);
		Long order = getOrderIndex(ownerId);
		workbanch.setOrderIndex(order==null?0:order);
		workbanchDao.save(workbanch);
	}
	
	private Long getOrderIndex(Long ownerId){
		String hql = "select max(work.orderIndex) from Workbanch work where " +
				 "work.owner=? and work.isDeleted=false ";
		return workbanchDao.findUnique(hql, ownerId);
	}
	
	
	private void setDBTime(Workbanch work){
		Date now = workbanchDao.getDBNow();
		work.setCreatedTime(now);
		work.setModifiedTime(now);
	}
}
