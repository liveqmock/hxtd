package com.baihui.hxtd.soa.system.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.UrlUtil;
import com.baihui.hxtd.soa.base.utils.serial.TierSerial;
import com.baihui.hxtd.soa.base.utils.serial.TierSerials;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.dao.FunctionDao;
import com.baihui.hxtd.soa.system.dao.MenuDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.Function;
import com.baihui.hxtd.soa.system.entity.Menu;
import com.baihui.hxtd.soa.system.entity.User;
import org.hibernate.FetchMode;
import org.hibernate.criterion.*;
import org.hibernate.sql.JoinType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * 菜单服务类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Service
public class MenuService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private MenuDao menuDao;

    @Resource
    private FunctionDao functionDao;

    @Resource
    private UserDao userDao;

    @Resource
    private DictionaryDao dictionaryDao;

    /**
     * 查找系统初始化时的菜单
     * 1.排除已删除的
     * 2.必须带有触发功能的
     */
    @Transactional(readOnly = true)
    public List<Menu> findInit() {
        logger.info("查找系统初始化时的菜单");
        String hql = "select menu from Menu menu" +
                " inner join fetch menu.trigger" +
                " inner join fetch menu.showLocation" +
                " left join fetch menu.parent" +
                " where menu.isDeleted=false" +
                " order by menu.order";
        return menuDao.find(hql);
    }

    /**
     * 查找有效的菜单
     */
    @Transactional(readOnly = true)
    public List<Long> findValidId(User user) {
        logger.info("查找有效菜单");
        logger.debug("主键编号“{}”", user.getId());

        DetachedCriteria criteria = DetachedCriteria.forClass(Menu.class, "rootMenu");
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        criteria.setProjection(Projections.id());
        criteria.createAlias("trigger", "trigger", JoinType.INNER_JOIN);

//        criteria.setFetchMode("parent", FetchMode.JOIN);
//        criteria.setFetchMode("trigger", FetchMode.JOIN);
//        criteria.setFetchMode("showLocation", FetchMode.JOIN);

        logger.info("根据类型查找菜单");
        if (!user.getIsManager()) {
            logger.debug("类型为“常规人员”，查找权限内菜单");

            logger.debug("关联");
            DetachedCriteria functionCriteria = DetachedCriteria.forClass(Function.class, "function");
            functionCriteria.setProjection(Projections.property("id"));
            functionCriteria.createAlias("owners", "owner");
            functionCriteria.add(Restrictions.eq("owner.id", user.getId()));
            functionCriteria.createAlias("menu", "menu");
            functionCriteria.add(Restrictions.eqProperty("menu.id", "rootMenu.id"));
            Criterion criterion = Subqueries.exists(functionCriteria);

            logger.debug("角色关联");
            DetachedCriteria roleCriteria = DetachedCriteria.forClass(Function.class, "function");
            roleCriteria.setProjection(Projections.property("id"));
            roleCriteria.createAlias("roles", "role");
            roleCriteria.createAlias("role.owners", "owner");
            roleCriteria.add(Restrictions.eq("owner.id", user.getId()));
            roleCriteria.createAlias("menu", "menu");
            roleCriteria.add(Restrictions.eqProperty("menu.id", "rootMenu.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(roleCriteria));

            logger.debug("组织角色关联");
            DetachedCriteria orgCriteria = DetachedCriteria.forClass(Function.class, "function");
            orgCriteria.setProjection(Projections.property("id"));
            orgCriteria.createAlias("roles", "role");
            orgCriteria.createAlias("role.organizations", "organization");
            orgCriteria.createAlias("organization.owners", "orgOwner");
            orgCriteria.add(Restrictions.eq("orgOwner.id", user.getId()));
            orgCriteria.createAlias("menu", "menu");
            orgCriteria.add(Restrictions.eqProperty("menu.id", "rootMenu.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(orgCriteria));

            //公共级别的菜单，不需要权限验证
            Dictionary privilegeLevel = dictionaryDao.getByValue(DictionaryConstant.FUNCTION_PRIVILEGELEVEL_PUBLIC);
            criterion = Restrictions.or(criterion, Restrictions.eq("trigger.privilegeLevel", privilegeLevel));

            criteria.add(criterion);
        } else {
            logger.debug("类型为“管理员”，查找所有菜单");

        }

        criteria.add(Restrictions.eq("isDeleted", false));

        criteria.addOrder(Order.asc("order"));

        List<Long> ids = menuDao.find(criteria);
        logger.info("菜单主键编号数目“{}”", ids.size());
        return ids;
    }

    /**
     * 查找有效的菜单
     */
    @Transactional(readOnly = true)
    public List<Menu> findValid(User user) {
        logger.info("查找有效菜单");
        logger.debug("主键编号“{}”", user.getId());

        DetachedCriteria criteria = DetachedCriteria.forClass(Menu.class, "rootMenu");
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        criteria.setFetchMode("parent", FetchMode.JOIN);
        criteria.setFetchMode("trigger", FetchMode.JOIN);
        criteria.setFetchMode("showLocation", FetchMode.JOIN);

        logger.info("根据类型查找菜单");
        if (!user.getIsManager()) {
            logger.debug("类型为“常规人员”，查找权限内菜单");

            logger.debug("关联");
            DetachedCriteria functionCriteria = DetachedCriteria.forClass(Function.class, "function");
            functionCriteria.setProjection(Projections.property("id"));
            functionCriteria.createAlias("owners", "owner");
            functionCriteria.add(Restrictions.eq("owner.id", user.getId()));
            functionCriteria.createAlias("menu", "menu");
            functionCriteria.add(Restrictions.eqProperty("menu.id", "rootMenu.id"));
            Criterion criterion = Subqueries.exists(functionCriteria);

            logger.debug("角色关联");
            DetachedCriteria roleCriteria = DetachedCriteria.forClass(Function.class, "function");
            roleCriteria.setProjection(Projections.property("id"));
            roleCriteria.createAlias("roles", "role");
            roleCriteria.createAlias("role.owners", "owner");
            roleCriteria.add(Restrictions.eq("owner.id", user.getId()));
            roleCriteria.createAlias("menu", "menu");
            roleCriteria.add(Restrictions.eqProperty("menu.id", "rootMenu.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(roleCriteria));

            logger.debug("组织角色关联");
            DetachedCriteria orgCriteria = DetachedCriteria.forClass(Function.class, "function");
            orgCriteria.setProjection(Projections.property("id"));
            orgCriteria.createAlias("roles", "role");
            orgCriteria.createAlias("role.organizations", "organization");
            orgCriteria.createAlias("organization.owners", "orgOwner");
            orgCriteria.add(Restrictions.eq("orgOwner.id", user.getId()));
            orgCriteria.createAlias("menu", "menu");
            orgCriteria.add(Restrictions.eqProperty("menu.id", "rootMenu.id"));
            criterion = Restrictions.or(criterion, Subqueries.exists(orgCriteria));

            //公共级别的菜单，不需要权限验证
            criteria.createAlias("trigger", "trigger");
            Dictionary privilegeLevel = dictionaryDao.getByValue(DictionaryConstant.FUNCTION_PRIVILEGELEVEL_PUBLIC);
            criterion = Restrictions.or(criterion, Restrictions.eq("trigger.privilegeLevel", privilegeLevel));

            criteria.add(criterion);
        } else {
            logger.debug("类型为“管理员”，查找所有菜单");
            //TODO 筛选有功能的菜单
            criteria.createAlias("functions", "function", JoinType.INNER_JOIN);
        }

        criteria.add(Restrictions.eq("isDeleted", false));

        criteria.addOrder(Order.asc("order"));

        List<Menu> menus = menuDao.find(criteria);
        logger.info("数目“{}”", menus.size());
        return menus;
    }

    /**
     * 填充父级菜单
     */
    public List<Menu> fullParent(List<Menu> menus) {
        logger.info("填充父级菜单");

        logger.info("查找丢失的父级菜单");
        Set<Menu> notExistParents = new HashSet<Menu>();
        for (Menu menu : menus) {
            if (menu.getLevel().equals(1)) {
                continue;
            }
            if (!menus.contains(menu.getParent())) {
                notExistParents.add(menu.getParent());
            }
        }
        logger.debug("数目“{}”", notExistParents.size());

        logger.info("构建拷贝菜单列表，并填充丢失的父级菜单");
        List<Menu> menuClones = new ArrayList<Menu>(menus);
        menuClones.addAll(notExistParents);
        Collections.sort(menuClones);

        logger.debug("数目“{}”", menuClones.size());

        return menuClones;
    }

    /**
     * 查找激活的菜单
     */
    public List<Menu> findActive(List<Menu> menus) {
        logger.info("查找激活的菜单");

        List<Menu> activeMenus = new ArrayList<Menu>();
        for (Menu menu : menus) {
            if (menu.getIsActive()) {
                activeMenus.add(menu);
            }
        }
        return activeMenus;
    }

    /**
     * 查找默认选中的菜单
     */
    public Menu findDefaultShow(List<Menu> menus) {
        logger.info("查找默认选中的菜单");

        for (Menu menu : menus) {
            if (menu.getDefaultShow()) {
                return menu;
            }
        }

        throw new RuntimeException("菜单默认选中数据值状态异常，没有默认选中的菜单（有且仅有一项处于默认选中状态）");
    }

    /**
     * 查找菜单通过主键编号集合
     */
    public List<Menu> findById(List<Menu> menus, List<Long> ids) {
        List<Menu> findMenus = new ArrayList<Menu>();
        for (Menu menu : menus) {
            if (ids.contains(menu.getId())) {
                findMenus.add(menu);
            }
        }
        return findMenus;
    }

    /**
     * 查找菜单根据级别
     */
    public List<Menu> findByLevel(List<Menu> menus, int level) {
        logger.info("查找菜单根据级别");
        logger.debug("级别“{}”", level);
        List<Menu> levelMenus = new ArrayList<Menu>();
        for (Menu menu : menus) {
            if (menu.getLevel().equals(level)) {
                levelMenus.add(menu);
            }
        }
        logger.debug("数目“{}”", levelMenus.size());
        return levelMenus;
    }

    /**
     * 查找菜单根据显示位置
     * 1.父菜单不显示，所有子菜单都不显示
     */
    public List<Menu> findByShowlocation(List<Menu> menus, String showlocation) throws CloneNotSupportedException {
        logger.info("查找菜单根据显示位置");
        logger.debug("显示位置“{}”", showlocation);


        List<Menu> showMenus = new ArrayList<Menu>();
        for (Menu menu : menus) {
            if (menu.getShowLocation() != null && showlocation.equals(menu.getShowLocation().getValue())) {
                showMenus.add(menu);
            }
        }

        logger.debug("数目“{}”", showMenus.size());

        return showMenus;
    }

    /**
     * 按父节点主键编号分组
     * 1.以父节点主键编号为Key，子节点集合为Value
     */
    public Map<Long, List<Menu>> groupByParentId(List<Menu> menus) {
        logger.info("按父节点编号分组");

        Map<Long, List<Menu>> menuMap = new HashMap<Long, List<Menu>>();
        for (Menu menu : menus) {
            Long parentId = menu.getParent().getId();
            if (!menuMap.containsKey(parentId)) {
                menuMap.put(parentId, new ArrayList<Menu>());
            }
            menuMap.get(parentId).add(menu);
        }

        logger.debug("数目“{}”", menuMap.size());

        return menuMap;
    }

    /**
     * 查找当前菜单及其子菜单通过主键编号
     */
    public List<Menu> findSelfChildrenById(List<Menu> menus, Long id) {
        if (id == null) {
            return menus;
        }

        List<Menu> findMenus = new ArrayList<Menu>();
        for (Menu menu : menus) {
            if (menu.getId().equals(id) || (menu.getParent() != null && menu.getParent().getId().equals(id))) {
                findMenus.add(menu);
            }
        }

        return findMenus;
    }

    /**
     * 查找子菜单通过主键编号
     */
    public List<Menu> findChildrenById(List<Menu> menus, Long id) {
        List<Menu> findMenus = new ArrayList<Menu>();
        boolean isEquals;
        for (Menu menu : menus) {
            //判断非根节点相等
            isEquals = menu.getParent() != null && menu.getParent().getId() != null && menu.getParent().getId().equals(id);
            //判断根节点相等
            isEquals = isEquals || id == null && menu.getParent() == null;
            if (isEquals) {
                findMenus.add(menu);
            }
        }

        return findMenus;
    }

    /**
     * 查找菜单通过主键编号
     */
    public Menu findById(List<Menu> menus, Long id) {
        for (Menu menu : menus) {
            if (menu.getId().equals(id)) {
                return menu;
            }
        }
        return null;
    }

    /**
     * 转换菜单触发功能的URL为toXXPage形式
     */
    public void toTriggerUrl(List<Menu> menus) {
        logger.info("转换菜单触发功能的URL为toPage形式");
        for (Menu menu : menus) {
            Function trigger = menu.getTrigger();
            if (trigger != null && trigger.getUrl() != null) {
                trigger = trigger.clone();
                trigger.setUrl(UrlUtil.toPage(trigger.getUrl()));
                menu.setTrigger(trigger);
            }
        }
    }

    /**
     * 功能描述：获取树形菜单
     */
    @Transactional(readOnly = true)
    public List<Menu> query() {
        return menuDao.getAll();
    }

    /**
     * getMenuJsonData(将菜单集合转换成Json串)
     *
     * @param @return 参数类型
     * @return String    返回类型
     * @throws
     * @Title: getMenuJsonData
     * @Description: TODO
     */
    @Transactional(readOnly = true)
    public String getMenuJsonData() {
        List<Menu> menuLst = query();
        StringBuffer jsonData = new StringBuffer("[");
        int index = 0;
        for (Menu item : menuLst) {
            jsonData.append(
                    String.format("{id:%s,pId:%s,name:'%s'}%s",
                            new Object[]{item.getId(),
                                    (null == item.getParent() ? "0" : item.getParent().getId()),
                                    item.getName(),
                                    (++index < menuLst.size() ? "," : "")
                            }
                    )
            );
        }
        jsonData.append("]");
        return jsonData.toString();
    }

    /**
     * getAll(分页查询菜单列表)
     *
     * @param @param  page
     * @param @return 参数类型
     * @return HibernatePage<Component>    返回类型
     * @throws
     * @Title: getAll
     */
    @Transactional(readOnly = true)
    public HibernatePage<Menu> queryByPage(HibernatePage<Menu> page, Long id) {
        return menuDao.queryByPage(page, id);
    }

    /**
     * get(获取一个实体对象)
     *
     * @param @param  id
     * @param @return 参数类型
     * @return Menu    返回类型
     * @throws
     * @Title: get
     * @Description: TODO
     */
    @Transactional(readOnly = true)
    public Menu get(Long id) {
        String hql = "select menu" +
                " from Menu menu" +
                " inner join fetch menu.showLocation" +
                " left join fetch menu.parent" +
                " left join fetch menu.functions" +
                " left join fetch menu.trigger" +
                " where menu.id=?";
        return menuDao.findUnique(hql, id);
    }

    /**
     * 新增
     * 编号规则：依次增长。
     * 在A节点下新增AB节点，AB节点的编号为A节点下最大子节点AA的下一位，
     * 如果A节点下没有子节点，则AB节点为首位
     * 1.主键，有规则的，不支持
     * 2.编号，有规则的
     * 3.序号，有规则的
     * 4.叶子节点默认为是
     * 5.级别依次增长，父节点的基础上+1
     * 6.影响父节点
     */
    @Transactional
    public void add(Menu menu) {
        logger.info("新增");

        logger.info("添加默认属性值");
        menu.setCode(null);
        logger.debug("编号默认为空");
        menu.setIsLeaf(true);
        Menu parent = menu.getParent();
        if (parent == null || parent.getId() == null) {
            menu.setLevel(1);
            Long order = getMaxChildOrder(null, 1);
            TierSerial tierSerial = TierSerials.parse(order, 2);
            tierSerial.increaseValue(1);
            menu.setOrder(tierSerial.getSerial());
            menu.setParent(null);
        } else {
            parent = menuDao.get(parent.getId());
            menu.setLevel(parent.getLevel() + 1);
            parent.setIsLeaf(true);
            if (parent.getIsLeaf()) {
                toParent(parent);
                TierSerial tierSerial = TierSerials.parse(parent.getOrder(), 2);
                tierSerial = tierSerial.getMinChild();
                menu.setOrder(tierSerial.getSerial());
            } else {
                Long order = getMaxChildOrder(parent.getId(), menu.getLevel());
                TierSerial tierSerial = TierSerials.parse(order, 2);
                tierSerial.increaseValue(1);
                menu.setOrder(tierSerial.getSerial());
            }
        }
        logger.debug("级别根据父节点设置为“{}”", menu.getLevel());
        logger.debug("序号根据父节点设置为“{}”", menu.getOrder());

        //创建时间为当前时间
        menu.setCreatedTime(new Date());
        //修改时间为当前时间
        menu.setModifiedTime(menu.getCreatedTime());
        //是否删除的为false
        menu.setIsDeleted(false);
        //是否初始化数据为false
        menu.setIsInitialized(false);

        if (menu.getDefaultShow()) {
            menuDao.updateToNotDefaultShow();
        }

        menuDao.save(menu);

        //级联新增功能
        Function trigger = menu.getTrigger();
        for (Function function : menu.getFunctions()) {
            if (function.equals(trigger)) {
                trigger = function;
                break;
            }
        }

        String url = menu.getUrl().substring(0, menu.getUrl().lastIndexOf("/"));
        Set<Function> emptyFunctions = new HashSet<Function>();
        for (Function function : menu.getFunctions()) {
            if (function.getId() == null) {
                emptyFunctions.add(function);
                continue;
            }
            Function persistFunction = functionDao.get(function.getId());
            function.setId(null);
            function.setName(persistFunction.getName());
            function.setUrl(url + persistFunction.getUrl());
            function.setPrivilegeLevel(dictionaryDao.getByValue(DictionaryConstant.FUNCTION_PRIVILEGELEVEL_AUTHORITY));
            function.setMenu(menu);
            function.setCreator(menu.getCreator());
            function.setModifier(menu.getModifier());
            function.setRemark("");
        }
        menu.getFunctions().removeAll(emptyFunctions);
        functionDao.add(menu.getFunctions());

        menu.setTrigger(trigger);
        menuDao.save(menu);

//        userDao.updateManagerStoreStatus();
    }

    /**
     * 获取最大的子节点序号
     */
    @Transactional(readOnly = true)
    public Long getMaxChildOrder(Long parentId, int level) {
        logger.info("获取最大的子节点序号");
        DetachedCriteria criteria = DetachedCriteria.forClass(Menu.class);
        criteria.setProjection(Projections.max("order"));
        criteria.add(Restrictions.eqOrIsNull("parent", parentId == null ? null : new Menu(parentId)));
        criteria.add(Restrictions.eq("level", level));
        return menuDao.findUnique(criteria);
    }

    /**
     * 成为父节点
     * 1.往节点A下加入子节点B，节点A成为父节点
     * 2.更新“叶子节点”属性
     */
    @Transactional
    public void toParent(Menu menu) {
        String hql = "update Menu menu set menu.isLeaf=0 where menu.id=?";
        menuDao.createQuery(hql, menu.getId()).executeUpdate();
    }


    /**
     * 修改
     */
    @Transactional
    public void modify(Menu menu) {
        logger.info("修改");

        logger.info("添加默认属性值");
        menu.setModifiedTime(new Date());
        logger.debug("修改时间为当前时间“{}”", menu.getModifiedTime());

        //修改当前菜单为默认显示时，更新其他默认显示的菜单为不默认显示
        Boolean defaultShow = menuDao.getDefaultShow(menu.getId());
        if (defaultShow == false && menu.getDefaultShow() == true) {
            menuDao.updateToNotDefaultShow();
        }
        menuDao.update(menu);

        userDao.updateAllStoreStatus();
    }

    /**
     * 批量删除
     */
    @Transactional
    public void delete(Long... ids) {
        logger.info("删除");
        menuDao.logicalDelete(ids);

        userDao.updateAllStoreStatus();
    }


}
