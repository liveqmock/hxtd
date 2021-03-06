package com.baihui.hxtd.soa.common.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.DBDateServiceInjecter;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.base.utils.serial.TierSerial;
import com.baihui.hxtd.soa.base.utils.serial.TierSerials;
import com.baihui.hxtd.soa.common.dao.CommonDao;
import com.baihui.hxtd.soa.common.entity.Idable;
import com.baihui.hxtd.soa.common.entity.Initialized;
import com.baihui.hxtd.soa.common.entity.Orderable;
import com.baihui.hxtd.soa.common.entity.TreeNode;
import com.baihui.hxtd.soa.system.dao.AuditLogDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.util.EnumOperationType;

/**
 * 基础公用的服务类
 *
 * @author xiayouxue
 * @date 2014/6/20
 */
@Service
@SuppressWarnings("unchecked")
public class CommonService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private CommonDao commonDao;

    @Resource
    private AuditLogDao auditLogDao;

    public Date getNow() {
        return commonDao.getDBNow();
    }

    /**
     * 查找实体类通过主键编号
     */
    public <T extends Idable> List<T> findByIds(List<T> entities, List<Long> ids) {
        List<T> targetEntities = new ArrayList<T>();
        for (int i = 0; i < ids.size(); i++) {
            T entity = findById(entities, ids.get(i));
            if (entity != null) {
                targetEntities.add(entity);
            }
        }
        return targetEntities;
    }

    /**
     * 查找实体类通过主键编号
     */
    public <T extends Idable> T findById(List<T> entities, Long id) {
        for (int i = 0; i < entities.size(); i++) {
            T entity = entities.get(i);
            if (entity.getId() != null && entity.getId().equals(id)) {
                return entity;
            }
        }
        return null;
    }

    /**
     * 是否初始化数据
     */
    @Transactional(readOnly = true)
    public boolean isInitialized(Class<? extends Initialized> clazz, long id) {
        return commonDao.isInitialized(clazz, id);
    }

    /**
     * 是否初始化数据
     */
    @Transactional(readOnly = true)
    public boolean isInitialized(Class<? extends Initialized> clazz, Long[] ids) {
        if (ids.length == 1) {
            return commonDao.isInitialized(clazz, ids[0]);
        }
        return commonDao.isInitialized(clazz, ids);
    }

    /**
     * 获取序列值通过主键编号
     */
    @Transactional(readOnly = true)
    public Long getOrderById(Class<? extends Orderable> clazz, Long id) {
        String hql = String.format("select entity.order from %s entity where id=?", clazz.getSimpleName());
        return commonDao.findUnique(hql, id);
    }

    /**
     * 查询实体通过主键编号
     */
    public <T> List<T> findById(Class<T> clazz, Long... id) {
        String hql = String.format("select entity from %s entity where entity.id in (:id)", clazz.getSimpleName());
        logger.debug("/*hql=*/{}", hql);
        return commonDao.getSession().createQuery(hql).setParameterList("id", id).list();
    }

    /**
     * 查询实体通过主键编号
     * 1.可以设置级联抓取字段
     */
    @Transactional(readOnly = true)
    public <T> List<T> findById(Class<T> clazz, String[] fetchs, Long... id) {
        String hql = String.format("select entity from %s entity %s where entity.id in (:id)", clazz.getSimpleName(), toFetchHql("entity", fetchs));
        logger.debug("/*hql=*/{}", hql);
        return commonDao.getSession().createQuery(hql).setParameterList("id", id).list();
    }

    /**
     * 转换为级联抓取语句
     */
    private String toFetchHql(String entityName, String... fetchs) {
        if (fetchs == null || fetchs.length == 0) {
            return "";
        }

        String join = String.format(" left join fetch %s.", entityName);
        return join + StringUtils.join(fetchs, join);
    }

    /**
     * 查找导出数据
     */
    @Transactional(readOnly = true)
    public <T> List<T> findExport(String hql) {
        return (List<T>) commonDao.getSession().createQuery(hql).setMaxResults(Constant.EXPORT_MAX_COUNT).list();
    }

    /**
     * 检查字段唯一性
     */
    @Transactional(readOnly = true)
    public boolean checkUnique(String entityName, String fieldName, String fieldValue) {
        String hql = String.format("select entity.id from %s entity where entity.%s=?", entityName, fieldName);
        Object object = commonDao.findUnique(hql, fieldValue);
        return object == null;
    }

    /**
     * 产品总和不能超过项目金额
     */
    @Transactional(readOnly = true)
    public boolean checkMoney(Long projectId, BigDecimal saleMoney) {
        String hql = "select financeLimit from Project where id=?";
        BigDecimal projectMoney = commonDao.findUnique(hql, projectId);

        String strHql = "select sum(sellMoney) from Product where project.id=?";
        BigDecimal productMoney = commonDao.findUnique(strHql, projectId);

        productMoney = productMoney.add(saleMoney);

        return projectMoney.compareTo(productMoney) >= 0;
    }

    private int orgTierLength = 2;

    /**
     * 移动位置
     * 1.缓存源节点序号
     * 2.更新源节点的父节点
     * 3.上移源节点的兄弟节点
     * 4.更新目标节点的父节点
     * 5.下移目标节点的兄弟节点
     * 6.从缓存位置填充源节点序号至目标节点
     * 7.设置源节点的父节点
     * 8.更新源节点的级别
     */
    @Transactional
    public void move(String entityName, Long sourceId, Long targetId, String moveType) {
        logger.info("移动位置");

        if (sourceId == targetId) {
            logger.warn("当前位置未移动");
            return;
        }

        TreeNode source = commonDao.get(entityName, sourceId);
        TreeNode target = commonDao.get(entityName, targetId);
        logger.debug("“{}”->“{}”", source.getOrder(), target.getOrder());

        long min, max, increase;
        TierSerial sourceTierSerial = TierSerials.parse(source.getOrder(), orgTierLength);
        logger.info("缓存源节点序号至{}位", StringUtils.repeat('0', orgTierLength));
        min = source.getOrder();
        max = source.getOrder() + sourceTierSerial.getIncrease() - 1;
        increase = -source.getOrder();
        commonDao.increaseOrderByOrderRange(entityName, min, max, increase);

        logger.info("处理源节点的父节点及其兄弟节点");
        TreeNode sourceParent = source.getParent();
        if (sourceParent != null && sourceParent.getChildren().size() == 1) {
            logger.debug("更新源节点的原父节点（父节点仅含有该子节点时，更新为叶子节点）");
            commonDao.updateIsLeafById(entityName, sourceParent.getId(), true);
        }

        logger.info("源节点以下兄弟节点上移");
        min = source.getOrder() + sourceTierSerial.getIncrease();
        max = TierSerials.getMax(min, orgTierLength);
        increase = -sourceTierSerial.getIncrease();
        logger.debug("序号范围：{}-{}", min, max);
        commonDao.increaseOrderByOrderRange(entityName, min, max, increase);


        if ("inner".equals(moveType)) {
            logger.info("移动到内部");

            logger.info("更新目标节点叶子节（false）");
            commonDao.updateIsLeafById(entityName, targetId, false);

            min = 0;
            max = sourceTierSerial.getIncrease() - 1;
            logger.info("更新源节点级别（在目标节点上递增）");
            commonDao.increaseLevelByOrderRange(entityName, min, max, target.getLevel() - source.getLevel());
            logger.info("更新源节点至目标节点");
            commonDao.increaseOrderByOrderRange(entityName, min, max, TierSerials.getMinChild(target.getOrder(), orgTierLength));
            logger.info("设置源节点的父节点");
            commonDao.updateParentById(entityName, sourceId, targetId);
        } else {
            logger.info("移动到兄弟节点位置");

            logger.info("目标节点及其以下兄弟节点下移");
            TierSerial targetTierSerial = TierSerials.parse(target.getOrder(), orgTierLength);
            min = target.getOrder();
            max = TierSerials.getMax(min, orgTierLength);
            increase = targetTierSerial.getIncrease();
            commonDao.increaseOrderByOrderRange(entityName, min, max, increase);

            min = 0;
            max = sourceTierSerial.getIncrease() - 1;
            logger.info("更新源节点级别（在目标节点上递增）");
            commonDao.increaseLevelByOrderRange(entityName, min, max, target.getLevel() - source.getLevel());
            logger.info("更新源节点至目标节点");
            commonDao.increaseOrderByOrderRange(entityName, min, max, target.getOrder());
            logger.info("设置源节点的父节点");
            commonDao.updateParentById(entityName, sourceId, target.getParent() == null ? null : target.getParent().getId());
        }
    }

    /**
     * 移动位置时同步session中的数据
     */
    public void moveSynSession(List<? extends TreeNode> treeNodes, Long sourceId, Long targetId) {
        logger.info("移动");

        if (sourceId == targetId) {
            logger.warn("当前位置未移动");
            return;
        }

        int sourceIndex = findIndex(treeNodes, sourceId);
        TreeNode source = treeNodes.get(sourceIndex);
        int targetIndex = findIndex(treeNodes, targetId);
        TreeNode target = treeNodes.get(targetIndex);

        logger.debug("“{}”->“{}”", source.getOrder(), target.getOrder());
        logger.info("以不同移动类型进行移动");
        if ((source.getParent() == null && target.getParent() == null) || source.getParent().equals(target.getParent())) {
            logger.info("兄弟节点间移动");
            logger.info("以不同移动方向进行移动");

            TierSerial tierSerial = TierSerials.parse(source.getOrder(), orgTierLength);

            int minIndex, maxIndex;
            long increase;
            if (source.getOrder() > target.getOrder()) {
                logger.info("上移");
                minIndex = targetIndex;
                maxIndex = sourceIndex - 1;
                increase = tierSerial.getIncrease();
            } else {
                logger.info("下移");
                minIndex = findRangeMaxIndex(treeNodes, sourceIndex, source) + 1;
                maxIndex = targetIndex;
                if (!target.getIsLeaf()) {
                    maxIndex = findRangeMaxIndex(treeNodes, targetIndex, target);
                }
                increase = -tierSerial.getIncrease();
            }
            Long targetOrder = target.getOrder();
            for (int i = minIndex; i <= maxIndex; i++) {
                TreeNode treeNode = treeNodes.get(i);
                treeNode.setOrder(treeNode.getOrder() + increase);
            }

            minIndex = sourceIndex;
            maxIndex = findRangeMaxIndex(treeNodes, sourceIndex, source);
            increase = -(source.getOrder() - targetOrder);
            for (int i = minIndex; i <= maxIndex; i++) {
                TreeNode treeNode = treeNodes.get(i);
                treeNode.setOrder(treeNode.getOrder() + increase);
            }

            Collections.sort(treeNodes);
        } else {
            logger.info("跨父节点移动");
            logger.debug("暂未实现");
        }
    }

    /**
     * 查找区间最大索引值
     */
    public int findRangeMaxIndex(List<? extends TreeNode> treeNodes, int minIndex, TreeNode target) {
        for (int i = minIndex + 1; i < treeNodes.size(); i++) {
            if (treeNodes.get(i).getLevel().equals(target.getLevel())) {
                return i - 1;
            }
        }
        return treeNodes.size() - 1;
    }

    /**
     * 查找树节点索引根据唯一编号
     */
    private int findIndex(List<? extends TreeNode> treeNodes, long id) {
        for (int i = 0; i < treeNodes.size(); i++) {
            if (treeNodes.get(i).getId().equals(id)) {
                return i;
            }
        }
        return -1;
    }

    /**
     * 查找树节点根据排序号范围
     */
    private List<TreeNode> findByOrderRange(List<? extends TreeNode> treeNodes, long min, long max) {
        List<TreeNode> finds = new ArrayList<TreeNode>();
        for (int i = 0; i < treeNodes.size(); i++) {
            TreeNode treeNode = treeNodes.get(i);
            Long order = treeNode.getOrder();
            if (order >= min && order <= max) {
                finds.add(treeNode);
            }
        }
        return finds;
    }

    /**
     * 查询已删除的数据
     */
    @Transactional(readOnly = true)
    public HibernatePage<T> getDeletedDate(HibernatePage<T> page, String entityName, String recordName, Long deletorId, Date gteModifiedTime, Date lteModifiedTime) {
        return commonDao.getDeletedDate(page, entityName, recordName, deletorId, gteModifiedTime, lteModifiedTime);
    }

    @Transactional
    public void delete(String entityName, Long... ids) {
        commonDao.delete(entityName, ids);

    }

    @Transactional
    public void recovery(String entityName, Long... id) {
        commonDao.recovery(entityName, id);
    }

    /**
     * 保存审计日志
     * 1.EnumModule的moduleName必须和实体类类名首字母小写相匹配，暂时没有建立相关映射
     */
    @Transactional
    public void saveAuditlog(ImportExport.Type type, String name, User user, int size) {
        AuditLog auditLog = new AuditLog();
        auditLog.setModuleName(name);
        auditLog.setRecordId(null);
        auditLog.setRecordName(type.equals(ImportExport.Type.selected) ? "导出列表选中的数据" : String.format("导出前%s条数据", Constant.EXPORT_MAX_COUNT));
        auditLog.setType(EnumOperationType.EXPORT.getOperationType());
        auditLog.setCreator(user);
        auditLog.setCreatedTime(DBDateServiceInjecter.nowTime());
        auditLog.setRemark(String.format("共导出%s条数据", size));
        auditLogDao.save(auditLog);
    }

}
