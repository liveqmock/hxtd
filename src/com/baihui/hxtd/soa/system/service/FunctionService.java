package com.baihui.hxtd.soa.system.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.system.dao.FunctionDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;
import org.hibernate.FetchMode;
import org.hibernate.criterion.*;
import org.hibernate.sql.JoinType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.util.*;

/**
 * 功能服务类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Service
public class FunctionService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private FunctionDao functionDao;

    @Resource
    private UserDao userDao;

    /**
     * 获得请求功能
     * 1.用户发起请求时，根据请求url唯一确定一个功能
     */
    @Transactional(readOnly = true)
    public Function getRequest(String url) {
        logger.info("获得请求功能");
        logger.debug("url“{}”", url);
        DetachedCriteria criteria = DetachedCriteria.forClass(Function.class);
        criteria.createAlias("menu", "menu", JoinType.LEFT_OUTER_JOIN);
        criteria.createAlias("menu.parent", "parentMenu", JoinType.LEFT_OUTER_JOIN);
        criteria.setFetchMode("privilegeLevel", FetchMode.JOIN);
        criteria.setFetchMode("menu", FetchMode.JOIN);
        criteria.setFetchMode("menu.trigger", FetchMode.JOIN);
        criteria.setFetchMode("parentMenu", FetchMode.JOIN);
        criteria.setFetchMode("parentMenu.trigger", FetchMode.JOIN);
        criteria.add(Restrictions.like("url", url + ".", MatchMode.START));
        return functionDao.findUnique(criteria);
    }


    /**
     * 查找系统初始化时的功能
     * 1.排除已删除的
     * 2.排除未关联到菜单的（基础模板的）
     */
    @Transactional(readOnly = true)
    public List<Function> findInit() {
        logger.info("查找系统初始化时的菜单");
        String hql = "select function from Function function" +
                " inner join fetch function.menu" +
                " inner join fetch function.privilegeLevel" +
                " left join fetch function.parent" +
                " where function.isDeleted=false";
        return functionDao.find(hql);
    }

    /**
     * 查找基本功能
     */
    @Transactional(readOnly = true)
    public List<Function> findBase() {
        logger.info("查找基本功能");
        String hql = "select function from Function function" +
                " where function.menu=null";
        return functionDao.find(hql);
    }

    /**
     * 查找有效的功能主键编号
     */
    @Transactional(readOnly = true)
    public List<Long> findValidId(User user) {
        logger.info("查找有效的功能主键编号");
        logger.debug("用户主键编号“{}”", user.getId());

        DetachedCriteria criteria = DetachedCriteria.forClass(Function.class, "rootFunction");
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        criteria.setProjection(Projections.id());
//        criteria.setFetchMode("menu", FetchMode.JOIN);
//        criteria.setFetchMode("parent", FetchMode.JOIN);

        logger.info("根据用户类型查找功能");
        if (!user.getIsManager()) {
            logger.debug("用户类型为“常规人员”，查找权限内功能");

            logger.debug("用户关联");
            DetachedCriteria userCriteria = DetachedCriteria.forClass(User.class, "user");
            userCriteria.setProjection(Projections.property("id"));
            userCriteria.add(Restrictions.eq("id", user.getId()));
            userCriteria.createAlias("functions", "function");
            userCriteria.add(Restrictions.eqProperty("function.id", "rootFunction.id"));
            Criterion criterion = Subqueries.exists(userCriteria);

            logger.debug("用户角色关联");
            DetachedCriteria roleCriteria = DetachedCriteria.forClass(Role.class, "role");
            roleCriteria.setProjection(Projections.property("id"));
            roleCriteria.createAlias("owners", "owner");
            roleCriteria.add(Restrictions.eq("owner.id", user.getId()));
            roleCriteria.createAlias("functions", "function");
            roleCriteria.add(Restrictions.eqProperty("function.id", "rootFunction.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(roleCriteria));

            logger.debug("用户组织角色关联");
            DetachedCriteria orgCriteria = DetachedCriteria.forClass(Organization.class, "org");
            orgCriteria.setProjection(Projections.property("id"));
            orgCriteria.createAlias("owners", "owner");
            orgCriteria.add(Restrictions.eq("owner.id", user.getId()));
            orgCriteria.createAlias("roles", "role");
            orgCriteria.createAlias("role.functions", "function");
            orgCriteria.add(Restrictions.eqProperty("function.id", "rootFunction.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(orgCriteria));

            criteria.add(criterion);
        } else {
            logger.debug("用户类型为“管理员”，查找所有功能");
        }

        criteria.addOrder(Order.asc("id"));

        List<Long> functions = functionDao.find(criteria);
        logger.info("功能主键编号数目“{}”", functions.size());

        return functions;
    }

    /**
     * 查找有效功能
     */
    @Transactional(readOnly = true)
    public List<Function> findValid(User user) {
        logger.info("查找有效功能");
        logger.debug("用户主键编号“{}”", user.getId());

        DetachedCriteria criteria = DetachedCriteria.forClass(Function.class, "rootFunction");
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        criteria.setFetchMode("menu", FetchMode.JOIN);
        criteria.setFetchMode("parent", FetchMode.JOIN);

        logger.info("根据用户类型查找功能");
        if (!user.getIsManager()) {
            logger.debug("用户类型为“常规人员”，查找权限内功能");

            logger.debug("用户关联");
            DetachedCriteria userCriteria = DetachedCriteria.forClass(User.class, "user");
            userCriteria.setProjection(Projections.property("id"));
            userCriteria.add(Restrictions.eq("id", user.getId()));
            userCriteria.createAlias("functions", "function");
            userCriteria.add(Restrictions.eqProperty("function.id", "rootFunction.id"));
            Criterion criterion = Subqueries.exists(userCriteria);

            logger.debug("用户角色关联");
            DetachedCriteria roleCriteria = DetachedCriteria.forClass(Role.class, "role");
            roleCriteria.setProjection(Projections.property("id"));
            roleCriteria.createAlias("owners", "owner");
            roleCriteria.add(Restrictions.eq("owner.id", user.getId()));
            roleCriteria.createAlias("functions", "function");
            roleCriteria.add(Restrictions.eqProperty("function.id", "rootFunction.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(roleCriteria));

            logger.debug("用户组织角色关联");
            DetachedCriteria orgCriteria = DetachedCriteria.forClass(Organization.class, "org");
            orgCriteria.setProjection(Projections.property("id"));
            orgCriteria.createAlias("owners", "owner");
            orgCriteria.add(Restrictions.eq("owner.id", user.getId()));
            orgCriteria.createAlias("roles", "role");
            orgCriteria.createAlias("role.functions", "function");
            orgCriteria.add(Restrictions.eqProperty("function.id", "rootFunction.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(orgCriteria));

            criteria.add(criterion);
        } else {
            logger.debug("用户类型为“管理员”，查找所有功能");
        }

        criteria.addOrder(Order.asc("id"));

        List<Function> functions = functionDao.find(criteria);
        logger.info("数目“{}”", functions.size());

        return functions;
    }

    /**
     * 查找用户授权功能
     */
    @Transactional(readOnly = true)
    public List<Function> findUserAuthorization(Long userId) {
        String hql = "select function" +
                " from Function function" +
                " inner join function.owners owner" +
                " where owner.id=?";
        return functionDao.find(hql, userId);
    }

    /**
     * 查找关联授权功能
     * 1.角色关联
     * 2.组织角色关联
     */
    @Transactional(readOnly = true)
    public List<Function> findReferAuthorization(Long userId) {
        String orgHql = "select role.id" +
                " from Role role" +
                " inner join role.organizations org" +
                " inner join org.owners owner" +
                " inner join role.functions roleFunction" +
                " where function.id=roleFunction.id and owner.id=?";

        String roleHql = "select role.id" +
                " from Role role" +
                " inner join role.owners owner" +
                " inner join role.functions roleFunction" +
                " where function.id=roleFunction.id and owner.id=?";

        String hql = "select function" +
                " from Function function" +
                " where exists(" + orgHql + ")" +
                " or exists(" + roleHql + ")";
        return functionDao.find(hql, userId, userId);
    }

    /**
     * 查找角色授权功能
     */
    @Transactional(readOnly = true)
    public List<Function> findRoleAuthorization(Long roleId) {
        String hql = "select function" +
                " from Function function" +
                " inner join function.roles role" +
                " where role.id=?";
        return functionDao.find(hql, roleId);
    }

    /**
     * 查找组织授权功能
     */
    @Transactional(readOnly = true)
    public List<Function> findOrganizationAuthorization(Long organizationId) {
        String hql = "select function" +
                " from Function function" +
                " inner join function.roles role" +
                " inner join role.organizations org" +
                " where org.id=?";
        return functionDao.find(hql, organizationId);
    }

    /**
     * 按菜单主键编号分组
     * 1.以菜单主键编号为Key，功能集合为Value
     */
    public Map<Long, List<Function>> groupByMenuId(List<Function> functions) {
        logger.info("按菜单主键编号分组");

        Map<Long, List<Function>> functionMap = new HashMap<Long, List<Function>>();
        for (Function function : functions) {
            if (function.getMenu() == null) {
                continue;
            }

            Long menuId = function.getMenu().getId();
            if (!functionMap.containsKey(menuId)) {
                functionMap.put(menuId, new ArrayList<Function>());
            }
            functionMap.get(menuId).add(function);
        }
        return functionMap;
    }

    /**
     * 查找组件通过主键编号集合
     */
    public List<Function> findById(List<Function> functions, List<Long> ids) {
        List<Function> findFunctions = new ArrayList<Function>();
        for (Function function : functions) {
            if (ids.contains(function.getId())) {
                findFunctions.add(function);
            }
        }
        return findFunctions;
    }

    /**
     * 查找功能根据菜单编号
     */
    public List<Function> findByMenuId(List<Function> functions, Long menuId) {
        logger.info("查找功能根据菜单编号");
        List<Function> findFunctions = new ArrayList<Function>();
        for (Function function : functions) {
            if (function.getMenu() != null && function.getMenu().getId().equals(menuId)) {
                findFunctions.add(function);
            }
        }
        return findFunctions;
    }

    /**
     * 查找功能根据上级功能
     */
    public List<Function> findByParentId(List<Function> functions, Long parentId) {
        List<Function> findFunctions = new ArrayList<Function>();
        for (Function function : functions) {
            if (function.getParent() != null && function.getParent().getId().equals(parentId)) {
                findFunctions.add(function);
            }
        }
        return findFunctions;
    }

    /**
     * 授权
     * 1.给用户分配功能
     */
    @Transactional
    public void authorization(Long userId, Long[] functionIds) {
        logger.info("给用户分配功能");
        User user = userDao.get(userId);

        logger.info("清除用户所有功能");
        user.setFunctions(new HashSet<Function>());

        logger.info("添加用户功能");
        for (Long functionId : functionIds) {
            user.getFunctions().add(new Function(functionId));
        }

        userDao.update(user);
    }

    /**
     * findPage(分页查询功能列表)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return HibernatePage<Function>    返回类型
     * @throws NoSuchFieldException
     * @throws
     * @Title: getAll
     */
    @Transactional(readOnly = true)
    public HibernatePage<Function> findPage(Map<String, Object> searchParams, HibernatePage<Function> page) throws NoSuchFieldException {
        logger.info("分页查询功能信息{}", page);
        DetachedCriteria criteria = DetachedCriteria.forClass(Function.class);
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("menu", FetchMode.JOIN);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Function.class);
        return functionDao.findPage(page, criteria);
    }

    /**
     * getl(根据ID查询功能信息)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return HibernatePage<Function>    返回类型
     * @throws
     */
    @Transactional(readOnly = true)
    public Function get(Long id) {
        logger.info("查询单个功能信息{}", id);
        String hql = "select function from Function function  " +
                "left join fetch function.menu " +
                " left join fetch function.privilegeLevel " +
                "where function.id = ?";
        return functionDao.findUnique(hql, id);
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
    public void save(Function entity) {
        logger.info("保存功能信息{}", entity);
        entity.setIsInitialized(false);
        functionDao.save(entity);
    }

    /**
     * delete(删除功能信息)
     *
     * @param @param id    参数类型
     * @return void    返回类型
     * @throws
     * @Title: delete
     */
    @Transactional
    public void delete(Long... id) {
        functionDao.logicalDelete(id);
    }

}
