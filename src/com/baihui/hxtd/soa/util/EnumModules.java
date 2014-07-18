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


public enum EnumModules {
	
	/** 市场活动 */
	MARKETACTIVITY("marketActivity","市场活动"),

	/** 线索 */
	LEAD("lead","线索"),
	
	/** 联系人 */
	CONTACT("contact","联系人"),
	
	/** 客户 */
	CUSTOMER("customer","客户"),
	
	/** 供应商 */
	SUPPILER("supplier","供应商"),
	
	/** 项目 */
	PROJECT("project","项目"),
	
	
	/** 产品 */
	PRODUCT("product","产品"),
	
	/** 订单 */
	ORDER("order","订单"),
	
	/** 用户 */
	USER("user","用户"),
	
	/** 角色 */
	ROLE("role","角色"),
	
	/** 菜单 */
	MENU("menu","菜单"),
	
	/** 功能 */
	FUNCTION("function","功能"),
	
	/** 组件 */
	COMPONENT("component","组件"),
	
	/** 组织机构 */
	ORGANIZATION("organization","组织机构"),
	
	/** 系统消息 */
	USERMESSAGE("userMessage","系统消息"),
	
	/** 系统公告*/
	NOTICE("notice","系统公告"),
	
	/** 数据字典*/
	DICTIONARY("dictionary","数据字典"),
	
	/**回收站*/
	RECYCLEBIN("recyclebin","回收站"),

    /**报表*/
    REPORT("report","报表")
	;
	
	
	private String moduleName;
	private String moduleChineseName;
	
	
	private EnumModules(String moduleName, String moduleChineseName){
		this.moduleName = moduleName;
		this.moduleChineseName = moduleChineseName;
	}
	
	public String getModuleName(){
		return moduleName;
	}
	public String getModuleChineseName() {
		return moduleChineseName;
	}
}
