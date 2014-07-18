package com.baihui.hxtd.soa.common.service.imports;

import java.rmi.dgc.Lease;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.hibernate.metamodel.domain.Superclass;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.customer.entity.Lead;
import com.baihui.hxtd.soa.customer.entity.LeadDB;
import com.baihui.hxtd.soa.system.entity.User;
@Service
@Transactional
public class ImportLeadService extends ImportServiceAbstract<LeadDB,Lead> {

	
	
	/**
	 * 根据"实体类,主键列表"判断是否在数据库中有重复数据,在根据"重复类型"处理重复数据
	 * Map<Integer,Lead>
	 * 其中Integer有两个值1:新增,2:修改
	 */
	@Override
	public Map<Integer, Lead> isAddOrUpdate(LeadDB leadDB, List<String> uniqueString, String duplicateType) {
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
		Map<Integer, Lead> entityMap = new HashMap<Integer, Lead>();
		for(int i = 0; i<uniqueString.size(); i++){
			//获取唯一标记
			String unique = uniqueString.get(i);
			if("email".equals(unique)){
				hqlParam += " and entity.name=? ";
				value += leadDB.getName()+",";
			}
			if("mobile".equals(unique)){
				hqlParam += " and entity.mobile=? ";
				value += leadDB.getMobile()+",";
			}
		}
		value = value.substring(0,value.lastIndexOf(","));
		String[] values = value.split(","); 
		//将LeadDB对象转换成Lead类型的对象
		Lead leadFromExcel = convertT2E(leadDB);
		//根据一个或多个主键查询数据库
		Lead leadFromDB = (Lead)importDao.getByUnique("Lead",hqlParam,values);
		
		if (leadFromDB != null) {
			//如果leadByDB不为空,则查询到重复数据,应该修改,根据记录合并方式进行修改
			entityMap.put(2, super.mergeDataByDuplicateType(leadFromExcel, leadFromDB, duplicateType));
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseRepeatRowNums
			ImportMessage.databaseRepeatRowNums.add(leadDB.getExcelRowNum());
		}else{
		    //如果leadByDB为空,则说明该记录应该是新增
			entityMap.put(1, leadFromExcel);
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseNewRowNums
			ImportMessage.databaseNewRowNums.add(leadDB.getExcelRowNum());
		}
		return entityMap;
	}
	
	/**
	 * 将LeadDB对象转换成Lead类型的对象
	 * convertLeadDBTlLead
	 */
	public Lead convertT2E(LeadDB leadDB) {
		Lead lead = new Lead();
		lead.setOwner(leadDB.getOwner());

		// 公司名称
		lead.setCompany(leadDB.getCompany());

		// 姓名
		lead.setName(leadDB.getName());

		// 部门
		lead.setDepartment(leadDB.getDepartment());

		// 职位
		lead.setPosition(leadDB.getPosition());

		// 邮箱
		lead.setEmail(leadDB.getEmail());

		// 电话
		lead.setPhone(leadDB.getPhone());

		// 传真
		lead.setFax(leadDB.getFax());

		// 手机
		lead.setMobile(leadDB.getMobile());

		// 线索来源
		lead.setSource(leadDB.getSource());
		// 线索状态
		lead.setStatus(leadDB.getStatus());

		// 证件类型
		lead.setCardType(leadDB.getCardType());

		// 证件号码
		lead.setCardNum(leadDB.getCardNum());

		// 行业
		lead.setIndustry(leadDB.getIndustry());

		// 邮编
		lead.setPostCode(leadDB.getPostCode());

		// 省
		lead.setCompany(leadDB.getCompany());

		// 市
		lead.setCity(leadDB.getCity());

		// 区/县
		lead.setCounty(leadDB.getCounty());

		// 详细地址
		lead.setAddress(leadDB.getAddress());

		// 备注
		lead.setRemark(leadDB.getRemark());
		
		

		return lead;

	}
	
