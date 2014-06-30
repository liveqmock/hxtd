
package com.baihui.hxtd.soa.util;

import java.text.SimpleDateFormat;
import java.util.Date;

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
}
