package com.baihui.hxtd.soa.system.dao;


import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.system.entity.Component;
import com.baihui.hxtd.soa.system.entity.Menu;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 菜单数据访问类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Repository
public class MenuDao extends HibernateDAOImpl<Menu, Long> {

    /**
     * 查找树形的菜单
     * 1.以树结构返回，即包含一级菜单，二级菜单放在children中
     */
    @SuppressWarnings("unchecked")
    public List<Menu> findTree() {
        Criteria criteria = createCriteria(Restrictions.eq("level", 1));
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        criteria.setFetchMode("children", FetchMode.JOIN);
//        criteria.createCriteria("children").setFetchMode("showLocation",FetchMode.SELECT);
        criteria.addOrder(Order.asc("order"));
        return (List<Menu>) criteria.list();
    }

    /**
     * queryByPage(分页获取菜单列表)
     */
	public HibernatePage<Menu> queryByPage(HibernatePage<Menu> page, Long id) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Menu.class);
		criteria.setFetchMode("parent", FetchMode.JOIN);
		if( 0 != id){
			criteria.createAlias("parent", "p");
			criteria.add(Restrictions.eq("p.id", id));
			//criteria.setFetchMode("children", FetchMode.JOIN);
		}
		return super.findPage(page,criteria);
	}
	/**
	 * 
	  * createMenuId(自动生成菜单编号)
	  * @Title: createMenuId
	  * @Description: TODO
	  * @param @param pId
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	public String createMenuId(Long pId){
		if(null != pId && pId > 0){
			//super.find("from Menu where pr", values)
		}
		return "";
	}

}
