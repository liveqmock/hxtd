
package com.baihui.hxtd.soa.common.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.common.dao.PCASDao;
import com.baihui.hxtd.soa.common.entity.PCAS;

@Service
@Transactional
public class PCASService {
	@Resource
	private PCASDao pcasDao;
	
	/**
	 * 
	  * getRoot(查询根节点)
	  * @Title: getRoot
	  * @Description: 这里是查询所有的省份
	  * @param @return    参数类型
	  * @return List<PCAS>    返回类型
	  * @throws
	 */
	public List<PCAS> getRoot(){
		return pcasDao.getChildren(0l);
	}
	
	/**
	 * 
	  * getChildren(根据父节点查询子节点)
	  * @Title: getChildren
	  * @Description: 市，区/县
	  * @param @param pid
	  * @param @return    参数类型
	  * @return List<PCAS>    返回类型
	  * @throws
	 */
	public List<PCAS> getChildren(Long pid){
		return pcasDao.getChildren(pid);
	}

	public PCAS getByName(String name){
		return pcasDao.getByName(name);
	}
}
