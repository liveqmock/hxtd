package com.baihui.hxtd.soa.common.service.imports;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.customer.entity.CustomerDTO;
import com.baihui.hxtd.soa.util.Tools;
@Service
@Transactional
public class ImportCustomerService extends ImportServiceAbstract<CustomerDTO,Customer> {

	
	
	/**
	 * 根据"实体类,主键列表"判断是否在数据库中有重复数据,在根据"重复类型"处理重复数据
	 * Map<Integer,Lead>
	 * 其中Integer有两个值1:新增,2:修改
	 */
	@Override
	public Map<Integer, Customer> isAddOrUpdate(CustomerDTO customerDTO, List<String> uniqueString, String duplicateType) {
		if(uniqueString==null || uniqueString.size()==0){
			uniqueString = new ArrayList<String>();
			//默认手机作为唯一标识
			uniqueString.add("mobile");
		}
		String hqlParam = "";
		String value = "";
		/*
		 * 返回的集合.key是1或者2
		 * 1:新增
		 * 2:修改
		 */
		Map<Integer, Customer> entityMap = new HashMap<Integer, Customer>();
		for(int i = 0; i<uniqueString.size(); i++){
			//获取唯一标记
			String unique = uniqueString.get(i);
			if("email".equals(unique)){
				hqlParam += " and entity.name=? ";
				value += customerDTO.getName()+",";
			}
			if("mobile".equals(unique)){
				hqlParam += " and entity.mobile=? ";
				value += customerDTO.getMobile()+",";
			}
		}
		value = value.substring(0,value.lastIndexOf(","));
		String[] values = value.split(","); 
		//将customerDTO对象转换成Customer类型的对象
		Customer customerFromExcel = convertT2E(customerDTO);
		//根据一个或多个主键查询数据库
		Customer customerFromDB = (Customer)importDao.getByUnique("Customer",hqlParam,values);
		
		if (customerFromDB != null) {
			//如果leadByDB不为空,则查询到重复数据,应该修改,根据记录合并方式进行修改
			entityMap.put(2, super.mergeDataByDuplicateType(customerFromExcel, customerFromDB, duplicateType));
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseRepeatRowNums
			ImportMessage.databaseRepeatRowNums.add(customerDTO.getExcelRowNum());
		}else{
		    //如果leadByDB为空,则说明该记录应该是新增
			entityMap.put(1, customerFromExcel);
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseNewRowNums
			ImportMessage.databaseNewRowNums.add(customerDTO.getExcelRowNum());
		}
		return entityMap;
	}
	
	/**
	 * 将customerDTO对象转换成Customer类型的对象
	 * convertcustomerDTOTlCustomer
	 */
	public Customer convertT2E(CustomerDTO customerDTO) {
		Customer customer = new Customer();
		//所有者0
		customer.setOwner(customerDTO.getOwner());

		// 姓名1
		customer.setName(customerDTO.getName());

		// 公司名称2
		customer.setCompany(customerDTO.getCompany());
		
		// 电话3
		customer.setPhone(customerDTO.getPhone());
		
		// 手机4
		customer.setMobile(customerDTO.getMobile());

		// 邮箱5
		customer.setEmail(customerDTO.getEmail());
		
		// 传真6
		customer.setFax(customerDTO.getFax());
		
		// 来源7
		customer.setSource(customerDTO.getSource());
		
		// 行业8
		customer.setIndustry(customerDTO.getIndustry());
		
		// 客户类型9
		customer.setType(customerDTO.getType());
		
		//风险等级10
		customer.setRiskGrade(customerDTO.getRiskGrade());
		
		// 证件类型11
		customer.setCardType(customerDTO.getCardType());
		
		// 证件号码12
		customer.setCardNum(customerDTO.getCardNum());
		
		// 部门13
		customer.setDept(customerDTO.getDept());

		//职务14
		customer.setJob(customerDTO.getJob());
		
		// 邮编15
		customer.setPostCode(customerDTO.getPostCode());
		
		//所有权16
		customer.setOwnerShip(customerDTO.getOwnerShip());
		
		//开户行17
		customer.setOpenBank(customerDTO.getOpenBank());
		
		//开户名18
		customer.setBankName(customerDTO.getBankName());
		
		//账号19
		customer.setBankAccount(customerDTO.getBankAccount());
		
		// 省20
		customer.setProvince(customerDTO.getProvince());

		// 市21
		customer.setCity(customerDTO.getCity());

		// 区/县22
		customer.setCounty(customerDTO.getCounty());
		
		// 详细地址23
		customer.setAddress(customerDTO.getAddress());
		
		//出资方式24
		customer.setContributionType(customerDTO.getContributionType());
		
		//出资规模25
		customer.setContributionScale(customerDTO.getContributionScale());
		
		//要约人26
		customer.setAppointment(customerDTO.getAppointment());
		
		//理财顾问27
		customer.setFinancialAdvisor(customerDTO.getFinancialAdvisor());
		
		//理财经理28
		customer.setFinancialManager(customerDTO.getFinancialManager());
		
		//理财总监29
		customer.setFinancialDirector(customerDTO.getFinancialDirector());
		
		// 备注30
		customer.setRemark(customerDTO.getRemark());

		return customer;

	}
	
