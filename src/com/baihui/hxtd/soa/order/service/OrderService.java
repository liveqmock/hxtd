package com.baihui.hxtd.soa.order.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.controller.model.FlowModel;
import com.baihui.hxtd.soa.order.dao.ContractDao;
import com.baihui.hxtd.soa.order.dao.OrderDao;
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.system.dao.RoleDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.service.DataShift;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 功能描述：order表service层
 *
 * @author ruisong.luan
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.order.service.OrderService.java
 * @date 2014-6-30 下午02:22:01
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Service
@Transactional
public class OrderService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    private OrderDao orderDao;

    @Resource
    private UserDao userDao;


    @Resource
    private ContractDao contractDao;
    /*@Resource
	private WFNodeService wfNodeService;
	
	@Resource
	private WFTaskService wfTaskService;*/

    @SuppressWarnings("unchecked")
    private DetachedCriteria biuldQuery(Map<String, Object> searchParams, DataShift dataShift, Class entityClass) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
//        criteria.setFetchMode("product", FetchMode.JOIN);
        criteria.setFetchMode("status", FetchMode.JOIN);
        criteria.setFetchMode("customer", FetchMode.JOIN);
        criteria.setFetchMode("investmentWay", FetchMode.JOIN);
        criteria.setFetchMode("owner", FetchMode.JOIN);
        criteria.setFetchMode("salesManager", FetchMode.JOIN);
        criteria.setFetchMode("salesMajordomo", FetchMode.JOIN);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        Map<String, SearchFilter> filters = Search.parse(searchParams);
        userDao.visibleData(criteria, dataShift);
        Search.buildCriteria(filters, criteria, entityClass);
        return criteria;
    }

    /**
     * 分页查找
     */
    @Transactional(readOnly = true)
    public HibernatePage<Order> findPage(Map<String, Object> searchParams, DataShift dataShift,
                                         HibernatePage<Order> page) throws NoSuchFieldException {
        logger.info("分页查找线索");
        DetachedCriteria criteria = biuldQuery(searchParams, dataShift, Order.class);
        return orderDao.findPage(page, criteria);
    }

    /**
     * 导出
     */
    public List<Order> export(Map<String, Object> searchParams, DataShift dataShift)
            throws NoSuchFieldException {
        DetachedCriteria criteria = biuldQuery(searchParams, dataShift, Order.class);
        return orderDao.find(criteria, 3000);
    }

    public Order get(Long id) {
        String hql = " select ord from Order ord "
                + " left join fetch ord.status "
//                + " left join fetch ord.product "
                + " left join fetch ord.customer "
                + " left join fetch ord.investmentWay "
                + " left join fetch ord.owner "
                + " left join fetch ord.salesManager "
                + " left join fetch ord.salesMajordomo "
                + " where ord.id=?";
        return orderDao.findUnique(hql, id);
    }

    public void add(Order order, AuditLog auditLog) {
        Date now = orderDao.getDBNow();
        order.setCreatedTime(now);
        order.setModifiedTime(now);
        orderDao.save(order);

        /************新增订单审批任务***************/
		/*List<WFNode> nodeLst = wfNodeService.findByFlowValue("a00");
		List<WFTask> taskLst;
		for(WFNode node : nodeLst){
			WFTask task = new WFTask();
			
		}*/
        //todo: lihua


        auditLog.setRecordId(order.getId());
    }

    public void modify(Order order, AuditLog auditLog) {
        Date now = orderDao.getDBNow();
        order.setCreatedTime(now);
        order.setModifiedTime(now);
        orderDao.save(order);
    }

    public void delete(Long[] ids, AuditLog[] auditLogArr) {
        orderDao.delete(ids);
    }

    /**
     * 查询没有被合同关联的订单
     *
     * @param searchParams
     * @param dataShift
     * @param page
     * @return
     * @throws NoSuchFieldException
     * @author huizijing
     */
    public HibernatePage<Order> findListPage(Map<String, Object> searchParams,
                                             DataShift dataShift, HibernatePage<Order> page) throws NoSuchFieldException {
        searchParams.put("EQ_isDeleted", false);
        DetachedCriteria criteria = biuldQuery(searchParams, dataShift, Order.class);
        page = orderDao.findPage(page, criteria);
        List<Order> orders = page.getResult();
        for (int i = 0; i < orders.size(); i++) {
            Long[] id = {orders.get(i).getId()};
            if (contractDao.getCount(id, "order") > 0) {
                orders.remove(i);
            }
        }
        page.setResult(orders);
        return page;
    }

    public void startApprove(FlowModel flowModel){
        String hql = "";
    }


}
