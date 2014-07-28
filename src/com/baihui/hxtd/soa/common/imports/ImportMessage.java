package com.baihui.hxtd.soa.common.imports;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

/**
 * 功能描述：导入信息类
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.util.ImportMessage.java
 * @version (版本) 1
 * @date 2014-7-6 上午11:00:53
 *
 */
public class ImportMessage {

	/** 每个excel导入记录限制条数 */
	public final static int LIMIT_COUNT=10001;
	
	/** 导入的excel记录总条数 */
	public static int totalCount;
	
	/** 成功导入数据提示 */
	private String successMessage;
	
	/** 失败导入数据提示 */
	private String failerMessage;
	
	/** 重复数据的excel序号集合{1,20,65} */
	public static Set<Integer> workbookRepeatRowNums = new TreeSet<Integer>();
	
	/**将上面这组数据保存到Map集合中.key=唯一键,value=重复记录的excel序号集合*/
	public static Map<String, Set<Integer>> workbookRepeats = new HashMap<String,Set<Integer>>();
	
	
	/**excel数据格式错误记录的excel序号集合*/
	public static Map<Integer, String> invalidFormatRowNumMap = new HashMap<Integer, String>();
	
	/** 在数据库中已经存在的记录的excel序号集合 */
	public static Set<Integer> databaseRepeatRowNums = new TreeSet<Integer>();
	
	/** 新增到数据库中记录的excel序号集合 */
	public static List<Integer> databaseNewRowNums = new ArrayList<Integer>();

	/**导入的其他消息提示*/
	public static String message;
	
	
	
	/** 
	 * excel导入数据量提示信息
	 */
	public static String limitMessage(){
		String msg = "共导入[" + ImportMessage.totalCount + "]条数据，超过最大导入[" + ImportMessage.LIMIT_COUNT + "]条数据限制的[" + (ImportMessage.totalCount-ImportMessage.LIMIT_COUNT) + "]条数据已忽略";
		return msg;
	}

	/**
	 * 因导入的文件内部自身数据重复导致忽略的记录数以及具体是哪些记录
	 * @param workbookRepeats 重复记录的集合
	 * String:是唯一标识
	 * List<Integer>> : 该唯一标志下重复的记录的序号集合
	 * @return
	 */
	public static String workbookRepeatMessage(){
		StringBuffer msg = new StringBuffer("excel数据内部重复" + ImportMessage.workbookRepeats.size() + "组");
		if(ImportMessage.workbookRepeats.size()>0){
			msg.append(",这"+ImportMessage.workbookRepeats.size()+"组分别是：{");
		
			//循环遍历获取每一组重复记录的序号
			for(String key:ImportMessage.workbookRepeats.keySet()){
				Set<Integer> repeatRowNums = ImportMessage.workbookRepeats.get(key);
				msg.append("[");
				List<Integer> list = new ArrayList<Integer>();
				list.addAll(repeatRowNums);
				for(int i = 0; i<list.size(); i++){
					
					Integer rowNum = list.get(i);
					if(i == list.size()-1){
						msg.append(rowNum + "");
					}else{
						msg.append(rowNum + ", ");
					}
				}
				msg.append("], ");
			}
			//删除最后一个逗号
			msg.deleteCharAt(msg.lastIndexOf(","));
			msg.append("}.导入文件内数据重复的，取最后一条记录");
		}
		
		return msg.toString();
	}
	
	/**
	 * 因数据格式不正确忽略的记录数及具体记录的excel序号
	 * @param InvalidFormatRowNums
	 * @return
	 */
	public static String invalidFormatMessage(){
		StringBuffer msg = new StringBuffer("数据格式["+ ImportMessage.invalidFormatRowNumMap.size() + " ]条"+"错误 。" );
		if (ImportMessage.invalidFormatRowNumMap.size() > 0) {
			Set<Integer> keySet = ImportMessage.invalidFormatRowNumMap.keySet();
			msg.append("他们分别是[" );
			for(Integer key:keySet){
				msg.append( ImportMessage.invalidFormatRowNumMap.get(key) );
				
			}
			
			//msg.deleteCharAt(msg.lastIndexOf(","));
			msg.append("]");
		}

		return msg.toString();
	}
	
