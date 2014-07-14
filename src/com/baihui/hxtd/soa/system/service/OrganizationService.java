package com.baihui.hxtd.soa.system.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.base.utils.serial.TierSerial;
import com.baihui.hxtd.soa.base.utils.serial.TierSerials;
import com.baihui.hxtd.soa.system.dao.OrganizationDao;
import com.baihui.hxtd.soa.system.dao.RoleDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.Role;
import com.baihui.hxtd.soa.system.entity.User;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.FetchMode;
import org.hibernate.criterion.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.util.*;

/**
 * 组织服务类
 *
 * @author xiayouxue
 * @date 2014/5/17
 */
@Service
public class OrganizationService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //    @Value(value = "${system.organization.tier.length}")
    private Integer orgTierLength = 2;

    @Resource
    private OrganizationDao organizationDao;

    @Resource
    private RoleDao roleDao;

    /**
     * 查找扇化组织列表
     */
    @Transactional(readOnly = true)
    public List<Organization> findSector(Long rootOrder, Long targetOrder) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Organization.class);
        criteria.setFetchMode("parent", FetchMode.JOIN);
        List<Long> orders = TierSerials.getParentsUntil(targetOrder, rootOrder, orgTierLength);

        TierSerial tierSerial = TierSerials.parse(rootOrder, orgTierLength);
        int level = tierSerial.getLevel();
        List<Criterion> criterions = new ArrayList<Criterion>();
        criterions.add(Restrictions.eq("order", targetOrder));
        if (orders.size() > 0) {
            criterions.add(Restrictions.in("order", orders));
        }
        for (int i = 0; i < orders.size(); i++) {
            Long order = orders.get(i);
            Long minChild = TierSerials.getMinChild(order, orgTierLength);
            Long maxChild = TierSerials.getMaxChild(order, orgTierLength);
            criterions.add(Restrictions.and(Restrictions.between("order", minChild, maxChild), Restrictions.eq("level", ++level)));
        }
        criteria.add(Restrictions.or(criterions.toArray(new Criterion[]{})));
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.addOrder(Order.asc("order"));
        return organizationDao.find(criteria);
    }

    /**
     * 获取通过编号
     */
    @Transactional(readOnly = true)
    public Organization getById(Long id) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Organization.class);
        criteria.setFetchMode("type", FetchMode.JOIN);
        criteria.setFetchMode("status", FetchMode.JOIN);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("parent", FetchMode.JOIN);
        criteria.add(Restrictions.idEq(id));
        return organizationDao.findUnique(criteria);
    }

    /**
     * 获取通过序号
     */
    @Transactional(readOnly = true)
    public Organization getByOrder(Long order) {
        String hql = "select org from Organization org where org.order=?";
        return organizationDao.findUnique(hql, order);
    }

    /**
     * 查找子组织通过主键编号
     */
    @Transactional(readOnly = true)
    public List<Organization> findChildrenById(Long id) {
        logger.info("查找子组织");
        String hql = "select org from Organization org" +
                " inner join fetch org.parent parent" +
                " where parent.id=?" +
                " and org.isDeleted=false" +
                " order by org.order";
        return organizationDao.find(hql, id);
    }

    /**
     * 查找子节点通过序号
     */
    @Transactional(readOnly = true)
    public List<Organization> findChildrenByOrder(Long order) {
        logger.info("查找子组织");
        String hql = "select org from Organization org" +
                " inner join org.parent parent" +
                " where parent.order=?" +
                " and org.isDeleted=false" +
                " order by org.order";
        return organizationDao.find(hql, order);
    }

    /**
     * 查找子节点通过序号
     */
    public Organization findChildByOrder(List<Organization> organizations, Long order) {
        for (Organization organization : organizations) {
            if (organization.getOrder() == order) {
                return organization;
            }
        }
        return null;
    }

    /**
     * 查找父节点
     */
    public Organization findParent(Long id) {
        logger.info("查找父节点");
        String hql = "select org.parent from Organization org where org.id=?";
        return organizationDao.findUnique(hql, id);
    }

    /**
     * 获取序号通过主键编号
     */
    @Transactional(readOnly = true)
    public Long getOrderById(Long id) {
        return organizationDao.getOrderById(id);
    }

    /**
     * 分页查找
     */
    @Transactional(readOnly = true)
    public HibernatePage<Organization> findPage(Map<String, Object> searchParams, HibernatePage<Organization> page) throws NoSuchFieldException {
        logger.info("分页查找");
        DetachedCriteria criteria = DetachedCriteria.forClass(Organization.class);
        criteria.setFetchMode("type", FetchMode.JOIN);
        criteria.setFetchMode("parent", FetchMode.JOIN);
        criteria.add(Restrictions.eq("isDeleted", false));
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Organization.class);
        return organizationDao.findPage(page, criteria);
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
     * //TODO 不支持直接新增根节点
     */
    @Transactional
    public void add(Organization organization,AuditLog auditLog) {
        logger.info("新增");
        Organization parent = organizationDao.get(organization.getParent().getId());

        logger.info("添加服务端属性值");
        organization.setId(null);
        Long order;
        if (parent.getIsLeaf()) {
            TierSerial tierSerial = TierSerials.parse(parent.getOrder(), orgTierLength);
            if (tierSerial.isLeaf()) {
                upgrade();
                tierSerial = TierSerials.parse(parent.getOrder() * TierSerials.getTierIncrease(orgTierLength), orgTierLength);
            }
            order = tierSerial.getMinChild().getSerial();
        } else {
            Organization maxChild = getMaxChild(parent);
            TierSerial tierSerial = TierSerials.parse(maxChild.getOrder(), orgTierLength);
            tierSerial.increaseValue(1);
            order = tierSerial.getSerial();
        }
        organization.setOrder(order);
        logger.debug("序号为“{}”", organization.getOrder());
        organization.setLevel(parent.getLevel() + 1);
        logger.debug("级别为“{}”（上级节点级别+1）", organization.getLevel());
        organization.setIsLeaf(true);
        logger.debug("叶子节点为“{}”（新增节点默认为叶子节点）", organization.getIsLeaf());
        organization.setCreatedTime(organizationDao.getDBNow());
        logger.debug("创建时间为当前时间“{}”", organization.getCreatedTime());
        organization.setModifiedTime(organization.getCreatedTime());
        logger.debug("修改时间为当前时间“{}”", organization.getCreatedTime());
        organization.setIsDeleted(false);
        logger.debug("是否删除的为“{}”", organization.getIsDeleted());
        organization.setIsInitialized(false);

        organizationDao.save(organization);

        auditLog.setRecordId(organization.getId());
        toParent(parent);
    }

    /**
     * 升级
     * 1.将序号提升一个级别
     */
    @Transactional
    public int upgrade() {
        logger.info("提升序号级别");
        String hql = "update Organization org set org.order=org.order*" + TierSerials.getTierIncrease(orgTierLength);
        return organizationDao.batchExecute(hql);
    }

    /**
     * 成为父节点
     * 1.往节点A下加入子节点B，节点A成为父节点
     * 2.更新“叶子节点”属性
     */
    @Transactional
    public void toParent(Organization organization) {
        if (organization.getIsLeaf()) {
            String hql = "update Organization org set org.isLeaf=0 where org.id=?";
            organizationDao.createQuery(hql, organization.getId()).executeUpdate();
        }
    }

    /**
     * 获取最大的子节点
     * 1.判断最大值根据序号排列
     */
    @Transactional(readOnly = true)
    public Organization getMaxChild(Organization organization) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Organization.class, "org");

        DetachedCriteria maxOrderCriteria = DetachedCriteria.forClass(Organization.class);
        maxOrderCriteria.setProjection(Projections.max("order"));
        Long orderMin = organization.getOrder() + 1;
        TierSerial tierSerial = TierSerials.parse(orderMin, orgTierLength);
        Long orderMax = organization.getOrder() + tierSerial.getIncrease() - 1;
        maxOrderCriteria.add(Restrictions.between("order", orderMin, orderMax));
        maxOrderCriteria.add(Restrictions.eq("level", organization.getLevel() + 1));

        Long order = organizationDao.findUnique(maxOrderCriteria);
        logger.debug("order“{}”", order);

        criteria.add(Restrictions.eq("order", order));

        return organizationDao.findUnique(criteria);
    }


    /**
     * 修改
     */
    @Transactional
    public void modify(Organization organization,AuditLog auditLog) {
        logger.info("修改");

        Long parentId = organization.getParent() == null ? null : organization.getParent().getId();
        Organization persistParent = findParent(organization.getId());
        Long persistParentId = persistParent == null ? null : persistParent.getId();
        //修改时父级发生变化
        if (parentId == persistParentId) {
            organization.setParent(null);
            organizationDao.update(organization);
        } else {
            Organization parent = organizationDao.get(organization.getParent().getId());
            //针对于原父级变化的操作
            List<Organization> list = persistParent.getChildren();
            if (list.size() == 1) {
                persistParent.setIsLeaf(true);
                organizationDao.update(persistParent);
            }
            //针对于新父级的操作
            //判断新父级是否是父节点
            Long code, order;
            if (parent.getIsLeaf()) {
                TierSerial tierSerial = TierSerials.parse(parent.getOrder(), orgTierLength);
                order = tierSerial.getMinChild().getSerial();
            } else {
                Organization maxChild = getMaxChild(parent);
                TierSerial tierSerial = TierSerials.parse(maxChild.getOrder(), orgTierLength);
                tierSerial.increaseValue(1);
                order = tierSerial.getSerial();
            }
            organization.setOrder(order);
            logger.debug("序号为“{}”", organization.getOrder());
            organization.setLevel(parent.getLevel() + 1);
            logger.debug("叶子节点为“{}”（新增节点默认为叶子节点）", organization.getIsLeaf());
            organization.setCreatedTime(organizationDao.getDBNow());
            logger.debug("创建时间为当前时间“{}”", organization.getCreatedTime());
            organization.setModifiedTime(organization.getCreatedTime());
            logger.debug("修改时间为当前时间“{}”", organization.getCreatedTime());
            organizationDao.getSession().clear();
            organizationDao.update(organization);
            toParent(parent);
        }
    }

    /**
     * 移动
     * 1.兄弟节点间移动
     * 1.1.上移
     * 1.2.下移
     * 2.跨父节点移动
     */
    @Transactional
    public void move(Long sourceId, Long targetId) {
        logger.info("移动");
        Organization source = organizationDao.get(sourceId);
        Organization target = organizationDao.get(targetId);
        logger.debug("“{}”->“{}”，“{}”->“{}”", sourceId, targetId, source.getName(), target.getName());
        logger.info("以不同移动类型进行移动");
        if (source.getParent().equals(target.getParent())) {
            logger.info("兄弟节点间移动");
            logger.info("以不同移动方向进行移动");
            organizationDao.updateOrderById(sourceId, 0l);
            TierSerial tierSerial = TierSerials.parse(source.getOrder(), orgTierLength);
            if (sourceId > targetId) {
                logger.info("上移");
                organizationDao.increaseOrderByOrderRange(target.getOrder(), source.getOrder() - tierSerial.getTierIncrease(), tierSerial.getTierIncrease());
            } else if (sourceId < targetId) {
                logger.info("下移");
                organizationDao.increaseOrderByOrderRange(source.getOrder() + tierSerial.getTierIncrease(), target.getOrder(), -tierSerial.getTierIncrease());
            }
            organizationDao.updateOrderById(sourceId, target.getOrder());
        } else {
            logger.info("跨父节点移动");
            logger.debug("暂未实现");
        }
    }

    /**
     * 批量删除
     * 1.级联删除子节点
     */
    @Transactional
    public void delete(Long[] ids,AuditLog [] auditLogArr) {
        logger.info("删除");
        organizationDao.logicalDelete(ids);
    }


    /**
     * 查找授权角色
     */
    @Transactional(readOnly = true)
    public List<Role> findAuthorization(Long id) {
        logger.info("查找授权角色");
        DetachedCriteria criteria = DetachedCriteria.forClass(Role.class);
        criteria.createAlias("organizations", "orgs");
        criteria.add(Restrictions.eq("orgs.id", id));
        criteria.addOrder(Order.asc("id"));
        List<Role> roles = roleDao.find(criteria);
        logger.debug("数目“{}”", roles.size());
        return roles;
    }


    /**
     * 授权
     * 1.分配角色
     */
    @Transactional
    public void authorization(Long id, Long[] roleIds,AuditLog auditLog) {
        logger.info("授权");
        Organization organization = organizationDao.get(id);

        logger.info("清空角色集合");
        logger.debug("数目“{}”", organization.getRoles().size());
        organization.setRoles(new HashSet<Role>());

        logger.info("重新分配角色");
        if (roleIds != null) {
            for (Long roleId : roleIds) {
                organization.getRoles().add(new Role(roleId));
            }
        }
        logger.debug("数目“{}”", organization.getRoles().size());

        organizationDao.update(organization);
    }

    /**
     * 获取用户机构树
     *
     * @return List<Organization> 所有机构
     * @author huizijing
     */
    @Transactional
    public List<Organization> getOrgAndUsers() {
        String hql = "select org from Organization org left join fetch org.owners";
        return organizationDao.find(hql);
    }

    
	/**
     * getNameById
     * @Title: getNameById
     * @Description: 通过id获取组织名称
     * @param id
     * @return String
    */
    @Transactional
	public String getNameById(Long id) {
		return organizationDao.get(id).getName();
	}

}
