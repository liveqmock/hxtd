
package com.baihui.hxtd.soa.market.dao;

import org.springframework.stereotype.Repository;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.market.entity.MarketActivity;

/**
 * 功能描述：市场活动模块持久化层实现类
 * @author lihua
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.5
 * @ClassName: com.baihui.hxtd.soa.market.dao.MarketActivityDao.java
 * @version (版本) 1
 * @date 2014-5-16 下午04:07:53
 */
@Repository
public class MarketActivityDao extends HibernateDAOImpl<MarketActivity, Long>{
	
	//private Logger logger = LoggerFactory.getLogger(MarketActivityDao.class);
	/**
	 * get(根据ID查询市场活动信息)
	 * @param 主键ID
	 * @param id 参数类型
	 * @return HibernatePage<MarketActivity> 返回类型
	 * @throws
	 */
	@Override
	public MarketActivity get(Long id) {
		return super.get(id);
	}

	/**
	 * save(保存：修改/新建)
	 * @Title: save
	 * @param entity 参数类型
	 * @return void 返回类型
	 * @throws
	 */
	@Override
	public MarketActivity save(MarketActivity entity) {
		return super.save(entity);
	}

	/**
	 * delete(删除市场活动)
	 * @Title: delete
	 * @param id 参数类型
	 * @return void 返回类型
	 * @throws
	 */
	public void logicalDelete(Long... id) {
		for (int i = 0; i < id.length; i++) {
			super.logicalDelete(id[i]);
		}
	}
}