	/**
	 * 在数据库中已存在的记录数以及具体记录的excel序号
	 * @param databaseRepeatRowNums
	 * @param type
	 * @return
	 */
	public static String databaseRepeatMessage(String type){
		StringBuffer msg = new StringBuffer("修改数据： [ " + ImportMessage.databaseRepeatRowNums.size() + " ]条");
		if (ImportMessage.databaseRepeatRowNums.size() > 0) {
			msg.append(",他们的Excel行号分别是：[ ");
			for (Integer databaseRepeatRowNum : ImportMessage.databaseRepeatRowNums) {
				msg.append(databaseRepeatRowNum + ", ");
			}
			msg.deleteCharAt(msg.lastIndexOf(","));
			msg.append("],这些数据的处理方式:" + type);
		}
		
		return msg.toString();
	}
	
	
	/**
	 * 新增数据到数据库中的条数
	 * @param databaseNewRowNums
	 * @return
	 */
	public static String databaseNewMessage(){
		String msg = "新增记录：[ " + ImportMessage.databaseNewRowNums.size() + " ]条";
		return msg;
	}
	
	/**
	 * 导入数据结果
	 * 成功导入:新增记录数+修改的记录数
	 * 失败导入:唯一键重复的记录+格式无效的记录
	 * ImportMessage.workbookRepeatRowNums.size()与ImportMessage.workbookRepeats .size()的关系
	 * ImportMessage.workbookRepeatRowNums.size():记录的是所有重复数据的行号,例
	 * 如{1-2-3,4-7,12-34,56-76-89},这里有四组重复数据
	 * ImportMessage.workbookRepeats .size():记录的是每一组重复数据,集合第一个元素:1-2-3,第二个元素4-7,
	 * 第三个元素12-34,第四个元素:56-76-89.这四组数据中只有四条是有效的:那就是3,7,34,89.而剩下的是无效数据
	 * 无效数据的个数就是ImportMessage.workbookRepeatRowNums.size() - ImportMessage.workbookRepeats .size()的结果.
	 * 
	 * @return
	 */
	public static String importResult(){
		StringBuffer msg = new StringBuffer();
		if(ImportMessage.totalCount>=10001){
			msg.append(limitMessage()+",");
		}else {
			msg.append("共导入[" + ImportMessage.totalCount + "]条数据,");
		}
		msg.append("成功导入 [ " + (ImportMessage.databaseNewRowNums.size() + ImportMessage.databaseRepeatRowNums.size() )+ " ]条数据,失败导入[ " + (ImportMessage.workbookRepeatRowNums.size()-ImportMessage.workbookRepeats .size() + invalidFormatRowNumMap.size()) + " ]条数据");
		return msg.toString();
	}
	
	public static void main(String[] args){
		StringBuffer msg = new StringBuffer("abcde,,");
		msg.deleteCharAt(msg.lastIndexOf(","));
		msg.append("}");
		System.out.println(msg.toString());
	}
	
	
	

	public String getSuccessMessage() {
		return successMessage;
	}

	public void setSuccessMessage(String successMessage) {
		this.successMessage = successMessage;
	}

	public String getFailerMessage() {
		return failerMessage;
	}

	public void setFailerMessage(String failerMessage) {
		this.failerMessage = failerMessage;
	}





	public static Map<String, Set<Integer>> getWorkbookRepeats() {
		return workbookRepeats;
	}

	public static void setWorkbookRepeats(Map<String, Set<Integer>> workbookRepeats) {
		ImportMessage.workbookRepeats = workbookRepeats;
	}

	public static Map<Integer, String> getInvalidFormatRowNumMap() {
		return invalidFormatRowNumMap;
	}

	public static void setInvalidFormatRowNumMap(
			Map<Integer, String> invalidFormatRowNumMap) {
		ImportMessage.invalidFormatRowNumMap = invalidFormatRowNumMap;
	}


	public static String getMessage() {
		return message;
	}

	public static void setMessage(String message) {
		ImportMessage.message = message;
	}

	public static int getLimitCount() {
		return LIMIT_COUNT;
	}


	
	
}
