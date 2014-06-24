package com.baihui.hxtd.soa.system.dao;


import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.system.entity.Menu;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * 菜单数据访问类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Repository
public class MenuDao extends HibernateDAOImpl<Menu, Long> {

    /**
     * queryByPage(分页获取菜单列表)
     */
    public HibernatePage<Menu> queryByPage(HibernatePage<Menu> page, Long id) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Menu.class);
        criteria.setFetchMode("parent", FetchMode.JOIN);
        if (0 != id) {
            criteria.createAlias("parent", "p");
            criteria.add(Restrictions.eq("p.id", id));
            //criteria.setFetchMode("children", FetchMode.JOIN);
        }
        return super.findPage(page, criteria);
    }

    /**
     * 获取默认显示根据主键编号
     */
    public Boolean getDefaultShow(Long id) {
        String hql = "select menu.defaultShow from Menu menu where menu.id=?";
        return findUnique(hql, id);
    }

    /**
     * 更新默认显示的菜单为不默认显示
     */
    public int updateToNotDefaultShow() {
        String hql = "update Menu menu set menu.defaultShow=false where menu.defaultShow=true";
        return batchExecute(hql);
    }


}
