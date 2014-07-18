
package com.baihui.hxtd.soa.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 * 功能描述： 工具类
 * @author ruisong.luan 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.util.Tools.java
 * @version (版本)1 
 * @date 2014-6-30 上午11:01:42
 */
public class Tools {
	/**
	 * 
	  * fomatDate(格式化日期)
	  * @Title: fomatDate
	  * @param @param fomatStr日期格式
	  * @param @param date 日期参数
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	public static String fomatDate(String fomatStr,Date date){
		SimpleDateFormat dateformat1=new SimpleDateFormat(fomatStr);
		return dateformat1.format(date);
	}
	
	/**
	 * 
	  * fomatDate(格式化当前日期)
	  * @Title: fomatDate
	  * @param @param fomatStr
	  * @param @return    参数类型
	  * @return String    返回类型
	  * @throws
	 */
	public static String fomatDate(String fomatStr){
		return fomatDate(fomatStr,new Date());
	}
	
	/**
	 * 将Date类型的日期转换成String类型的日期
	 * @param Patten
	 * @param date
	 * @return
	 */
	private static String dateToStr(String Patten, Date date) {
		String str = null;
		SimpleDateFormat format = new SimpleDateFormat(Patten);
		if(date!=null){
			try{
				str = format.format(date);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return str;
	}

	
	
	/**
	 * 时间转字符串(yyyy-MM-dd HH:mm:ss格式),不含有提示信息
	 * @param datetime
	 * @return
	 */
	public static String datetimeToStr(Date datetime) {
		String str="";
		if(datetime!=null){
			str = dateToStr("yyyy-MM-dd HH:mm:ss", datetime);
		}
		return str;
	}
	
	/**
	 * 去掉字符串前后的空格
	 * @param tip 提示信息
	 * @param str 要转换的字符串
	 * @return
	 */
	public static String trim(String str){
		String s = "";
		if ( str != null && !"".equals(str)){
			s = str.trim();
		}
		return s;
	}
	
	/**
	 * 校验日期格式是否正确
	 * @param date
	 * @return
	 */
	public static boolean validateDateAndTimeFormat(String date) {
		String eL = "^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-9]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$";
		Pattern p = Pattern.compile(eL);
		Matcher m = p.matcher(date);
		return m.matches();

	}
	
	public static boolean isEmpty(String str){
		if("".equals(str) || str == null || str == "null"){
			return true;
		}else {
			return false;
		}
	}
	
	public static void main(String[] args){
		 String checkValue = "2008/03/31 14:17:11";  
	        String eL= "^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-9]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$";  
	        Pattern p = Pattern.compile(eL);   
	        Matcher m = p.matcher(checkValue);   
	        boolean b = m.matches();  
	        System.out.println(b);
	  
	    }  

}
