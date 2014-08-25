package com.baihui.hxtd.soa.customer.service;

import java.util.List;
import java.util.Map;

import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.system.entity.AuditLog;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DataShift;

/**
 * 功能描述：客户模块service层
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权) 本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.customer.service.CustomerServlet.java
 * @version (版本)1
 * @date 2014-5-20 下午03:32:19
 */
@WebService
public interface CustomerService {

	/**
     * 分页查找
     */
    public @WebResult(name = "HibernatePage") 
    HibernatePage<Customer> findPage(
    		@WebParam(name = "searchParams")Map<String, Object> searchParams, 
    		@WebParam(name = "page")HibernatePage<Customer> page,
    		@WebParam(name = "dataShift")DataShift dataShift) throws NoSuchFieldException;
    
    
    /**
	 * 根据id查询Customer对象
	 */
	public @WebResult(name = "Customer")
	Customer get(@WebParam(name = "id")Long id);
	
    /**
     * 保存客户信息
     * @param customer
     */
	public void add(
			@WebParam(name = "entity")Customer entity,
			@WebParam(name = "user")User user,
			@WebParam(name = "auditLog")AuditLog auditLog);
	
	/**
     * 修改客户信息
     * @param customer
     */
	public void modify(
			@WebParam(name = "customer")Customer customer,
			@WebParam(name = "user")User user, 
			@WebParam(name = "auditLog")AuditLog auditLog);
	
	
	
	 /**
     * delete(删除客户信息)
     * @param id
     */
    public @WebResult(name = "deleteResult")String delete(
    		@WebParam(name = "user")User user, 
    		@WebParam(name = "id")Long[] id,
    		@WebParam(name = "auditLog")AuditLog [] auditLog);
    
    /**
     * 修改客户所有者
     * @param ownerId
     * @param id
     */
    public void modifyOwner(
    		@WebParam(name = "ownerId")Long ownerId, 
    		@WebParam(name = "id")Long[] id,
    		@WebParam(name = "auditLogArr")AuditLog [] auditLogArr );


    /**
     * 根据id查询客户
     * @author huizijing
     * @param id
     * @return Customer
     */
	public @WebResult(name = "Customer")Customer getById(
			@WebParam(name = "id")Long id);


	public @WebResult(name = "CustomerList")List<Customer> find(
			@WebParam(name = "searchParams")Map<String, Object> searchParams) throws NoSuchFieldException;


	/**
      * getNameById
      * @Title: getNameById
      * @Description: 通过id获取名称
      * @param id
      * @return String
     */
    public @WebResult(name = "CustomerName")String getNameById(
    		@WebParam(name = "id")Long id);
	
    public @WebResult(name = "Customer")Customer getByName(
    		@WebParam(name = "name")String name);
    
    
}