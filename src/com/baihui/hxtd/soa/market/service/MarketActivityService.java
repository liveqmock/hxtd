package com.baihui.hxtd.soa.market.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.dao.FlowNodeDao;
import com.baihui.hxtd.soa.market.dao.MarketActivityDao;
import com.baihui.hxtd.soa.market.entity.MarketActivity;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;

/**
 * 功能描述：供应商模块service层
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.market.service.ContactService.java
 * @date 2014-5-16 下午04:48:19
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Service
@Transactional
public class MarketActivityService {

    //private Logger logger = LoggerFactory.getLogger(MarketActivityService.class);
    @Resource
    private MarketActivityDao marketActivityDao;
    @Resource
    private UserDao userDao;

    @Resource
    private FlowNodeDao flowNodeDao;

    /**
     * get(根据ID查询市场活动)
     *
     * @param id 活动主键ID
     * @return MarketActivity 活动实体
     */
    public MarketActivity get(Long id) {
        String hql = "select market from MarketActivity market " +
                "left join fetch market.typeDic " +
                "left join fetch market.statusDic " +
                "left join fetch market.sponsor " +
                "left join fetch market.bossHead " +
                "left join fetch market.flowNode " +
                "where market.id = ?";
        return marketActivityDao.findUnique(hql, id);
    }

    /**
     * getNameById
     *
     * @param id
     * @return String
     * @Title: getNameById
     * @Description: 通过id获取名称
     */
    public String getNameById(Long id) {
        return marketActivityDao.get(id).getName();
    }


    /**
     * findPage(分页查询市场活动列表、非全model)
     *
     * @param searchParams 查询条件
     * @param page         分页对象
     * @return HibernatePage<MarketActivity> 分页结果集
     * @throws 字段异常
     */
    @Transactional(readOnly = true)
    public HibernatePage<MarketActivity> findPage(Map<String, Object> searchParams,
    		DataShift dataShift,
    		HibernatePage<MarketActivity> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(MarketActivity.class);
        criteria.setFetchMode("typeDic", FetchMode.JOIN);// 活动类型
        criteria.setFetchMode("statusDic", FetchMode.JOIN);// 活动状态
        criteria.setFetchMode("flowNode", FetchMode.JOIN);
        criteria.setFetchMode("bossHead", FetchMode.JOIN);
        criteria.add(Restrictions.eq("isDeleted", false));// 过滤已删除

		dataAuthFliter(criteria, searchParams, dataShift);

        return marketActivityDao.findPage(page, criteria);
    }

    /**
     * save(保存：修改/新建)
     * modifier:xiaoli.luo
     *
     * @param entity 市场活动实体
     */
    public void add(MarketActivity entity, User user, AuditLog auditLog) {
        String flowValue = entity.getPredictCost() == 0d ? DictionaryConstant.NODE_TYPE_MARKETACTIVITY_NOMONEY : DictionaryConstant.NODE_TYPE_MARKETACTIVITY_MONEY;
        entity.setFlowNode(flowNodeDao.findStartOfFlow(flowValue));
        marketActivityDao.save(entity);
        auditLog.setRecordId(entity.getId());
    }

    /**
     * modifier:xiaoli.luo
     *
     * @param entity
     * @param sessionId
     */
    public void modify(MarketActivity entity, User user, AuditLog auditLog) {
        String flowValue = entity.getPredictCost() == 0d ? DictionaryConstant.NODE_TYPE_MARKETACTIVITY_NOMONEY : DictionaryConstant.NODE_TYPE_MARKETACTIVITY_MONEY;
        entity.setFlowNode(flowNodeDao.findStartOfFlow(flowValue));
        marketActivityDao.save(entity);
    }


    /**
     * delete(删除活动记录)
     * modifier:xiaoli.luo
     *
     * @param id 活动主键IDS
     * @Description: 根据活动主键ID删除记录，支持批量删除
     */
    public void delete(User user, Long[] id, AuditLog[] auditLog) {
        marketActivityDao.logicalDelete(id);
    }

    /**
     * export(导出市场活动3000条)
     *
     * @param searchParams 过滤条件
     * @return List<MarketActivity> 返回数据
     * @throws NoSuchFieldException
     */
    public List<MarketActivity> export(Map<String, Object> searchParams,
                                       DataShift dataShift) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(MarketActivity.class);
        criteria.add(Restrictions.eq("isDeleted", false));
        criteria.setFetchMode("typeDic", FetchMode.JOIN);
        criteria.setFetchMode("statusDic", FetchMode.JOIN);

        dataAuthFliter(criteria, searchParams, dataShift);

        return marketActivityDao.find(criteria, 3000);
    }

    /**
     * dataAuthFliter(数据级权限过滤)
     *
     * @param criteria
     * @param searchParams 过滤条件
     * @param dataShift    数据权限
     * @throws NoSuchFieldException
     */
    private void dataAuthFliter(DetachedCriteria criteria,
                                Map<String, Object> searchParams,
                                DataShift dataShift) throws NoSuchFieldException {
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        userDao.visibleData(criteria, dataShift.renameUserFieldName("bossHead"));
        Search.buildCriteria(filters, criteria, MarketActivity.class);
    }
}
