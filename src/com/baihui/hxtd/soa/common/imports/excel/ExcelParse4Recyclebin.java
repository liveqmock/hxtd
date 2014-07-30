package com.baihui.hxtd.soa.common.imports.excel;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.baihui.hxtd.soa.base.Constant;
import com.baihui.hxtd.soa.base.ContextLoaderListenerAware;
import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.system.entity.RecyclebinDTO;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.UserService;
import com.baihui.hxtd.soa.util.Tools;
/**
 * 功能描述：导入信息类
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author huizijing
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.excel.ExcelParse4Recyclebin.java
 * @version (版本) 1
 * @date 2014-7-6 上午11:00:53
 *
 */
//@Component
public class ExcelParse4Recyclebin extends ExcelParse<RecyclebinDTO> {

	private Logger logger = LoggerFactory.getLogger(ExcelParse.class);

	
	@Resource
	private UserService userService = (UserService)ContextLoaderListenerAware.ctx.getBean("userService");
	
	/**
	 * 校验第rowNumOfSheet行的数据格式是否正确,并将List<String>类型的数据转换成对象格式
	 * @throws ParseException 
	 */
	@Override
	public RecyclebinDTO checkDataBySheetList(int rowNumOfSheet, List<String> sheetList) throws ParseException {
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
		String recyclebinName = sheetList.get(0);
		if ( Tools.isEmpty(recyclebinName.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,模块名不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		String recyclebinCorporation= sheetList.get(1);
		if ( Tools.isEmpty(recyclebinCorporation.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,记录名不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		String recyclebinRecordId= sheetList.get(2);
		if ( Tools.isEmpty(recyclebinRecordId.trim()) ) {
			msg += "<br />第"+rowNumOfSheet+"条数据,记录Id不能为空!";
			logger.warn(msg);
			//向无效数据集合中添加一条数据
			ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
			return null;
		}
		
		String recyclebinCreator = sheetList.get(3);
		User creator = new User();
		if ( !Tools.isEmpty(recyclebinCreator.trim()) ) {
			//根据id查询操作者
			creator = userService.getByName(recyclebinCreator.trim());
			if(creator==null){
				msg += "<br />第"+rowNumOfSheet+"条数据,操作者不存在!";
				logger.warn(msg);
				//向无效数据集合中添加一条数据
				ImportMessage.invalidFormatRowNumMap.put(rowNumOfSheet, msg);
				return null;
			}
		}
		list.remove(3);
		list.add(3, creator==null?new User():creator);
		
		//修改最后一列的类型为Integer类型
		String rowNumString = sheetList.get(sheetList.size()-1);
		int rowNum = Integer.valueOf(rowNumString);
		list.remove(5);
		list.add(5,rowNum);
		//将其保存为对象
		return RecyclebinDTO.createEntity(list);
	}

	/**
	 * 导入回收站列数
	 */
	@Override
	public int getColumnNum() {
		return Constant.EXCEL_IMPORT_RECYCLEBIN_COLUMNS;
	}

	/**
	 * 查找Excel中的重复数据,并把这些重复数据添加的重复记录集合中
	 * @param entityMap 要查找的实体类Map集合
	 * @param paramList 查找的方式(例如:按手机,邮箱等)
	 */
	@Override
	public void getDuplicateDate(Map<Integer, RecyclebinDTO> entityMap,List<String> paramList) {
		if(paramList==null || paramList.size()==0){
			return;
		}
		//获取所有的参数
		String params = paramList.toString();
		RecyclebinDTO recyclebin1 = null;
		//标记第一个参数是否相同
		boolean flag1 = false;
		//标记第二个参数是否相同
		boolean flag2 = false;
		/*
		 * 判断第一个集合中的数据是否和第二个集合中的数据有重复
		 */
		Set<Integer> keySet1 = entityMap.keySet();
		for(Integer rowNum1:keySet1){
			recyclebin1 = entityMap.get(rowNum1);
			Date createdTime = recyclebin1.getCreatedTime();
			Set<Integer> keySet2 = entityMap.keySet();
			for(Integer rowNum2:keySet2){
				RecyclebinDTO recyclebin2 = entityMap.get(rowNum2);
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
				Date createdTime2 = recyclebin2.getCreatedTime();
				
				/*
				 * 按手机排重
				 * 条件：查重的主键包含createdTime，并且(recyclebin1和recyclebin2的)主键内容不为null，""和"null"。最后判断两个createdTime是否相等
				 */
				if((params.contains("createdTime")) && !Tools.isEmpty(createdTime.toString()) && 
						!Tools.isEmpty(createdTime2.toString()) && (createdTime.equals(createdTime2.toString()))){
					//第一参数相同 b  
					flag1 = true;
					//拼接唯一键
					uniqueString += recyclebin1.getCreatedTime()+"_";
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
					ImportMessage.workbookRepeatRowNums.add(recyclebin1.getExcelRowNum());
					//把重复数据添加到ImportMessage中的workbookRepeats集合中
					AddDuplicateData(uniqueString,recyclebin1.getExcelRowNum());
				}
			}
		}
	}
}