	/**
	 *  将两个对象数据合并,将其有值得属性合并,如果都有,customer中的属性覆盖customerByDB中的属性
	 * @param customer
	 * @param customerByDB
	 * @return
	 */
	public Customer mergeData(Customer customer, Customer customerByDB){
		//Id
		customer.setId(customerByDB.getId());
		
		//所有者0
		if (customer.getOwner() == null) {
			customer.setOwner(customerByDB.getOwner());
		}
		
		//姓名1
		if(Tools.isEmpty(customer.getName())){
			customer.setName(customerByDB.getName());
		}
		
		//公司名称2
		if(Tools.isEmpty(customer.getCompany())){
			customer.setCompany(customerByDB.getCompany());
		}
		
		//电话3
		if(Tools.isEmpty(customer.getPhone())){
			customer.setPhone(customerByDB.getPhone());
		}
		
		//手机4
		if(Tools.isEmpty(customer.getMobile())){
			customer.setMobile(customerByDB.getMobile());
		}
		
		//邮箱5
		if(Tools.isEmpty(customer.getEmail())){
			customer.setEmail(customerByDB.getEmail());
		}
		
		//传真6
		if(Tools.isEmpty(customer.getFax())){
			customer.setFax(customerByDB.getFax());
		}
		
		//来源7
		if(customer.getSource() == null){
			customer.setSource(customerByDB.getSource());
		}
		
		//行业8
		if(customer.getIndustry() == null){
			customer.setIndustry(customerByDB.getIndustry());
		}
		
		//客户类型9
		if(customer.getType() == null){
			customer.setType(customerByDB.getType());
		}
		
		//风险等级10
		if(customer.getRiskGrade() == null){
			customer.setRiskGrade(customerByDB.getRiskGrade());
		}
		
		//证件类型11 
		if(customer.getCardType() == null){
			customer.setCardType(customerByDB.getCardType());
		}
		
		//证件号码12
		if(Tools.isEmpty(customer.getCardNum())){
			customer.setCardNum(customerByDB.getCardNum());
		}
		
		//部门13
		if(Tools.isEmpty(customer.getDept())){
			customer.setDept(customerByDB.getDept());
		}
		//职务14
		if(Tools.isEmpty(customer.getJob())){
			customer.setJob(customerByDB.getJob());
		}
		
		//邮编15
		if(Tools.isEmpty(customer.getPostCode())){
			customer.setPostCode(customerByDB.getPostCode());
		}
		
		//所有权16
		if(customer.getOwnerShip() == null){
			customer.setOwnerShip(customerByDB.getOwnerShip());
		}
		
		//开户行17
		if(customer.getOpenBank() == null){
			customer.setOpenBank(customerByDB.getOpenBank());
		}
		
		//开户名18
		if(Tools.isEmpty(customer.getBankName())){
			customer.setBankName(customerByDB.getBankName());
		}
		
		//银行账号19
		if(Tools.isEmpty(customer.getBankAccount())){
			customer.setBankAccount(customerByDB.getBankAccount());
		}
		

		//省20
		if(customer.getProvince() == null){
			customer.setProvince(customerByDB.getProvince());
		}
		
		//市21
		if(customer.getCity() == null ){
			customer.setCity(customerByDB.getCity());
		}
		
		// 区/县22
		if(customer.getCounty()== null){
			customer.setCounty(customerByDB.getCounty());
		}
		
		//详细地址 23
		if(Tools.isEmpty(customer.getAddress())){
			customer.setAddress(customerByDB.getAddress());
		}
		
		//出资方式24
		if(Tools.isEmpty(customer.getContributionType())){
			customer.setContributionType(customerByDB.getContributionType());
		}
		
		//出资规模25
		if(Tools.isEmpty(customer.getContributionScale())){
			customer.setContributionScale(customerByDB.getContributionScale());
		}
		
		
		//邀约人26
		if(Tools.isEmpty(customer.getAppointment())){
			customer.setAppointment(customerByDB.getAppointment());
		}
		
		//理财顾问27
		if(Tools.isEmpty(customer.getFinancialAdvisor())){
			customer.setFinancialAdvisor(customerByDB.getFinancialAdvisor());
		}
		
		//理财经理28
		if(Tools.isEmpty(customer.getFinancialManager())){
			customer.setFinancialManager(customerByDB.getFinancialManager());
		}
		
		//理财总监29
		if(Tools.isEmpty(customer.getFinancialDirector())){
			customer.setFinancialDirector(customerByDB.getFinancialDirector());
		}
		
		// 备注
		if(Tools.isEmpty(customer.getRemark())){
			customer.setRemark(customerByDB.getRemark());
		}
		return customer;
	}

	

	/**
	 * customer1:来自excel,所以没有id
	 * customer2:来自DB,有id
	 * 如果修改数据,需要把id带上
	 */
	@Override
	public Customer setId(Customer customer1,Customer customer2) {
		customer1.setId(customer2.getId());
		return customer1;
	}



	
}
