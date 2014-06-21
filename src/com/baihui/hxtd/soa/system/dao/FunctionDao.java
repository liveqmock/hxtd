package com.baihui.hxtd.soa.system.dao;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.system.entity.Function;

import java.util.Collection;
import java.util.Date;

/**
 * 功能数据访问类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Repository
public class FunctionDao extends HibernateDAOImpl<Function, Long> {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 *
	  * getAll(分页查询组件)
	  * @param @param page
	  * @param @return    参数类型
	  * @return HibernatePage<Function>    返回类型
	  * @throws
	 */
	@Override
	public HibernatePage<Function> getAll(HibernatePage<Function> page) {
		logger.info("查询列表");
		return super.getAll(page);
	}


	/**
	 *
	  * getl(根据ID查询组件信息)
	  * @param @param page
	  * @param @return    参数类型
	  * @return HibernatePage<Function>    返回类型
	  * @throws
	 */
	@Override
	public Function get(Long id) {
		// TODO Auto-generated method stub
		return super.get(id);
	}



	/**
	 *
	  * save(保存：修改/新建)
	  * @Title: save
	  * @param @param entity    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	@Override
	public Function save(Function entity) {
		return super.save(entity);
	}

    /**新增*/
    public void add(Function function){
        function.setCode("");
        function.setCreateTime(new Date());
        function.setModifiedTime(function.getCreateTime());
        function.setIsDeleted(false);
        save(function);
    }

    /**新增*/
    public void add(Collection<Function> functions){
        for (Function function: functions){
            add(function);
        }
    }

	/**
	 *
	  * delete(删除组件信息)
	  * @Title: delete
	  * @param @param id    参数类型
	  * @return void    返回类型
	  * @throws
	 */
	public void delete(long... id) {
		for(int i=0;i<id.length;i++){
			super.delete(id[i]);
		}
	}

}
