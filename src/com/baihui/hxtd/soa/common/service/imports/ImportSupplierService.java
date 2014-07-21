package com.baihui.hxtd.soa.common.service.imports;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.project.entity.Supplier;
import com.baihui.hxtd.soa.project.entity.SupplierDTO;
import com.baihui.hxtd.soa.util.Tools;
@Service
@Transactional
public class ImportSupplierService extends ImportServiceAbstract<SupplierDTO,Supplier> {

	
	
	/**
	 * 根据"实体类,主键列表"判断是否在数据库中有重复数据,在根据"重复类型"处理重复数据
	 * Map<Integer,Product>
	 * 其中Integer有两个值1:新增,2:修改
	 */
	@Override
	public Map<Integer, Supplier> isAddOrUpdate(SupplierDTO supplierDTO, List<String> uniqueString, String duplicateType) {
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
		Map<Integer, Supplier> entityMap = new HashMap<Integer, Supplier>();
		for(int i = 0; i<uniqueString.size(); i++){
			//获取唯一标记
			String unique = uniqueString.get(i);
			if("email".equals(unique)){
				hqlParam += " and entity.email=? ";
				value += supplierDTO.getEmail()+",";
			}
			if("mobile".equals(unique)){
				hqlParam += " and entity.mobile=? ";
				value += supplierDTO.getMobile()+",";
			}
		}
		value = value.substring(0,value.lastIndexOf(","));
		String[] values = value.split(","); 
		//将SupplierDTO对象转换成Supplier类型的对象
		Supplier supplierFromExcel = convertT2E(supplierDTO);
		//根据一个或多个主键查询数据库
		Supplier supplierFromDB = (Supplier)importDao.getByUnique("Supplier",hqlParam,values);
		
		if (supplierFromDB != null) {
			//如果supplierByDB不为空,则查询到重复数据,应该修改,根据记录合并方式进行修改
			entityMap.put(2, super.mergeDataByDuplicateType(supplierFromExcel, supplierFromDB, duplicateType));
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseRepeatRowNums
			ImportMessage.databaseRepeatRowNums.add(supplierDTO.getExcelRowNum());
		}else{
		    //如果supplierByDB为空,则说明该记录应该是新增
			entityMap.put(1, supplierFromExcel);
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseNewRowNums
			ImportMessage.databaseNewRowNums.add(supplierDTO.getExcelRowNum());
		}
		return entityMap;
	}
	
	/**
	 * 将SupplierDTO对象转换成Supplier类型的对象
	 * convertSupplierDTO2Supplier
	 */
	public Supplier convertT2E(SupplierDTO supplierDTO) {
		Supplier supplier = new Supplier();
		
		// 供应商名称
		supplier.setName(supplierDTO.getName());

		// 供应商类型
		supplier.setType(supplierDTO.getType());

		// 供应商所有者
		supplier.setOwner(supplierDTO.getOwner());

		// 法人
		supplier.setCorporation(supplierDTO.getCorporation());

		// 电话
		supplier.setPhone(supplierDTO.getPhone());
		
		// 手机
		supplier.setMobile(supplierDTO.getMobile());
		
		// 邮箱
		supplier.setEmail(supplierDTO.getEmail());

		// 传真
		supplier.setFax(supplierDTO.getFax());
		
		// 证件类型
		supplier.setCardType(supplierDTO.getCardType());

		// 证件号码
		supplier.setCardNum(supplierDTO.getCardNum());
		
		// 省
		supplier.setProvince(supplierDTO.getProvince());

		// 市
		supplier.setCity(supplierDTO.getCity());

		// 区/县
		supplier.setCounty(supplierDTO.getCounty());

		// 详细地址
		supplier.setAddress(supplierDTO.getAddress());
		
		// 备注
		supplier.setRemark(supplierDTO.getRemark());

		return supplier;

	}
	
	/**
	 *  将两个对象数据合并,将其有值得属性合并,如果都有,supplier中的属性覆盖supplierByDB中的属性
	 * @param supplier
	 * @param supplierByDB
	 * @return
	 */
	public Supplier mergeData(Supplier supplier, Supplier supplierByDB){
		//Id
		supplier.setId(supplierByDB.getId());
		
		//供应商名
		if (Tools.isEmpty(supplier.getName())) {
			supplier.setName(supplierByDB.getName());
		}
		
		//产品类型
		if(supplier.getType() == null){
			supplier.setType(supplierByDB.getType());
		}
		
		//所有者
		if(supplier.getOwner() == null){
			supplier.setOwner(supplierByDB.getOwner());
		}
		
		//法人代表
		if(Tools.isEmpty(supplier.getCorporation())){
			supplier.setCorporation(supplierByDB.getCorporation());
		}
		
		
		//电话
		if(Tools.isEmpty(supplier.getPhone())){
			supplier.setPhone(supplierByDB.getPhone());
		}
		
		//手机
		if(Tools.isEmpty(supplier.getMobile())){
			supplier.setMobile(supplierByDB.getMobile());
		}
		
		//邮箱
		if(Tools.isEmpty(supplier.getEmail())){
			supplier.setEmail(supplierByDB.getEmail());
		}
		
		//传真
		if(Tools.isEmpty(supplier.getFax())){
			supplier.setFax(supplierByDB.getFax());
		}
		
		
		//证件类型
		if(supplier.getCardType() == null){
			supplier.setCardType(supplierByDB.getCardType());
		}
		
		// 证件号码
		if(Tools.isEmpty(supplier.getCardNum())){
			supplier.setCardNum(supplierByDB.getCardNum());
		}
		
		//省
		if(supplier.getProvince() == null){
			supplier.setProvince(supplierByDB.getProvince());
		}
		
		//市
		if(supplier.getCity() == null ){
			supplier.setCity(supplierByDB.getCity());
		}
		
		// 区/县
		if(supplier.getCounty()== null){
			supplier.setCounty(supplierByDB.getCounty());
		}
		
		//详细地址 
		if(Tools.isEmpty(supplier.getAddress())){
			supplier.setAddress(supplierByDB.getAddress());
		}
		
		// 备注
		if(Tools.isEmpty(supplier.getRemark())){
			supplier.setRemark(supplierByDB.getRemark());
		}
		
		
		
		return supplier;
	}

	
	
	public static void main(String[] args){
		//集合的主键
		/*List<String> type=new ArrayList<String>();
		type.add("mobile");
		type.add("email");
		ImportServiceAbstract<ProductDTO, Product> import2db = new ImportProductService();
		ProductDTO productDTO = new ProductDTO();
		productDTO.setAddress("北京市");
		productDTO.setCardNum("123456789");
		productDTO.setName("lxl");
		productDTO.setMobile("13636409512");
		productDTO.setEmail("362356441@qq.com");
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		list.add(productDTO);
		String duplicateType = "忽略";
		//import2db.importData2DB(list, type, duplicateType,user);
*/	}

	

	/**
	 * supplier1:来自excel,所以没有id
	 * supplier2:来自DB,有id
	 * 如果修改数据,需要把id带上
	 */
	@Override
	public Supplier setId(Supplier supplier1,Supplier supplier2) {
		supplier1.setId(supplier2.getId());
		return supplier1;
	}



	
}
