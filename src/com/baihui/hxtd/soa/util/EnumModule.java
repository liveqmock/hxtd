package com.baihui.hxtd.soa.util;


/**
 * 功能描述：模块名称枚举
 * 请确保EnumModule的moduleName=实体类类名小写首字母
 * @author jason 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.6 
 * @ClassName: com.baihui.hxtd.soa.util.EnumModule.java
 * @version (版本) 
 * @date 2014-7-3 下午01:45:07
 * 
 */


public enum EnumModule {
	
	/** 市场活动 */
	MARKETACTIVITY("marketActivity"),

	/** 线索 */
	LEAD("lead"),
	
	/** 联系人 */
	CONTACT("contact"),
	
	/** 客户 */
	CUSTOMER("customer"),
	
	/** 供应商 */
	SUPPILER("supplier"),
	
	/** 项目 */
	PROJECT("project"),
	
	
	/** 产品 */
	PRODUCT("product"),
	
	/** 订单 */
	ORDER("order"),
	
	/** 用户 */
	USER("user"),
	
	/** 角色 */
	ROLE("role"),
	
	/** 菜单 */
	MENU("menu"),
	
	/** 功能 */
	FUNCTION("function"),
	
	/** 组件 */
	COMPONENT("component"),
	
	/** 组织机构 */
	ORGANIZATION("organization"),
	
	/** 系统消息 */
	USERMESSAGE("userMessage"),
	
	/** 系统公告*/
	NOTICE("notice"),
	
	/** 数据字典*/
	DICTIONARY("dictionary")
	;
	
	
	private String moduleName;
	
	private EnumModule(String moduleName){
		this.moduleName = moduleName;
	}
	
	public String getModuleName(){
		return moduleName;
	}
}
