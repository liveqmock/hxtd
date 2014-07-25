package com.baihui.hxtd.soa.order.entity;

import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.IdFlowable;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.project.entity.Product;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 功能描述：订单实体类
 *
 * @author ruisong.luan
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.order.entity.Order.java
 * @date 2014-6-30 上午10:57:57
 * @since (该版本支持的 JDK 版本) ： 1.6
 */
@Entity
@Table(name = "`ORDER`")
public class Order implements IdFlowable {

    /**
     * 序列化
     */
    private static final long serialVersionUID = 1L;

    /** 线索ID */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    /**
     * 订单编号（自动生成,不可修改）
     */
    @Column(name = "CODE")
    private String code;

    /** 产品 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PRODUCT_ID")
    private Product product;

    /** 客户 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CUSTOMER_ID")
    private Customer customer;

    /** 状态 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "STATUS")
    private FlowNode status;

    /** 投资方式 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "INVESTMENT_WAY")
    private Dictionary investmentWay;

    /** 购买金额 */
    @Column(name = "PURCHASE_MONEY")
    private BigDecimal purchaseMoney;

    /** 收益率 */
    @Column(name = "EARNING_RATE")
    private Float earningRate;

    /** 提前赎回率 */
    @Column(name = "ADVANCE_REDEEM_RATE")
    private Float arr;

    /** 赎回公式 */
    @Column(name = "REDEEM_FORMULA")
    private String redeemFormula;

    /** 订单所有者 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "OWNER")
    private User owner;

    /** 销售主管 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SALES_MANAGER_ID")
    private User salesManager;

    /** 销售总监 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SALES_MAJORDOMO_ID")
    private User salesMajordomo;

    @Column(name = "ORDER_END_TIME")
    private Date orderEndTime;

    /** 备注 */
    @Column(name = "REMARK", length = 512)
    private String remark;

    /** 创建者 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATOR_ID", updatable = false)
    private User creator;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "CREATED_TIME")
    private Date createdTime;

    /** 修改者 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODIFIER_ID")
    private User modifier;

    /** 最终修改时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    @Column(name = "MODIFIED_TIME")
    private Date modifiedTime;

    /** 删除标识 */
    @Column(name = "IS_DELETED", nullable = false, updatable = false)
    private Boolean isDeleted = false;

    @Column(name = "PAY_STATUS", nullable = false, updatable = false)
    private Boolean payStatus = false;

    @Override
    public FlowNode getFlowNode() {
        return getStatus();
    }

    public String toString() {
        return String.format("订单编号：%s", getId());
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public FlowNode getStatus() {
        return status;
    }

    public void setStatus(FlowNode status) {
        this.status = status;
    }

    public Dictionary getInvestmentWay() {
        return investmentWay;
    }

    public void setInvestmentWay(Dictionary investmentWay) {
        this.investmentWay = investmentWay;
    }

    public BigDecimal getPurchaseMoney() {
        return purchaseMoney;
    }

    public void setPurchaseMoney(BigDecimal purchaseMoney) {
        this.purchaseMoney = purchaseMoney;
    }

    public Float getEarningRate() {
        return earningRate;
    }

    public void setEarningRate(Float earningRate) {
        this.earningRate = earningRate;
    }

    public Float getArr() {
        return arr;
    }

    public void setArr(Float arr) {
        this.arr = arr;
    }

    public String getRedeemFormula() {
        return redeemFormula;
    }

    public void setRedeemFormula(String redeemFormula) {
        this.redeemFormula = redeemFormula;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public User getSalesManager() {
        return salesManager;
    }

    public void setSalesManager(User salesManager) {
        this.salesManager = salesManager;
    }

    public User getSalesMajordomo() {
        return salesMajordomo;
    }

    public void setSalesMajordomo(User salesMajordomo) {
        this.salesMajordomo = salesMajordomo;
    }

    public Date getOrderEndTime() {
        return orderEndTime;
    }

    public void setOrderEndTime(Date orderEndTime) {
        this.orderEndTime = orderEndTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public User getModifier() {
        return modifier;
    }

    public void setModifier(User modifier) {
        this.modifier = modifier;
    }

    public Date getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(Date modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Boolean getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(Boolean payStatus) {
        this.payStatus = payStatus;
    }


}
