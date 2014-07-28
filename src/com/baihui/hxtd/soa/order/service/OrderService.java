package com.baihui.hxtd.soa.order.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.common.dao.FlowNodeDao;
import com.baihui.hxtd.soa.financial.dao.PaymentsDao;
import com.baihui.hxtd.soa.financial.dao.ReceivablesDao;
import com.baihui.hxtd.soa.financial.entity.Payments;
import com.baihui.hxtd.soa.financial.entity.Receivables;
import com.baihui.hxtd.soa.order.dao.ContractDao;
import com.baihui.hxtd.soa.order.dao.OrderDao;
import com.baihui.hxtd.soa.order.entity.Order;
import com.baihui.hxtd.soa.system.DictionaryConstant;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.dao.UserDao;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;

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
@Transactional(readOnly = true)
public class OrderService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    private OrderDao orderDao;

    @Resource
    private UserDao userDao;

    @Resource
    private ContractDao contractDao;

    @Resource
    private FlowNodeDao flowNodeDao;
    
    @Resource
    private PaymentsDao paymentsDao;
    
    @Resource
    private ReceivablesDao receivablesDao;
    
    @Resource
    private DictionaryDao dictionaryDao;

    @SuppressWarnings("unchecked")
    private DetachedCriteria biuldQuery(Map<String, Object> searchParams, DataShift dataShift, Class entityClass) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(entityClass);
        criteria.setFetchMode("product", FetchMode.JOIN);
        criteria.setFetchMode("flowNode", FetchMode.JOIN);
        criteria.setFetchMode("customer", FetchMode.JOIN);
        criteria.setFetchMode("investmentWay", FetchMode.JOIN);
        criteria.setFetchMode("owner", FetchMode.JOIN);
        criteria.setFetchMode("salesManager", FetchMode.JOIN);
        criteria.setFetchMode("salesMajordomo", FetchMode.JOIN);
        criteria.setFetchMode("creator", FetchMode.JOIN);
        criteria.setFetchMode("modifier", FetchMode.JOIN);
        criteria.setFetchMode("orderStatus", FetchMode.JOIN);
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
                + " left join fetch ord.flowNode "
                + " left join fetch ord.product "
                + " left join fetch ord.customer "
                + " left join fetch ord.investmentWay "
                + " left join fetch ord.owner "
                + " left join fetch ord.salesManager "
                + " left join fetch ord.salesMajordomo "
                + " where ord.id=?";
        return orderDao.findUnique(hql, id);
    }

    @Transactional(readOnly = false)
    public void add(Order order, AuditLog auditLog) {
        Date now = orderDao.getDBNow();
        order.setCreatedTime(now);
        order.setModifiedTime(now);
        order.setFlowNode(flowNodeDao.findStartOfFlow(DictionaryConstant.NODE_TYPE_ORDERAPPROVE));
        order.setOrderStatus(dictionaryDao.getByValue((DictionaryConstant.ORDER_STATUS_START)));
        order.setPayStatus(dictionaryDao.getByValue((DictionaryConstant.ORDER_PAY_2_HXTD_STATUS_NONE)));
        orderDao.save(order);

        auditLog.setRecordId(order.getId());
    }

    @Transactional(readOnly = false)
    public void modify(Order order, AuditLog auditLog) {
        Date now = orderDao.getDBNow();
        order.setCreatedTime(now);
        order.setModifiedTime(now);
        orderDao.save(order);
    }

    @Transactional(readOnly = false)
    public boolean delete(Long[] ids, AuditLog[] auditLogArr) {
        if (contractDao.getCount(ids, "order") > 0) {
            return false;
        } else {
            orderDao.logicalDelete(ids);
            return true;
        }
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
    
    
    public Long getSumMoneyByTime(Date beginTime,Date endTime){
    	String hql = "select sum(order.purchaseMoney) from Order order " +
    					"where order.isDeleted = false " +
    					"and order.payStatus=true " +
    					"and order.modifiedTime between ? and ?";
    	return orderDao.findUnique(hql,beginTime,endTime);
    }
    
    /**
     * 订单审批中 
	 * @Title: modifyOrderNoteing
	 * @param @param id
	 * @param @param user
	 * @param @param auditLog
	 * @return void
	 * @throws
    */
    @Transactional(readOnly = false)
    public void modifyOrderNoteing(Long id){
    	String hql = "update Order o set o.orderStatus = ? where o.id=?";
    	orderDao.createQuery(hql, dictionaryDao.getByValue(DictionaryConstant.ORDER_STATUS_NODEING), id).executeUpdate();
    }
    
    /**
     * 订单审批完成
	 * @Title: modifyOrderNoteFinish
	 * @param @param id
	 * @param @param user
	 * @param @param auditLog
	 * @return void
	 * @throws
    */
    @Transactional(readOnly = false)
    public void modifyOrderNoteFinish(Long id, User user, AuditLog auditLog){
    	String hql = "update Order o set o.orderStatus = ? where o.id=?";
    	orderDao.createQuery(hql, dictionaryDao.getByValue(DictionaryConstant.ORDER_STATUS_NODE_FINIAL), id).executeUpdate();
    	// 创建收款单
    	Order order = orderDao.get(id);
    	if ( order != null ){
    		receivablesDao.save(constructReceivablesByOrder(order, user));
    	}
    }
    
    /**
     * 提前赎回 
	 * @Title: advanceRedemptionOrder
	 * @param @param id
	 * @param @param user
	 * @param @param auditLog
	 * @return void
	 * @throws
     */
    @Transactional(readOnly = false)
    public void advanceRedemptionOrder(Long id, User user, AuditLog auditLog){
    	String hql = "update Order o set o.orderStatus = ? where o.id=?";
    	orderDao.createQuery(hql, dictionaryDao.getByValue(DictionaryConstant.ORDER_STATUS_ADVANCE_REDEMPTION),id).executeUpdate();
    	// 创建付款单
    	Order order = orderDao.get(id);
    	if ( order != null ){
    		paymentsDao.save(constructPaymentsByOrderUser(order, user));
    	}
    }

    /**
     * 客户主动作废订单
	 * @Title: modifyInvalidOrderbyCustomer
	 * @param @param id
	 * @param @param auditLog
	 * @return void
	 * @throws
     */
    @Transactional(readOnly = false)
    public void modifyInvalidOrderbyCustomer(Long id, User user, AuditLog auditLog){
    	String hql = "update Order o set o.orderStatus = ? where o.id=?";
    	orderDao.createQuery(hql, dictionaryDao.getByValue(DictionaryConstant.ORDER_STATUS_INVALID_CUSTOMER),id).executeUpdate();
    }
    
    /**
     * 公司主动作废订单 
	 * @Title: advanceRedemptionOrder
	 * @param @param id
	 * @param @param auditLog
	 * @return void
	 * @throws
     */
    @Transactional(readOnly = false)
    public void modifyInvalidOrderbyOwner(Long id, AuditLog auditLog){
    	String hql = "update Order o set o.orderStatus = ? where o.id=?";
    	orderDao.createQuery(hql, dictionaryDao.getByValue(DictionaryConstant.ORDER_STATUS_INVALID_OWNER),id).executeUpdate();
    }
    
    private Payments constructPaymentsByOrderUser(Order order, User user) {
		String name = Constant.FINANCIAL_PAYMENTS_BEFORE + order.getCode();
		Date now = paymentsDao.getDBNow();
		Payments payments = new Payments(name, order.getCustomer(), order, order
				.getPurchaseMoney(), Constant.FINANCIAL_AUTH_REMARK, now);
		payments.setOwner(user);
		payments.setCreator(user);
		payments.setModifier(user);
		payments.setCreatedTime(now);
		payments.setModifiedTime(now);
		return payments;
	}
    
    private Receivables constructReceivablesByOrder(Order order, User user) {
		String name = Constant.FINANCIAL_RECEIVABLES_BEFORE + order.getCode();
		Date now = receivablesDao.getDBNow();
		Receivables receivables = new Receivables(name, order.getCustomer(), order,
				order.getPurchaseMoney(), Constant.FINANCIAL_AUTH_REMARK,
				now);
		receivables.setOwner(user);
		receivables.setCreator(user);
		receivables.setModifier(user);
		receivables.setCreatedTime(now);
		receivables.setModifiedTime(now);
		return receivables;
	}
    
    
    
}
