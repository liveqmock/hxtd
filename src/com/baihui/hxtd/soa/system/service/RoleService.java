package com.baihui.hxtd.soa.system.service;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.system.dao.RoleDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.*;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 角色服务类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Service
public class RoleService {

    private Logger logger = LoggerFactory.getLogger(RoleService.class);

    @Resource
    private RoleDao roleDao;

    @Resource
    private UserDao userDao;

    /**
     * 查找所有角色
     */
    @Transactional(readOnly = true)
    public List<Role> findAll() {
        logger.info("查找所有角色");
        String hql = "select role from Role role where role.isDeleted=false";
        return roleDao.find(hql);
    }

    /**
     * 分页查找
     */
    @Transactional(readOnly = true)
    public HibernatePage<Role> findPage(Map<String, Object> searchParams, HibernatePage<Role> page, DataShift dataShift) throws NoSuchFieldException {
        logger.info("分页查找");
        DetachedCriteria criteria = DetachedCriteria.forClass(Role.class);
//        criteria.setFetchMode("type", FetchMode.JOIN);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        userDao.visibleData(criteria, dataShift);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Role.class);
        return roleDao.findPage(page, criteria);
    }


    /**
     * 新增
     */
    @Transactional
    public void add(Role role, AuditLog auditLog) {
        logger.info("新增");

        role.setCreatedTime(roleDao.getDBNow());
        role.setModifiedTime(role.getCreatedTime());
        role.setIsDeleted(false);
        role.setIsInitialized(false);

        roleDao.save(role);
        auditLog.setRecordId(role.getId());
    }


    /**
     * 获取通过编号
     */
    @Transactional(readOnly = true)
    public Role getById(Long id) {
        String hql = "select role from Role role" +
                " left join fetch role.type" +
                " left join fetch role.creator" +
                " left join fetch role.modifier" +
                " where role.id=?";
        return roleDao.findUnique(hql, id);
    }

    /**
     * 修改
     */
    @Transactional
    public void modify(Role role, AuditLog auditLog) {
        logger.info("修改");
        role.setModifiedTime(roleDao.getDBNow());
        roleDao.update(role);
    }

    /**
     * 批量删除
     */
    @Transactional
    public void delete(Long[] ids, AuditLog[] auditLogArr) {
        logger.info("删除");
        roleDao.logicalDelete(ids);
    }

    /**
     * 是否是系统管理员
     */
    @Transactional(readOnly = true)
    public boolean isSysManager(User user) {
    	logger.info("是否是系统管理员");

        if (user.getIsManager()) {
            return true;
        }

        String hql = "select count(role.id)" +
        " from Role role" +
        " inner join role.owners owner" +
        " where owner.id=? and role.code=?";
        return (Long) roleDao.findUnique(hql, user.getId(), Constant.ROLE_SYSMANAGER) > 0;
	}
    
    /**
     * 是否是系统数据管理员
     */
    @Transactional(readOnly = true)
    public boolean isSysDataManager(User user) {
        logger.info("是否是系统数据管理员");

        if (user.getIsManager()) {
            return true;
        }

        String hql = "select count(role.id)" +
                " from Role role" +
                " inner join role.owners owner" +
                " where owner.id=? and role.code=?";
        return (Long) roleDao.findUnique(hql, user.getId(), Constant.ROLE_SYSDATAMANAGER) > 0;
    }

    /**
     * 是否是系统数据管理员
     */
    @Transactional(readOnly = true)
    public boolean isOrgDataManager(User user) {
        logger.info("是否是组织数据管理员");

        if (user.getIsManager()) {
            return true;
        }

        String hql = "select count(role.id)" +
                " from Role role" +
                " inner join role.owners owner" +
                " where owner.id=? and role.code=?";
        return (Long) roleDao.findUnique(hql, user.getId(), Constant.ROLE_ORGMANAGER) > 0;
    }


    /**
     * 查找有效角色
     * //TODO 关于角色关联用户以提供查找的功能
     * 1.用户类型包含的
     * 2.授权分配的
     * 3.组织继承的
     */
    @Transactional(readOnly = true)
    public List<Role> findValid(User user) {
        return roleDao.findValid(user);
    }

    /**
     * 查找组织继承角色
     */
    @Transactional(readOnly = true)
    public List<Role> findOrganizationInherit(Long userId) {
        logger.info("查找组织继承角色");
        logger.debug("用户主键编号“{}”", userId);
        String hql = "select role from Role role" +
                " inner join role.organizations org" +
                " inner join org.owners owner" +
                " where owner.id=?";
        return roleDao.find(hql, userId);
    }

    /**
     * 查找授权角色
     */
    @Transactional(readOnly = true)
    public List<Role> findAuthorization(Long userId) {
        logger.info("查找授权角色");
        logger.debug("用户主键编号“{}”", userId);
        String hql = "select role from Role role inner join role.owners owner where owner.id=?";
        return roleDao.find(hql, userId);
    }

    /**
     * 查找组织关联角色
     */
    @Transactional(readOnly = true)
    public List<Role> findOrganization(Long organizationId) {
        logger.info("查找组织关联角色");
        logger.debug("组织主键编号“{}”", organizationId);
        String hql = "select role from Role role inner join role.organizations orgs where orgs.id=?";
        return roleDao.find(hql, organizationId);
    }

    /**
     * 授权
     */
    @Transactional
    public void authorization(Long id, Long[] functionIds, Long[] componentIds, AuditLog auditLog) {
        logger.info("授权");
        Role role = roleDao.get(id);

        logger.info("分配功能");
        role.setFunctions(new HashSet<Function>());
        if (functionIds != null) {
            for (Long functionId : functionIds) {
                role.getFunctions().add(new Function(functionId));
            }
        }

        logger.info("分配组件");
        role.setComponents(new HashSet<Component>());
        if (componentIds != null) {
            for (Long componentId : componentIds) {
                role.getComponents().add(new Component(componentId));
            }
        }

        roleDao.update(role);
    }

    /**
     * getNameById
     *
     * @param id
     * @return String
     * @Title: getNameById
     * @Description: 通过id获取角色名称
     */
    @Transactional
    public String getNameById(Long id) {
        return roleDao.get(id).getName();
    }

    /**
     * 根据角色ID找到功能
     * @param roleId
     * @return
     */
    @Transactional
	public List<Long> findFunByRoleId(Long roleId) {
    	 String hql = "select function.id from Function function inner join function.roles role where role.id=?";
         List<Long> functionIds = roleDao.find(hql, roleId);
         return functionIds;

	}
    
    /**
     * 根据角色ID找到
     * @param roleId
     * @return
     */
    @Transactional
	public List<Long> findComByRoleId(Long roleId) {
    	String hql = "select component.id from Component component inner join component.roles role where role.id=?";
        List<Long> componentIds = roleDao.find(hql, roleId);
        return componentIds;
	}
	

}
