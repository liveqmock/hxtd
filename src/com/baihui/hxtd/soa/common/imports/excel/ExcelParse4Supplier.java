package com.baihui.hxtd.soa.common.imports.excel;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.ContextLoaderListenerAware;
import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.common.service.PCASService;
import com.baihui.hxtd.soa.project.entity.SupplierDTO;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.UserService;
import com.baihui.hxtd.soa.util.Tools;
/**
 * 功能描述：导入信息类
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.excel.ExcelParse4Lead.java
 * @version (版本) 1
 * @date 2014-7-6 上午11:00:53
 *
 */
//@Component
public class ExcelParse4Supplier extends ExcelParse<SupplierDTO> {

	private Logger logger = LoggerFactory.getLogger(ExcelParse.class);

	@Resource
	private DictionaryService dictionaryService = (DictionaryService)ContextLoaderListenerAware.ctx.getBean("dictionaryService");
	
	@Resource
	private UserService userService = (UserService)ContextLoaderListenerAware.ctx.getBean("userService");
	
	@Resource
	private PCASService pCASService = (PCASService)ContextLoaderListenerAware.ctx.getBean("PCASService");
	
	/**
	 * 校验第rowNumOfSheet行的数据格式是否正确,并将List<String>类型的数据转换成对象格式
	 */
	@Override
	public SupplierDTO checkDataBySheetList(int rowNumOfSheet, List<String> sheetList) {
		String msg = "";
		List<Object> list = new ArrayList<Object>();
		list.addAll(sheetList);
		//行记录是否为空
		if (sheetList == null || sheetList.isEmpty() ) {
			msg += "第"+rowNumOfSheet+"条数据,被解析的集合为空!";
			logger.warn(msg);
			ImportMessage.message = msg;
			return null;
		}
		//必填项
		//供应商名必填项
		String supplierName = sheetList.get(0);
		if ( Tools.isEmpty(supplierName.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,供应商名不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//法人必填项
		String supplierCorporation= sheetList.get(3);
		if ( Tools.isEmpty(supplierCorporation.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,供应商法人不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		//证件号码必填项
		String supplierCardNum= sheetList.get(9);
		if ( Tools.isEmpty(supplierCardNum.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,证件号码不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		
		/**
		 * 校验数据格式
		 */
		//手机号码格式
		String mobile =  sheetList.get(5);
		if(!Tools.isEmpty(mobile)&&!isMobile(mobile)){
			msg += "<br />第"+rowNumOfSheet+"条数据,手机号码内容无效!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//电话号码，符合电话号码格式
		String phone =  sheetList.get(4);
		if (!Tools.isEmpty(phone) && !isPhone(phone) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,电话号码内容无效!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//传真格式，与电话号码相同
		String fax = sheetList.get(7);
		if(!Tools.isEmpty(fax) && !isPhone(fax)){
			msg += "<br />第"+rowNumOfSheet+"条数据,传真内容无效!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//邮箱格式
		String email = sheetList.get(6);
		if(!Tools.isEmpty(email)&&!checkEmail(email)){
			msg += "<br />第"+rowNumOfSheet+"条数据,邮箱内容无效!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//邮编格式
		/*String postCode = sheetList.get(12);
		if(!Tools.isEmpty(postCode)&&!checkPostCode(postCode)){
			msg += "<br />第"+rowNumOfSheet+"条数据,邮编内容无效!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}*/
		
		
		/**
		 * 数据内容校验
		 */
		
		//供应商类型
		String supplierType = sheetList.get(1);
		//供应商类型必填
		if ( Tools.isEmpty(supplierName.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,供应商类型不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		Dictionary type = null;
		if ( !Tools.isEmpty(supplierType.trim()) ) {
			//根据id查询供应商类型(50101)
			type = dictionaryService.getValue(supplierType.trim(), ExcelParse.directoryColumn.get("供应商类型"));
			if(type==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,供应商类型无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(1);
		list.add(1, type==null?new Dictionary():type);
		
		//供应商所有者
		String supplierOwner = sheetList.get(2);
		User owner = new User();
		if ( !Tools.isEmpty(supplierOwner.trim()) ) {
			//根据id查询供应商所有者
			owner = userService.getByName(supplierOwner.trim());
			if(owner==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,供应商所有者不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(2);
		list.add(2, owner==null?new User():owner);
		
		//证件类型
		String supplierCardType = sheetList.get(8);
		//证件类型必填
		if ( Tools.isEmpty(supplierCardType.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,证件类型不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		Dictionary cardType = null;
		if ( !Tools.isEmpty(supplierCardType.trim()) ) {
			//根据id查询供应商证件类型(50101)
			cardType = dictionaryService.getValue(supplierCardType.trim(), ExcelParse.directoryColumn.get("供应商证件类型"));
			if(cardType==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,证件类型无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(8);
		list.add(8, cardType==null?new Dictionary():cardType);
		
		//省
		String supplierProvince = sheetList.get(10);
		PCAS province = null;
		if ( !Tools.isEmpty(supplierProvince.trim()) ) {
			//根据id查询线索状态(40103)
			province = pCASService.getByName(supplierProvince.trim(),0L);
			if(province==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,该省不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(10);
		list.add(10, province);
		
		
		//市
		String supplierCity = sheetList.get(11);
		PCAS city = null;
		if (province!=null && !Tools.isEmpty(supplierCity.trim()) ) {
			//根据id查询线索状态(40103)
			city = pCASService.getByName(supplierCity.trim(),province.getId());
			if(city==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,当前市不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(11);
		list.add(11, city);
		
		//县
		String supplierCounty = sheetList.get(12);
		PCAS county = null;
		if ( city!=null && !Tools.isEmpty(supplierCounty.trim()) ) {
			//根据id查询线索状态(40103)
			county = pCASService.getByName(supplierCounty.trim(),city.getId());
			if(county==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,该县不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
			
		}
		list.remove(12);
		list.add(12, county);
		
		
		//修改最后一列的类型为Integer类型
		String rowNumString = sheetList.get(sheetList.size()-1);
		int rowNum = Integer.valueOf(rowNumString);
		list.remove(15);
		list.add(15,rowNum);
		//将其保存为对象
		return SupplierDTO.createEntity(list);
	}

	/**
	 * 导入线索列数
	 */
	@Override
	public int getColumnNum() {
		return Constant.EXCEL_IMPORT_SUPPLIER_COLUMNS;
	}

	/**
	 * 查找Excel中的重复数据,并把这些重复数据添加的重复记录集合中
	 * @param entityMap 要查找的实体类Map集合
	 * @param paramList 查找的方式(例如:按手机,邮箱等)
	 */
	@Override
	public void getDuplicateDate(Map<Integer, SupplierDTO> entityMap,List<String> paramList) {
		if(paramList==null || paramList.size()==0){
			return;
		}
		//获取所有的参数
		String params = paramList.toString();
		SupplierDTO supplier1 = null;
		//标记第一个参数是否相同
		boolean flag1 = false;
		//标记第二个参数是否相同
		boolean flag2 = false;
		/*
		 * 判断第一个集合中的数据是否和第二个集合中的数据有重复
		 */
		Set<Integer> keySet1 = entityMap.keySet();
		for(Integer rowNum1:keySet1){
			supplier1 = entityMap.get(rowNum1);
			String mobile1 = supplier1.getMobile().trim();
			String email1 = supplier1.getEmail().trim();
			Set<Integer> keySet2 = entityMap.keySet();
			for(Integer rowNum2:keySet2){
				SupplierDTO supplier2 = entityMap.get(rowNum2);
				//和处理自己以外的其他数据比较
				if(rowNum1==rowNum2){
					continue;
				}
				/*
				 * 是否重复的唯一键
				 * 设置这个变量的好处
				 * 1.作为Map中key值
				 * 2.如果比较的两个对象的值都是""或者null,则可以做排空处理
				 */
				String uniqueString = "";
				String mobile2 = supplier2.getMobile().trim();
				String email2 = supplier2.getEmail().trim();
				
				/*
				 * 按手机排重
				 * 条件：查重的主键包含mobile，并且(supplier1和supplier2的)主键内容不为null，""和"null"。最后判断两个mobile是否相等
				 */
				if((params.contains("mobile")) && !Tools.isEmpty(mobile1) && !Tools.isEmpty(mobile2) && (mobile1.equals(mobile2))){
					//第一参数相同 b  
					flag1 = true;
					//拼接唯一键
					uniqueString += supplier1.getMobile()+"_";
					//如果不需要根据email这个参数排重,就将其状态置为true
					if(!params.contains("email")){
						flag2=true;
					}
				}
				//按邮箱排重
				if((params.contains("email")) && !Tools.isEmpty(email1) && !Tools.isEmpty(email2) && (email1.equals(email2))){
					//第二参数相同
					flag2 = true;
					//拼接唯一键
					uniqueString +=supplier1.getName();
					//如果不需要根据mobile这个参数排重,就将其状态置为true
					if(!params.contains("mobile")){
						flag1=true;
					}
				}
				if(!Tools.isEmpty(uniqueString) && (uniqueString.lastIndexOf("_")==(uniqueString.length()-1))){
					uniqueString = uniqueString.substring(0, uniqueString.length()-1);
				}
				
				/*
				 * 判断是重复数据的依据:
				 * 1.如果两个字段的标记都是true,
				 * 2.唯一键不为空(这里的唯一键是具体的唯一键对应的内容.如:name:张三,email:zhangsan@qq.com,那么唯一键uniqueString=张三_zhangsan@qq.com)
				 */
				if(flag1&&flag2 && !uniqueString.trim().isEmpty()){
					//把重复数据的行号添加到ImportMessage中的workbookRepeatRowNums集合中
					ImportMessage.workbookRepeatRowNums.add(supplier1.getExcelRowNum());
					//把重复数据添加到ImportMessage中的workbookRepeats集合中
					AddDuplicateData(uniqueString,supplier1.getExcelRowNum());
				}
			}
		}
	}

	
	
	
	public static void main(String[] args){
		
		
		List<String> list = new ArrayList<String>();
		list.add("mobile");
		String paramsString = list.toString();
		System.out.println(paramsString);
		System.out.println(paramsString.contains("mobile"));
		
	}

}