	/**
	 *  将两个对象数据合并,将其有值得属性合并,如果都有,lead中的属性覆盖leadByDB中的属性
	 * @param lead
	 * @param leadByDB
	 * @return
	 */
	public Lead mergeData(Lead lead, Lead leadByDB){
		//Id
		lead.setId(leadByDB.getId());
		
		//所有者
		if (lead.getOwner() == null) {
			lead.setOwner(leadByDB.getOwner());
		}
		
		//公司名称
		if(lead.getCompany() == null || "".equals(lead.getCompany())){
			lead.setCompany(leadByDB.getCompany());
		}
		
		//姓名
		if(lead.getName() == null || "".equals(lead.getName())){
			lead.setName(leadByDB.getName());
		}
		
		//部门
		if(lead.getDepartment() == null || "".equals(lead.getDepartment())){
			lead.setDepartment(leadByDB.getDepartment());
		}
		
		//职位
		if(lead.getPosition() == null || "".equals(lead.getPosition())){
			lead.setPosition(leadByDB.getPosition());
		}
		
		//邮箱
		if(lead.getEmail() == null || "".equals(lead.getEmail())){
			lead.setEmail(leadByDB.getEmail());
		}
		
		//电话
		if(lead.getPhone() == null || "".equals(lead.getPhone())){
			lead.setPhone(leadByDB.getPhone());
		}
		
		//传真
		if(lead.getFax() == null || "".equals(lead.getFax())){
			lead.setFax(leadByDB.getFax());
		}
		
		//手机
		if(lead.getMobile() == null || "".equals(lead.getMobile())){
			lead.setMobile(leadByDB.getMobile());
		}
		
		//线索来源
		if(lead.getSource() == null){
			lead.setSource(leadByDB.getSource());
		}
		//线索状态
		if(lead.getStatus() == null){
			lead.setStatus(leadByDB.getStatus());
		}
		
		//证件类型 
		if(lead.getCardType() == null){
			lead.setCardType(leadByDB.getCardType());
		}
		
		//证件号码
		if(lead.getCardNum() == null || "".equals(lead.getCardNum())){
			lead.setCardNum(leadByDB.getCardNum());
		}
		
		//行业 
		if(lead.getIndustry() == null){
			lead.setIndustry(leadByDB.getIndustry());
		}
		
		//邮编
		if(lead.getPostCode() == null || "".equals(lead.getPostCode())){
			lead.setPostCode(leadByDB.getPostCode());
		}
		
		//省
		if(lead.getCompany() == null){
			lead.setCompany(leadByDB.getCompany());
		}
		
		//市
		if(lead.getCity() == null ){
			lead.setCity(leadByDB.getCity());
		}
		
		// 区/县
		if(lead.getCounty()== null){
			lead.setCounty(leadByDB.getCounty());
		}
		
		//详细地址 
		if(lead.getAddress() == null || "".equals(lead.getAddress())){
			lead.setAddress(leadByDB.getAddress());
		}
		
		// 备注
		if(lead.getRemark()== null || "".equals(lead.getRemark())){
			lead.setRemark(leadByDB.getRemark());
		}
		
		
		
		return lead;
	}

	
	
	public static void main(String[] args){
		//集合的主键
		List<String> type=new ArrayList<String>();
		type.add("mobile");
		type.add("email");
		ImportServiceAbstract<LeadDB, Lead> import2db = new ImportLeadService();
		LeadDB leadDB = new LeadDB();
		leadDB.setAddress("北京市");
		leadDB.setCardNum("123456789");
		leadDB.setName("lxl");
		leadDB.setMobile("13636409512");
		leadDB.setEmail("362356441@qq.com");
		List<LeadDB> list = new ArrayList<LeadDB>();
		list.add(leadDB);
		String duplicateType = "忽略";
		//import2db.importData2DB(list, type, duplicateType,user);
	}

	/**
	 * 为对象添加创建人,创建时间,修改人,修改时间
	 * 
	 * @return
	 */
	@Override
	public List<Lead> addCreateAndModifyInfo(List<Lead> lists,User user) {
		
		if(lists==null || lists.size()==0){
			return null;
		}
		for(Lead lead:lists){
			//添加创建时间
			if(lead.getCreator() == null){
				lead.setCreator(user);
			}
			//添加创建人
			if(lead.getCreatedTime() == null){
				lead.setCreatedTime(super.getDBNow());
			}
			//添加修改时间
			lead.setModifiedTime(super.getDBNow());
			//添加修改人
			lead.setModifier(user);
		}
		return lists;
	}

	/**
	 * lead1:来自excel,所以没有id
	 * lead2:来自DB,有id
	 * 如果修改数据,需要把id带上
	 */
	@Override
	public Lead setId(Lead lead1,Lead lead2) {
		lead1.setId(lead2.getId());
		return lead1;
	}



	
}
