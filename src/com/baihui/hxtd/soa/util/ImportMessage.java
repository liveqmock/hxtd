package com.baihui.hxtd.soa.util;

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
	private  int totalCount;
	
	/** 成功导入数据提示 */
	private String successMessage;
	
	/** 失败导入数据提示 */
	private String failerMessage;
	
	/** 重复数据的excel序号集合{1,20,65} */
	public static Set<Integer> workbookRepeatRowNums = new TreeSet<Integer>();
	
	/**将上面这组数据保存到Map集合中.key=唯一键,value=重复记录的excel序号集合*/
	public static Map<String, Set<Integer>> workbookRepeats = new HashMap<String,Set<Integer>>();
	
	/**格式错误记录的excel序号集合*/
	public static List<Integer> invalidFormatRowNums;
	public static Map<Integer, String> invalidFormatRowNumMap;
	
	/** 在数据库中已经存在的记录的excel序号集合 */
	private Set<Integer> databaseRepeatRowNums;
	
	/** 新增到数据库中记录的excel序号集合 */
	private List<Integer> databaseNewRowNums;

	/**导入的其他消息提示*/
	public static String message;
	
	
	
	/** 
	 * excel导入数据量提示信息
	 */
	public static String limitMessage(int totalCount){
		String msg = "共导入" + totalCount + "条，超过最大导入" + ImportMessage.LIMIT_COUNT + "条限制的" + (totalCount-ImportMessage.LIMIT_COUNT) + "条数据已忽略";
		return msg;
	}

	/**
	 * 因导入的文件内部自身数据重复导致忽略的记录数以及具体是哪些记录
	 * @param workbookRepeats 重复记录的集合
	 * String:是唯一标识
	 * List<Integer>> : 该唯一标志下重复的记录的序号集合
	 * @return
	 */
	public String workbookRepeatMessage(Map<String, List<Integer>> workbookRepeats){
		if(workbookRepeats == null){
			workbookRepeats = new HashMap<String, List<Integer>>();
		}
		StringBuffer msg = new StringBuffer("因导入的文件内部自身数据重复导致忽略的记录有" + workbookRepeats.size() + "组,这几组分别是:{");
		//循环遍历获取每一组重复记录的序号
		for(String key:workbookRepeats.keySet()){
			List<Integer> repeatRowNums = workbookRepeats.get(key);
			msg.append("[");
			for(int i = 0; i<repeatRowNums.size(); i++){
				Integer rowNum = repeatRowNums.get(i);
				if(i == repeatRowNums.size()-1){
					msg.append(rowNum + "");
				}else{
					msg.append(rowNum + ", ");
				}
			}
			msg.append("], ");
		}
		//删除最后一个逗号
		msg.deleteCharAt(msg.lastIndexOf(","));
		msg.append("}.导入文件内数据重复的，使用最后一条记录");
		
		return msg.toString();
	}
	
	/**
	 * 因数据格式不正确忽略的记录数及具体记录的excel序号
	 * @param InvalidFormatRowNums
	 * @return
	 */
	public String invalidFormatMessage(List<Integer> InvalidFormatRowNums){
		StringBuffer msg = new StringBuffer("因数据格式不正确忽略" + InvalidFormatRowNums.size() + "条,他们分别是第[");
		if(InvalidFormatRowNums == null){
			InvalidFormatRowNums = new ArrayList<Integer>();
		}
		for(int i=0; i<InvalidFormatRowNums.size(); i++){
			msg.append(InvalidFormatRowNums.get(i)+", ");
		}
		msg.deleteCharAt(msg.lastIndexOf(","));
		msg.append("]");
		
		return msg.toString();
	}
	
	/**
	 * 在数据库中已存在的记录数以及具体记录的excel序号
	 * @param databaseRepeatRowNums
	 * @param type
	 * @return
	 */
	public String databaseRepeatMessage(List<Integer> databaseRepeatRowNums,String type){
		StringBuffer msg = new StringBuffer("有" + databaseRepeatRowNums.size() + "条数据在数据库中已存在,他们分别是第[");
		if(databaseRepeatRowNums == null){
			databaseRepeatRowNums = new ArrayList<Integer>();
		}
		for(int i=0; i<databaseRepeatRowNums.size(); i++){
			msg.append(databaseRepeatRowNums.get(i)+", ");
		}
		msg.deleteCharAt(msg.lastIndexOf(","));
		msg.append("],按照您选择的方式,这些数据的处理方式是:" + type);
		
		return msg.toString();
	}
	
	
	/**
	 * 新增数据到数据库中的条数
	 * @param databaseNewRowNums
	 * @return
	 */
	public String databaseNewMessage(List<Integer> databaseNewRowNums){
		String msg = "新增记录" + databaseNewRowNums.size() + "条";
		return msg;
	}
	
	/**
	 * 导入数据结果
	 * 成功导入:新增记录数+修改的记录数
	 * 失败导入:唯一键重复的记录+格式无效的记录
	 * @return
	 */
	public String importResult(){
		String msg = "成功导入" + (databaseNewRowNums.size() + databaseRepeatRowNums.size() )+ "条,失败导入" + (workbookRepeatRowNums.size()-workbookRepeats .size()+invalidFormatRowNums.size()) + "条";
		return msg;
	}
	
	public static void main(String[] args){
		StringBuffer msg = new StringBuffer("abcde,,");
		msg.deleteCharAt(msg.lastIndexOf(","));
		msg.append("}");
		System.out.println(msg.toString());
	}
	
	
	

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
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


	public List<Integer> getInvalidFormatRowNums() {
		return invalidFormatRowNums;
	}

	

	public List<Integer> getDatabaseNewRowNums() {
		return databaseNewRowNums;
	}

	public void setDatabaseNewRowNums(List<Integer> databaseNewRowNums) {
		this.databaseNewRowNums = databaseNewRowNums;
	}

	public Set<Integer> getWorkbookRepeatRowNums() {
		return workbookRepeatRowNums;
	}

	public void setWorkbookRepeatRowNums(Set<Integer> workbookRepeatRowNums) {
		this.workbookRepeatRowNums = workbookRepeatRowNums;
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

	public Set<Integer> getDatabaseRepeatRowNums() {
		return databaseRepeatRowNums;
	}

	public static void setInvalidFormatRowNums(List<Integer> invalidFormatRowNums) {
		ImportMessage.invalidFormatRowNums = invalidFormatRowNums;
	}

	public void setDatabaseRepeatRowNums(Set<Integer> databaseRepeatRowNums) {
		this.databaseRepeatRowNums = databaseRepeatRowNums;
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
