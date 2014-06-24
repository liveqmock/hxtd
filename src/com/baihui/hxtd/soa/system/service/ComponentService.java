package com.baihui.hxtd.soa.system.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.system.dao.ComponentDao;
import com.baihui.hxtd.soa.system.entity.*;
import org.hibernate.FetchMode;
import org.hibernate.criterion.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 组件描述：组件表service层实现
 *
 * @author ruisong.luan
 * @version (版本) 1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.system.service.ComponentService.java
 * @date 2014-5-6 下午09:02:56
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Service
public class ComponentService {
    private Logger logger = LoggerFactory.getLogger(ComponentService.class);

    /**
     * 注入DAO
     */
    @Resource
    private ComponentDao componentDao;

    /**
     * 获得请求组件
     * 1.用户发起请求时，根据请求url唯一确定一个组件
     */
    @Transactional(readOnly = true)
    public Component getRequest(String url) {
        logger.info("获得请求的组件");
        logger.debug("url“{}”", url);
        String hql = "select component" +
                " from Component component" +
                " inner join fetch component.privilegeLevel" +
                " where component.url=?";
        return componentDao.findUnique(hql, url);
    }

    /**
     * 查找系统初始化时的组件
     * 1.排除已删除的
     */
    @Transactional(readOnly = true)
    public List<Component> findInit() {
        logger.info("查找系统初始化时的菜单");
        String hql = "select component from Component component" +
                " where component.isDeleted=false";
        return componentDao.find(hql);
    }

