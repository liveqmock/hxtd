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
import com.baihui.hxtd.soa.customer.entity.CustomerDTO;
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
public class ExcelParse4Customer extends ExcelParse<CustomerDTO> {

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
	public CustomerDTO checkDataBySheetList(int rowNumOfSheet, List<String> sheetList) {
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
		//姓名必填项
		String name = sheetList.get(1);
		if ( Tools.isEmpty(name.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,客户名不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//公司必填项
		String company = sheetList.get(2);
		if ( Tools.isEmpty(company.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,公司不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		
		
		/**
		 * 校验数据格式
		 */
		//手机号码格式
		String mobile =  sheetList.get(4);
		//手机号码必填项
		if ( Tools.isEmpty(mobile.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,手机号码不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		if(!isMobile(mobile)){
			msg += "<br />第"+rowNumOfSheet+"条数据,手机号码格式不正确!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		
		//电话号码格式
		String phone =  sheetList.get(3);
		if ( Tools.isEmpty(phone.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,电话号码不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		if(!isPhone(phone)){
			msg += "<br />第"+rowNumOfSheet+"条数据,电话号码格式不正确!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		
		//传真格式，与电话号码相同
		String fax = sheetList.get(6);
		if(!Tools.isEmpty(fax) && !isPhone(fax)){
			msg += "<br />第"+rowNumOfSheet+"条数据,传真格式不正确!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		
		//邮箱格式
		String email = sheetList.get(5);
		if(!Tools.isEmpty(email)&&!checkEmail(email)){
			msg += "<br />第"+rowNumOfSheet+"条数据,邮箱格式不正确!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//邮编格式
		String postCode = sheetList.get(15);
		if(!Tools.isEmpty(postCode)&&!checkPostCode(postCode)){
			msg += "<br />第"+rowNumOfSheet+"条数据,邮编格式不正确!";
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		/**
		 * 校验必填,以及校验数据内容是否正确
		 */
		//客户所有者,查找客户所有者的id,如果id存在则返回,如果不存在设置为0
		String customerOwner = sheetList.get(0);
		//客户所有者必填
		if ( Tools.isEmpty(customerOwner.trim())) {
			msg += "<br />第"+rowNumOfSheet+"条数据,客户所有者不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//校验数据内容是否正确
		User owner = null;
		if ( !Tools.isEmpty(customerOwner.trim()) ) {
			//根据id查询客户所有者
			owner = userService.getByName(customerOwner.trim());
			if(owner==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,客户所有者不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(0);
		list.add(0, owner==null?new User():owner);
		
		//来源
		String customerSource = sheetList.get(7);
		//来源必填
		if ( Tools.isEmpty(customerOwner.trim())) {
			msg += "<br />第"+rowNumOfSheet+"条数据,客户来源不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//校验数据内容是否正确
		Dictionary source = null;
		if ( !Tools.isEmpty(customerSource.trim()) ) {
			//根据id查询线索来源(40101)
			source = dictionaryService.getValue(customerSource.trim(), ExcelParse.directoryColumn.get("客户来源"));
			if(source==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,客户来源无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(7);
		list.add(7, source==null?new Dictionary():source);
	
		
		//行业
		String customerIndustry = sheetList.get(8);
		//行业必填
		if ( Tools.isEmpty(customerIndustry.trim())) {
			msg += "<br />第"+rowNumOfSheet+"条数据,行业不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		//校验数据内容是否正确
		Dictionary industry = null;
		if ( !Tools.isEmpty(customerIndustry.trim()) ) {
			//根据id查询线索状态(40305)
			industry = dictionaryService.getValue(customerIndustry.trim(), ExcelParse.directoryColumn.get("客户行业"));
			if(industry==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,行业无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(8);
		list.add(8, industry==null?new Dictionary():industry);
		
		//客户类型
		String customerType = sheetList.get(9);
		Dictionary type = null;
		if ( !Tools.isEmpty(customerType.trim()) ) {
			//根据id查询线索状态(40102)
			type = dictionaryService.getValue(customerType.trim(), ExcelParse.directoryColumn.get("客户类型"));
			//根据customerType没有查询到,返回null
			if(type==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,客户类型无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(9);
		list.add(9, type==null?new Dictionary():type);
		
		//风险等级
		String customerRiskGrade = sheetList.get(10);
		Dictionary riskGrade = null;
		if ( !Tools.isEmpty(customerRiskGrade.trim()) ) {
			//根据id查询线索状态(40102)
			riskGrade = dictionaryService.getValue(customerRiskGrade.trim(), ExcelParse.directoryColumn.get("风险等级"));
			//根据customerType没有查询到,返回null
			if(riskGrade==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,风险等级无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(10);
		list.add(10, riskGrade==null?new Dictionary():riskGrade);
		
		
		//证件类型
		String customerCardType = sheetList.get(11);
		Dictionary cardType = null;
		if ( !Tools.isEmpty(customerCardType.trim()) ) {
			//根据id查询线索状态(40103)
			cardType = dictionaryService.getValue(customerCardType.trim(), ExcelParse.directoryColumn.get("证件类型"));
			if(cardType==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,证件类型无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(11);
		list.add(11, cardType==null?new Dictionary():cardType);
		
		//邀约人
		String customerAppointment = sheetList.get(26);
		User appointment = null;
		if (! Tools.isEmpty(customerAppointment.trim()) ) {
			//根据id查询邀约人
			appointment = userService.getByName(customerAppointment.trim());
			if(appointment==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,邀约人无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(26);
		list.add(26, appointment==null?new User():appointment);
		
		//理财顾问
		String customerFinancialAdvisor = sheetList.get(27);
		User financialAdvisor = null;
		if ( !Tools.isEmpty(customerFinancialAdvisor.trim()) ) {
			//根据id查询客户所有者
			financialAdvisor = userService.getByName(customerFinancialAdvisor.trim());
			if(financialAdvisor==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,理财顾问无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(27);
		list.add(27, financialAdvisor==null?new User():financialAdvisor);
		
		//理财经理
		String customerFinancialManager = sheetList.get(28);
		User financialManager = null;
		if ( !Tools.isEmpty(customerFinancialManager.trim()) ) {
			financialManager = userService.getByName(customerFinancialManager.trim());
			if(cardType==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,理财经理无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(28);
		list.add(28, financialManager==null?new User():financialManager);

		//理财总监
		String customerFinancialDirector = sheetList.get(28);
		User financialDirector = null;
		if ( !Tools.isEmpty(customerFinancialDirector.trim()) ) {
			financialDirector = userService.getByName(customerFinancialDirector.trim());
			if(financialDirector==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,理财总监无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(29);
		list.add(29, financialDirector==null?new User():financialDirector);
		//所有权
		String customerOwnerShip = sheetList.get(16);
		Dictionary ownerShip = new Dictionary();
		if (! Tools.isEmpty(customerOwnerShip.trim()) ) {
			//根据id查询线索状态(40103)
			ownerShip = dictionaryService.getValue(customerOwnerShip.trim(), ExcelParse.directoryColumn.get("所有权"));
			if(ownerShip==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,所有权无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(16);
		list.add(16, ownerShip==null?new Dictionary():ownerShip);
		
		//开户银行
		String customerOpenBank = sheetList.get(17);
		Dictionary openBank = new Dictionary();
		if ( !Tools.isEmpty(customerOpenBank.trim()) ) {
			//根据id查询线索状态(40103)
			openBank = dictionaryService.getValue(customerOpenBank.trim(), ExcelParse.directoryColumn.get("开户行"));
			if(openBank==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,开户银行无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(17);
		list.add(17, openBank==null?new Dictionary():openBank);
		
		
		//省
		String customerProvince = sheetList.get(20);
		PCAS province = null;
		if (! Tools.isEmpty(customerProvince.trim()) ) {
			province = pCASService.getByName(customerProvince.trim(),0L);
			if(province==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,该省不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(20);
		list.add(20, province);
		
		
		//市
		String customerCity = sheetList.get(21);
		PCAS city = null;
		if (province!=null && !Tools.isEmpty(customerCity.trim()) ) {
			city = pCASService.getByName(customerCity.trim(),province.getId());
			if(city==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,该市不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(21);
		list.add(21, city);
		
		//县
		String customerCounty = sheetList.get(22);
		PCAS county = null;
		if (city != null && !Tools.isEmpty(customerCounty.trim()) ) {
			county = pCASService.getByName(customerCounty.trim(),city.getId());
			if(county==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,该县不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
			
		}
		list.remove(22);
		list.add(22, county);
		
		
		
		//修改最后一列的类型为Integer类型
		String rowNumString = sheetList.get(sheetList.size()-1);
		int rowNum = Integer.valueOf(rowNumString);
		list.remove(31);
		list.add(31,rowNum);
		//将其保存为对象
		return CustomerDTO.createEntity(list);
	}

	/**
	 * 导入线索列数
	 */
	@Override
	public int getColumnNum() {
		return Constant.EXCEL_IMPORT_CUSTOMER_COLUMNS;
	}

	/**
	 * 查找Excel中的重复数据,并把这些重复数据添加的重复记录集合中
	 * @param entityMap 要查找的实体类Map集合
	 * @param paramList 查找的方式(例如:按手机,邮箱等)
	 */
	@Override
	public void getDuplicateDate(Map<Integer, CustomerDTO> entityMap,List<String> paramList) {
		if(paramList==null || paramList.size()==0){
			return;
		}
		//获取所有的参数
		String params = paramList.toString();
		CustomerDTO customer1 = null;
		//标记第一个参数是否相同
		boolean flag1 = false;
		//标记第二个参数是否相同
		boolean flag2 = false;
		/*
		 * 判断第一个集合中的数据是否和第二个集合中的数据有重复
		 */
		Set<Integer> keySet1 = entityMap.keySet();
		for(Integer rowNum1:keySet1){
			customer1 = entityMap.get(rowNum1);
			String mobile1 = customer1.getMobile().trim();
			String email1 = customer1.getEmail().trim();
			Set<Integer> keySet2 = entityMap.keySet();
			for(Integer rowNum2:keySet2){
				CustomerDTO customer2 = entityMap.get(rowNum2);
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
				String mobile2 = customer2.getMobile().trim();
				String email2 = customer2.getEmail().trim();
				
				/*
				 * 按手机排重
				 * 条件：查重的主键包含mobile，并且(customer1和customer2的)主键内容不为null，""和"null"。最后判断两个mobile是否相等
				 */
				if((params.contains("mobile")) && !Tools.isEmpty(mobile1) && !Tools.isEmpty(mobile2) && (mobile1.equals(mobile2))){
					//第一参数相同 b  
					flag1 = true;
					//拼接唯一键
					uniqueString += customer1.getMobile()+"_";
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
					uniqueString +=customer1.getEmail();
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
					ImportMessage.workbookRepeatRowNums.add(customer1.getExcelRowNum());
					//把重复数据添加到ImportMessage中的workbookRepeats集合中
					AddDuplicateData(uniqueString,customer1.getExcelRowNum());
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
