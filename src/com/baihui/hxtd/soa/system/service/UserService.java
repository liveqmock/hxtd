package com.baihui.hxtd.soa.system.service;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.ServiceException;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.MD5;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.serial.TierSerial;
import com.baihui.hxtd.soa.base.utils.serial.TierSerials;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.dao.OrganizationDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.apache.commons.lang3.Range;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

/**
 * 用户服务类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
@Service
public class UserService {

    private Logger logger = LoggerFactory.getLogger(UserService.class);

    //    @Value(value = "${system.organization.tier.length}")
    private Integer orgTierLength = 2;
    //    @Value("${export.counts}")
    private Integer exportCounts = 3000;


    @Resource
    private UserDao userDao;

    @Resource
    private OrganizationDao organizationDao;

    @Resource
    private DictionaryDao dictionaryDao;

    @Resource
    private MD5 md5;


    /**
     * 验证用户
     * 1.验证用户名
     * 2.验证密码
     * //TODO 使用加密
     */
    public boolean check(User user, User persistUser) throws ServiceException, JsonProcessingException {
        logger.info("验证用户身份");
        logger.debug("用户名“{}”", user.getName());

        if (persistUser == null) {
            throw new ServiceException(ServiceException.PERMISSION_ERROR, "用户名不存在");
        }

        String password = md5.getMD5ofStr(user.getPassword());
        if (!persistUser.getPassword().equals(password)) {
            logger.debug("实际密码“{}”，输入密码“{}”", persistUser.getPassword(), password);
            throw new ServiceException(ServiceException.PERMISSION_ERROR, "用户名和密码不匹配");
        }

        logger.info("验证通过");
        return true;
    }

    /**
     * 重置用户数据存储状态
     * 1.登录时，将数据存储状态置为最新
     */
    @Transactional
    public int resetDataStoreStatus(Long id) {
        logger.info("重置用户的数据存储状态");
        return userDao.resetDataStoreStatusById(id);
    }

    /**
     * 更新用户数据存储状态
     * 1.session中存储的数据发生改变时，更新数据存储状态
     */
    @Transactional
    public int updateDataStoreStatus(Long id) {
        logger.info("更新用户的数据存储状态");
        return userDao.updateDataStoreStatusById(id);
    }

    /**
     * 修改用户密码通过主键编号
     */
    @Transactional
    public int modifyPasswordById(Long id, String password, AuditLog auditLog) {
        logger.info("修改用户密码通过主键编号");
        return userDao.updatePasswordById(id, md5.getMD5ofStr(password));
    }

    /**
     * 重置用户密码通过主键编号
     */
    @Transactional
    public int resetPasswordByIds(Long[] id, AuditLog[] auditLogArr) {
        logger.info("重置用户密码通过主键编号");
        return userDao.updatePasswordByIds(id, md5.getMD5ofStr("123456"));
    }

    /**
     * 修改用户启用状态
     */
    @Transactional
    public int modifyIsActiveByIds(Long[] ids, Boolean isActive, AuditLog[] auditLogArr) {
        logger.info("修改用户启用状态");
        return userDao.updateIsActiveByIds(ids, isActive);
    }

    /**
     * 分页查找
     */
    @Transactional(readOnly = true)
    public HibernatePage<User> findPage(Map<String, Object> searchParams, HibernatePage<User> page, User user, Long organizationId) throws NoSuchFieldException {
        logger.info("分页查找用户");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(User.class);
        detachedCriteria.setFetchMode("sex", FetchMode.JOIN);
        detachedCriteria.setFetchMode("type", FetchMode.JOIN);
        detachedCriteria.setFetchMode("jobSituation", FetchMode.JOIN);
        detachedCriteria.setFetchMode("organization", FetchMode.JOIN);

        detachedCriteria.createAlias("organization", "org");
        Long order = organizationDao.getOrderById(organizationId);
        Range<Long> youngerRange = TierSerials.getYoungerRange(order, Constant.ORG_ORDER_TIER_LENGTH);
        detachedCriteria.add(organizationDao.selfAndYounger("org", organizationId, youngerRange));
        detachedCriteria.add(Restrictions.eq("isDeleted", false));

        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, detachedCriteria, User.class);
        return userDao.findPage(page, detachedCriteria);
    }

    /**
     * 查找
     */
    @Transactional(readOnly = true)
    public List<User> find(Map<String, Object> searchParams, Long organizationId) throws NoSuchFieldException {
        logger.info("分页查找用户");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(User.class);
        detachedCriteria.setFetchMode("sex", FetchMode.JOIN);
        detachedCriteria.setFetchMode("type", FetchMode.JOIN);
        detachedCriteria.setFetchMode("jobSituation", FetchMode.JOIN);
        detachedCriteria.setFetchMode("organization", FetchMode.JOIN);

        detachedCriteria.createAlias("organization", "org");
        Long organizationOrder = organizationDao.getOrderById(organizationId);
        TierSerial tierSerial = TierSerials.parse(organizationOrder, orgTierLength);
        detachedCriteria.add(Restrictions.between("org.order", organizationOrder, organizationOrder + tierSerial.getIncrease() - 1));
        detachedCriteria.add(Restrictions.eq("isDeleted", false));

        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, detachedCriteria, User.class);

        detachedCriteria.addOrder(Order.asc("name"));
        return userDao.find(detachedCriteria, exportCounts);
    }

    /**
     * 查找
     */
    @Transactional(readOnly = true)
    public List<User> find(Long organizationId) {
        logger.info("查找用户");
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(User.class);
        detachedCriteria.setFetchMode("sex", FetchMode.JOIN);
        detachedCriteria.setFetchMode("type", FetchMode.JOIN);
        detachedCriteria.setFetchMode("jobSituation", FetchMode.JOIN);
        detachedCriteria.setFetchMode("organization", FetchMode.JOIN);

        detachedCriteria.createAlias("organization", "org");
        Long organizationOrder = organizationDao.getOrderById(organizationId);
        TierSerial tierSerial = TierSerials.parse(organizationOrder, orgTierLength);
        detachedCriteria.add(Restrictions.between("org.order", organizationOrder, organizationOrder + tierSerial.getIncrease() - 1));
        detachedCriteria.add(Restrictions.eq("isDeleted", false));

        return userDao.find(detachedCriteria, exportCounts);
    }


    /**
     * 新增
     */
    @Transactional
    public void add(User user, AuditLog auditLog) {
        logger.info("新增用户");

        logger.info("添加默认属性值");
        user.setIsDeleted(false);
        user.setIsInitialized(false);
        user.setCreatedTime(new Date());
        user.setModifiedTime(user.getCreatedTime());
        user.setPassword(md5.getMD5ofStr(user.getPassword()));
        user.setStoreStatus(new Dictionary(dictionaryDao.getIdByValue(DictionaryConstant.USER_STORESTATUS_NEWEST)));
        logger.debug("md5加密密码“{}”", user.getPassword());
        userDao.save(user);
        auditLog.setRecordId(user.getId());
    }


    /**
     * 新增
     */
    @Transactional
    public void addList(List<User> users, AuditLog auditLog) {
        logger.info("批量新增");
        for (User user : users) {
            add(user, auditLog);
        }
    }

    /**
     * 获取用户通过编号
     */
    @Transactional(readOnly = true)
    public User getById(Long id) {
        DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
        criteria.setFetchMode("type", FetchMode.JOIN);
        criteria.setFetchMode("sex", FetchMode.JOIN);
        criteria.setFetchMode("storeStatus", FetchMode.SELECT);
        criteria.setFetchMode("jobSituation", FetchMode.JOIN);
        criteria.setFetchMode("organization", FetchMode.JOIN);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.add(Restrictions.idEq(id));
        return userDao.findUnique(criteria);
    }

    /**
     * 获取用户通过用户名
     */
    @Transactional(readOnly = true)
    public User getByName(String name) {
        return userDao.getByName(name);
    }

    /**
     * 获取存储状态值通过主键编号
     */
    @Transactional(readOnly = true)
    public String getStoreStatusById(Long id) {
        return userDao.getStoreStatusById(id);
    }


    /**
     * 修改
     */
    @Transactional
    public void modify(User user, AuditLog auditLog) {
        logger.info("修改用户");

        logger.info("添加默认属性值");
        user.setModifiedTime(new Date());
        logger.debug("修改时间为当前时间“{}”", user.getModifiedTime());

        userDao.update(user);
    }

    /**
     * 批量删除
     */
    @Transactional
    public void delete(Long[] ids, AuditLog[] auditLogArr) {
        logger.info("删除用户");
        userDao.logicalDelete(ids);
    }


    /**
     * 授权
     */
    @Transactional
    public void authorization(Long userId, Long[] roleIds, Long[] functionIds, Long[] componentIds, AuditLog auditLog) {
        logger.info("授权");
        User user = userDao.get(userId);

        logger.info("授权角色");
        user.setRoles(new HashSet<Role>());
        if (roleIds != null) {
            for (Long roleId : roleIds) {
                user.getRoles().add(new Role(roleId));
            }
        }

        logger.info("授权功能");
        user.setFunctions(new HashSet<Function>());
        if (functionIds != null) {
            for (Long functionId : functionIds) {
                user.getFunctions().add(new Function(functionId));
            }
        }

        logger.info("授权组件");
        user.setComponents(new HashSet<Component>());
        if (componentIds != null) {
            for (Long componentId : componentIds) {
                user.getComponents().add(new Component(componentId));
            }
        }

        userDao.update(user);
    }

    /**
     * getNameById
     *
     * @param id
     * @return String
     * @Title: getNameById
     * @Description: 通过id获取名称
     */
    @Transactional
    public String getNameById(Long id) {
        return userDao.get(id).getRealName();
    }
}
