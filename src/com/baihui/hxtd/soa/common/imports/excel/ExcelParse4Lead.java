package com.baihui.hxtd.soa.common.imports.excel;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.ContextLoaderListenerAware;
import com.baihui.hxtd.soa.common.entity.PCAS;
import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.common.service.PCASService;
import com.baihui.hxtd.soa.customer.entity.LeadDB;
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
public class ExcelParse4Lead extends ExcelParse<LeadDB> {

	private Logger logger = LoggerFactory.getLogger(ExcelParse.class);

	@Resource
	private DictionaryService dictionaryService = (DictionaryService)ContextLoaderListenerAware.ctx.getBean("dictionaryService");
	
	//@Resource
	private UserService userService = (UserService)ContextLoaderListenerAware.ctx.getBean("userService");
	
	@Resource
	private PCASService pCASService = (PCASService)ContextLoaderListenerAware.ctx.getBean("PCASService");
	/**
	 * 校验第rowNumOfSheet行的数据格式是否正确,并将List<String>类型的数据转换成对象格式
	 */
	@Override
	public LeadDB checkDataBySheetList(int rowNumOfSheet, List<String> sheetList) {
		String msg = "";
		List<Object> list = new ArrayList<Object>();
		list.addAll(sheetList);
		//行记录是否为空
		if (sheetList == null || sheetList.isEmpty() ) {
			msg += "第"+rowNumOfSheet+"行,被解析的集合为空!";
			logger.warn(msg);
			ImportMessage.message = msg;
			return null;
		}
		//必填项
		//姓名必填项
		String contactName = sheetList.get(1);
		if ( contactName == null || "".equals(contactName.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"行,客户姓名不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		//线索所有者,查找客户所有者的id,如果id存在则返回,如果不存在设置为0
		String leadOwner = sheetList.get(0);
		User owner = new User();
		if ( leadOwner != null && !"".equals(leadOwner.trim()) ) {
			//根据id查询客户所有者
			owner = userService.getByName(leadOwner);
			if(owner==null){
				msg += "<br />第"+rowNumOfSheet+"行,客户所有者不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(0);
		list.add(0, owner==null?new User():owner);
		
		//线索来源
		String leadSource = sheetList.get(9);
		Dictionary source = new Dictionary();
		if ( leadSource != null && !"".equals(leadSource.trim()) ) {
			//根据id查询线索来源(40101)
			source = dictionaryService.getValue(leadSource, 40101L);
			if(source==null){
				msg += "<br />第"+rowNumOfSheet+"行,线索来源无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(9);
		list.add(9, source==null?new Dictionary():source);
		
		//线索状态
		String leadStatus = sheetList.get(10);
		Dictionary status = new Dictionary();
		if ( leadStatus != null && !"".equals(leadStatus.trim()) ) {
			//根据id查询线索状态(40102)
			status = dictionaryService.getValue(leadStatus, 40102L);
			//根据leadStatus没有查询到,返回null
			if(status==null){
				msg += "<br />第"+rowNumOfSheet+"行,线索状态无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(10);
		list.add(10, status==null?new Dictionary():status);
		
		//行业
		String leadIndustry = sheetList.get(13);
		Dictionary industry = new Dictionary();
		if ( leadIndustry != null && !"".equals(leadIndustry.trim()) ) {
			//根据id查询线索状态(40305)
			industry = dictionaryService.getValue(leadIndustry, 40305L);
			if(industry==null){
				msg += "<br />第"+rowNumOfSheet+"行,行业无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(13);
		list.add(13, industry==null?new Dictionary():industry);
		
		//卡类型
		String leadCardType = sheetList.get(11);
		Dictionary cardType = new Dictionary();
		if ( leadCardType != null && !"".equals(leadCardType.trim()) ) {
			//根据id查询线索状态(40103)
			cardType = dictionaryService.getValue(leadCardType, 40103L);
			if(cardType==null){
				msg += "<br />第"+rowNumOfSheet+"行,卡类型无效!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(11);
		list.add(11, cardType==null?new Dictionary():cardType);
		
		//省
		String leadProvince = sheetList.get(14);
		PCAS province = new PCAS();
		if ( leadProvince != null && !"".equals(leadProvince.trim()) ) {
			//根据id查询线索状态(40103)
			province = pCASService.getByName(leadProvince);
			if(province==null){
				msg += "<br />第"+rowNumOfSheet+"行,该省不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(14);
		list.add(14, province==null?new PCAS():province);
		
		
		//市
		String leadCity = sheetList.get(15);
		PCAS city = new PCAS();;
		if ( leadCity != null && !"".equals(leadCity.trim()) ) {
			//根据id查询线索状态(40103)
			city = pCASService.getByName(leadCity);
			if(city==null){
				msg += "<br />第"+rowNumOfSheet+"行,当前市不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(15);
		list.add(15, city==null?new PCAS():city);
		
		//县
		String leadCounty = sheetList.get(16);
		PCAS county = new PCAS();;
		if ( leadCounty != null && !"".equals(leadCounty.trim()) ) {
			//根据id查询线索状态(40103)
			county = pCASService.getByName(leadCounty);
			if(county==null){
				msg += "<br />第"+rowNumOfSheet+"行,该县不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
			
		}
		list.remove(16);
		list.add(16, county==null?new PCAS():county);
		
		//修改最后一列的类型为Integer类型
		String rowNumString = sheetList.get(sheetList.size()-1);
		int rowNum = Integer.valueOf(rowNumString);
		list.remove(20);
		list.add(20,rowNum);
		//将其保存为对象
		return new LeadDB().createEntity(list);
	}

	/**
	 * 导入线索列数
	 */
	@Override
	public int getColumnNum() {
		return Constant.EXCEL_IMPORT_lEAD_COLUMNS;
	}

	/**
	 * 查找Excel中的重复数据,并把这些重复数据添加的重复记录集合中
	 * @param entityMap 要查找的实体类Map集合
	 * @param paramList 查找的方式(例如:按手机,邮箱等)
	 */
	@Override
	public void getDuplicateDate(Map<Integer, LeadDB> entityMap,List<String> paramList) {
		if(paramList==null || paramList.size()==0){
			return;
		}
		//获取所有的参数
		String params = paramList.toString();
		LeadDB lead1 = null;
		//标记第一个参数是否相同
		boolean flag1 = false;
		//标记第二个参数是否相同
		boolean flag2 = false;
		/*
		 * 判断第一个集合中的数据是否和第二个集合中的数据有重复
		 */
		for(Integer rowNum1:entityMap.keySet()){
			lead1 = entityMap.get(rowNum1);
			for(Integer rowNum2:entityMap.keySet()){
				LeadDB lead2 = entityMap.get(rowNum2);
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
				 * 条件：查重的主键包含mobile，并且(lead1和lead2的)主键内容不为null，""和"null"。最后判断两个mobile是否相等
				 */
				if((params.contains("mobile")) && !Tools.isEmpty(lead1.getMobile().trim()) && !Tools.isEmpty(lead2.getMobile().trim()) && (lead1.getMobile().trim().equals(lead2.getMobile().trim()))){
					//第一参数相同 b  
					flag1 = true;
					//拼接唯一键
					uniqueString += lead1.getMobile()+"_";
					//如果不需要根据email这个参数排重,就将其状态置为true
					if(!params.contains("email")){
						flag2=true;
					}
				}
				//按邮箱排重
				if((params.contains("email")) && !Tools.isEmpty(lead1.getEmail().trim()) && !Tools.isEmpty(lead2.getEmail().trim()) && (lead1.getEmail().equals(lead2.getEmail()))){
					//第二参数相同
					flag2 = true;
					//拼接唯一键
					uniqueString +=lead1.getEmail();
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
					ImportMessage.workbookRepeatRowNums.add(lead1.getExcelRowNum());
					//把重复数据添加到ImportMessage中的workbookRepeats集合中
					AddDuplicateData(uniqueString,lead1.getExcelRowNum());
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
