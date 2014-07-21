package com.baihui.hxtd.soa.common.imports.excel;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.ContextLoaderListenerAware;
import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.common.service.PCASService;
import com.baihui.hxtd.soa.customer.entity.ContactDTO;
import com.baihui.hxtd.soa.customer.entity.Customer;
import com.baihui.hxtd.soa.customer.service.CustomerService;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
import com.baihui.hxtd.soa.system.service.UserService;
import com.baihui.hxtd.soa.util.Tools;
/**
 * 功能描述：导入信息类
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author ruisong.luan
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.excel.ExcelParse4contact.java
 * @version (版本) 1
 * @date 2014-7-6 上午11:00:53
 *
 */
public class ExcelParse4Contact extends ExcelParse<ContactDTO> {

	private Logger logger = LoggerFactory.getLogger(ExcelParse.class);

	private DictionaryService dictionaryService = (DictionaryService)ContextLoaderListenerAware.ctx.getBean("dictionaryService");
	
	private UserService userService = (UserService)ContextLoaderListenerAware.ctx.getBean("userService");
	
	private PCASService pCASService = (PCASService)ContextLoaderListenerAware.ctx.getBean("PCASService");
	
	private CustomerService customerService= (CustomerService)ContextLoaderListenerAware.ctx.getBean("customerService");
	/**
	 * 校验第rowNumOfSheet行的数据格式是否正确,并将List<String>类型的数据转换成对象格式
	 */
	@Override
	public ContactDTO checkDataBySheetList(int rowNumOfSheet, List<String> sheetList) {
		String msg = "";
		List<Object> list = new ArrayList<Object>();
		list.addAll(sheetList);
		//行记录是否为空
		if (sheetList == null || sheetList.isEmpty() ) {
			msg += "第"+rowNumOfSheet+"条,被解析的集合为空!";
			logger.warn(msg);
			ImportMessage.message = msg;
			return null;
		}
		//必填项
		//姓名必填项
		String contactName = sheetList.get(1);
		if ( contactName == null || "".equals(contactName.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条,联系人姓名不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		//线索所有者,查找联系人所有者的id,如果id存在则返回,如果不存在设置为0
		String contactOwner = sheetList.get(0);
		User owner = null;
		if ( contactOwner != null && !"".equals(contactOwner.trim()) ) {
			//根据id查询联系人所有者
			owner = userService.getByName(contactOwner);
			if(owner==null){
				msg += "<br />第"+rowNumOfSheet+"条,联系人所有者不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(0);
		list.add(0, owner==null?new User():owner);
		
		//线索所有者,查找联系人所有者的id,如果id存在则返回,如果不存在设置为0
		String customer = sheetList.get(2);
		Customer c = null;
		if ( customer != null && !"".equals(customer.trim()) ) {
			//根据id查询联系人所有者
			c = customerService.getByName(customer);
			if(c==null){
				msg += "<br />第"+rowNumOfSheet+"条,关联客户不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(2);
		list.add(2, c==null?new Customer():c);
		
		//线索来源
		String contactSource = sheetList.get(9);
		Dictionary source = null;
		if ( contactSource != null && !"".equals(contactSource.trim()) ) {
			//根据id查询线索来源(40101)
			source = dictionaryService.getValue(contactSource, 40101L);
			if(source==null){
				msg += "<br />第"+rowNumOfSheet+"条,线索来源无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(9);
		list.add(9, source==null?new Dictionary():source);
		
		
		//省
		String contactProvince = sheetList.get(10);
		PCAS province = null;
		if ( contactProvince != null && !"".equals(contactProvince.trim()) ) {
			//根据id查询线索状态(40103)
			province = pCASService.getByName(contactProvince);
			if(province==null){
				msg += "<br />第"+rowNumOfSheet+"条,该省不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(10);
		list.add(10, province==null?new PCAS():province);
		
		
		//市
		String contactCity = sheetList.get(11);
		PCAS city = null;
		if ( contactCity != null && !"".equals(contactCity.trim()) ) {
			//根据id查询线索状态(40103)
			city = pCASService.getByName(contactCity);
			if(city==null){
				msg += "<br />第"+rowNumOfSheet+"条,当前市不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(11);
		list.add(11, city==null?new PCAS():city);
		
		//县
		String contactCounty = sheetList.get(12);
		PCAS county = new PCAS();
		if ( contactCounty != null && !"".equals(contactCounty.trim()) ) {
			//根据id查询线索状态(40103)
			county = pCASService.getByName(contactCounty);
			if(county==null){
				msg += "<br />第"+rowNumOfSheet+"条,该县不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
			
		}
		list.remove(12);
		list.add(12, county==null?new PCAS():county);
		
		//修改最后一列的类型为Integer类型
		String rowNumString = sheetList.get(sheetList.size()-1);
		int rowNum = Integer.valueOf(rowNumString);
		list.remove(16);
		list.add(16,rowNum);
		//将其保存为对象
		return ContactDTO.createEntity(list);
	}

	/**
	 * 导入线索列数
	 */
	@Override
	public int getColumnNum() {
		return Constant.EXCEL_IMPORT_CONTACT_COLUMNS;
	}

	/**
	 * 查找Excel中的重复数据,并把这些重复数据添加的重复记录集合中
	 * @param entityMap 要查找的实体类Map集合
	 * @param paramList 查找的方式(例如:按手机,邮箱等)
	 */
	@Override
	public void getDuplicateDate(Map<Integer, ContactDTO> entityMap,List<String> paramList) {
		if(paramList==null || paramList.size()==0){
			return;
		}
		//获取所有的参数
		String params = paramList.toString();
		ContactDTO contact1 = null;
		//标记第一个参数是否相同
		boolean flag1 = false;
		//标记第二个参数是否相同
		boolean flag2 = false;
		/*
		 * 判断第一个集合中的数据是否和第二个集合中的数据有重复
		 */
		for(Integer rowNum1:entityMap.keySet()){
			contact1 = entityMap.get(rowNum1);
			for(Integer rowNum2:entityMap.keySet()){
				ContactDTO contact2 = entityMap.get(rowNum2);
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
				
				
				/*
				 * 按手机排重
				 * 条件：查重的主键包含mobile，并且(contact1和contact2的)主键内容不为null，""和"null"。最后判断两个mobile是否相等
				 */
				if((params.contains("mobile")) && !Tools.isEmpty(contact1.getMobile().trim()) && !Tools.isEmpty(contact2.getMobile().trim()) && (contact1.getMobile().trim().equals(contact2.getMobile().trim()))){
					//第一参数相同 b  
					flag1 = true;
					//拼接唯一键
					uniqueString += contact1.getMobile()+"_";
					//如果不需要根据email这个参数排重,就将其状态置为true
					if(!params.contains("email")){
						flag2=true;
					}
				}
				//按邮箱排重
				if((params.contains("email")) && !Tools.isEmpty(contact1.getEmail().trim()) && !Tools.isEmpty(contact2.getEmail().trim()) && (contact1.getEmail().equals(contact2.getEmail()))){
					//第二参数相同
					flag2 = true;
					//拼接唯一键
					uniqueString +=contact1.getEmail();
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
					ImportMessage.workbookRepeatRowNums.add(contact1.getExcelRowNum());
					//把重复数据添加到ImportMessage中的workbookRepeats集合中
					AddDuplicateData(uniqueString,contact1.getExcelRowNum());
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