    /**
     * 查找有效组件主键编号
     */
    @Transactional(readOnly = true)
    public List<Long> findValidId(User user) {
        logger.info("查找有效组件主键编号");
        logger.debug("用户主键编号“{}”", user.getId());

        DetachedCriteria criteria = DetachedCriteria.forClass(Component.class, "rootComponent");
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        criteria.setProjection(Projections.id());

        logger.info("根据用户类型查找组件");
        if (!user.getIsManager()) {
            logger.debug("用户类型为“常规人员”，查找权限内组件");

            logger.debug("用户关联");
            DetachedCriteria userCriteria = DetachedCriteria.forClass(User.class, "user");
            userCriteria.setProjection(Projections.property("id"));
            userCriteria.add(Restrictions.eq("id", user.getId()));
            userCriteria.createAlias("components", "component");
            userCriteria.add(Restrictions.eqProperty("component.id", "rootComponent.id"));
            Criterion criterion = Subqueries.exists(userCriteria);

            logger.debug("用户角色关联");
            DetachedCriteria roleCriteria = DetachedCriteria.forClass(Role.class, "role");
            roleCriteria.setProjection(Projections.property("id"));
            roleCriteria.createAlias("owners", "owner");
            roleCriteria.add(Restrictions.eq("owner.id", user.getId()));
            roleCriteria.createAlias("components", "component");
            roleCriteria.add(Restrictions.eqProperty("component.id", "rootComponent.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(roleCriteria));

            logger.debug("用户组织角色关联");
            DetachedCriteria orgCriteria = DetachedCriteria.forClass(Organization.class, "org");
            orgCriteria.setProjection(Projections.property("id"));
            orgCriteria.createAlias("owners", "owner");
            orgCriteria.add(Restrictions.eq("owner.id", user.getId()));
            orgCriteria.createAlias("roles", "role");
            orgCriteria.createAlias("role.components", "component");
            orgCriteria.add(Restrictions.eqProperty("component.id", "rootComponent.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(orgCriteria));

            criteria.add(criterion);
        } else {
            logger.debug("用户类型为“管理员”，查找所有组件");
        }

        criteria.addOrder(Order.asc("id"));

        List<Long> components = componentDao.find(criteria);
        logger.info("数目“{}”", components.size());

        return components;
    }

    /**
     * 查找有效组件
     */
    @Transactional(readOnly = true)
    public List<Component> findValid(User user) {
        logger.info("查找有效组件");
        logger.debug("用户主键编号“{}”", user.getId());

        DetachedCriteria criteria = DetachedCriteria.forClass(Component.class, "rootComponent");
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);

        logger.info("根据用户类型查找组件");
        if (!user.getIsManager()) {
            logger.debug("用户类型为“常规人员”，查找权限内组件");

            logger.debug("用户关联");
            DetachedCriteria userCriteria = DetachedCriteria.forClass(User.class, "user");
            userCriteria.setProjection(Projections.property("id"));
            userCriteria.add(Restrictions.eq("id", user.getId()));
            userCriteria.createAlias("components", "component");
            userCriteria.add(Restrictions.eqProperty("component.id", "rootComponent.id"));
            Criterion criterion = Subqueries.exists(userCriteria);

            logger.debug("用户角色关联");
            DetachedCriteria roleCriteria = DetachedCriteria.forClass(Role.class, "role");
            roleCriteria.setProjection(Projections.property("id"));
            roleCriteria.createAlias("owners", "owner");
            roleCriteria.add(Restrictions.eq("owner.id", user.getId()));
            roleCriteria.createAlias("components", "component");
            roleCriteria.add(Restrictions.eqProperty("component.id", "rootComponent.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(roleCriteria));

            logger.debug("用户组织角色关联");
            DetachedCriteria orgCriteria = DetachedCriteria.forClass(Organization.class, "org");
            orgCriteria.setProjection(Projections.property("id"));
            orgCriteria.createAlias("owners", "owner");
            orgCriteria.add(Restrictions.eq("owner.id", user.getId()));
            orgCriteria.createAlias("roles", "role");
            orgCriteria.createAlias("role.components", "component");
            orgCriteria.add(Restrictions.eqProperty("component.id", "rootComponent.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(orgCriteria));

            criteria.add(criterion);
        } else {
            logger.debug("用户类型为“管理员”，查找所有组件");
        }

        criteria.addOrder(Order.asc("id"));

        List<Component> components = componentDao.find(criteria);
        logger.info("数目“{}”", components.size());

        return components;
    }

    /**
     * 查找用户授权组件
     */
    @Transactional(readOnly = true)
    public List<Component> findUserAuthorization(Long userId) {
        String hql = "select component" +
                " from Component component" +
                " inner join component.owners owner" +
                " where owner.id=?";
        return componentDao.find(hql, userId);
    }

    /**
     * 查找关联授权组件
     * 1.角色关联
     * 2.组织角色关联
     */
    @Transactional(readOnly = true)
    public List<Function> findReferAuthorization(Long userId) {
        String orgHql = "select role.id" +
                " from Role role" +
                " inner join role.organizations org" +
                " inner join org.owners owner" +
                " inner join role.components roleComponent" +
                " where component.id=roleComponent.id and owner.id=?";

        String roleHql = "select role.id" +
                " from Role role" +
                " inner join role.owners owner" +
                " inner join role.components roleComponent" +
                " where component.id=roleComponent.id and owner.id=? ";

        String hql = "select component" +
                " from Component component" +
                " where exists(" + orgHql + ")" +
                " or exists(" + roleHql + ")";
        return componentDao.find(hql, userId, userId);
    }

    /**
     * 查找角色授权组件
     */
    @Transactional(readOnly = true)
    public List<Function> findRoleAuthorization(Long roleId) {
        String hql = "select component" +
                " from Component component" +
                " inner join component.roles role" +
                " where role.id=?";
        return componentDao.find(hql, roleId);
    }

    /**
     * 查找组织授权组件
     */
    @Transactional(readOnly = true)
    public List<Function> findOrganizationAuthorization(Long organizationId) {
        String hql = "select component" +
                " from Component component" +
                " inner join component.roles role" +
                " inner join role.organizations org" +
                " where org.id=?";
        return componentDao.find(hql, organizationId);
    }

    /**
     * 查找组件通过主键编号集合
     */
    public List<Component> findById(List<Component> components, List<Long> ids) {
        List<Component> findComponents = new ArrayList<Component>();
        for (Component component : components) {
            if (ids.contains(component.getId())) {
                findComponents.add(component);
            }
        }
        return findComponents;
    }


    /**
     * findPage(分页查询组件列表)
     *
     * @param @param  findPage
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
     * @throws NoSuchFieldException
     * @throws
     * @Title: getAll
     */
    @Transactional(readOnly = true)
    public HibernatePage<Component> findPage(Map<String, Object> searchParams, HibernatePage<Component> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(Component.class);
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("privilegeLevel", FetchMode.JOIN);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Component.class);
        return componentDao.findPage(page, criteria);
    }

    /**
     * getl(根据ID查询组件信息)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
     * @throws
     */
    @Transactional(readOnly = true)
    public Component get(Long id) {
        logger.info("查询单个组件信息{}", id);
        DetachedCriteria criteria = DetachedCriteria.forClass(Component.class);
        criteria.setFetchMode("privilegeLevel", FetchMode.JOIN);
        criteria.add(Restrictions.idEq(id));
        return componentDao.findUnique(criteria);
    }

    /**
     * save(保存：修改/新建)
     *
     * @param @param entity    参数类型
     * @return void    返回类型
     * @throws
     * @Title: save
     */
    @Transactional
    public void save(Component entity) {
        logger.info("保存组件信息{}", entity);
        componentDao.save(entity);
    }

    /**
     * delete(删除组件信息)
     *
     * @param @param id    参数类型
     * @return void    返回类型
     * @throws
     * @Title: delete
     */
    @Transactional
    public void delete(long... id) {
        componentDao.delete(id);
    }


}
