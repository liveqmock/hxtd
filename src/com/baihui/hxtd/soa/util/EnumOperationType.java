package com.baihui.hxtd.soa.util;


/**
 * 功能描述：操作类型枚举
 * @author jason
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @since (该版本支持的 JDK 版本) ： 1.6
 * @ClassName: com.baihui.hxtd.soa.util.EnumModule.java
 * @version (版本)
 * @date 2014-7-3 下午01:45:07
 */

public enum EnumOperationType {

	/**增加*/
	ADD(1,"增加"),

	/**修改*/
	MODIFY(2,"修改"),

	/** 逻辑删除 */
	LOGIC_DELETE(3,"逻辑删除"),

	/** 删除（清空） */
	DELETE(4,"删除"),

	/** 导入 */
	IMPORT(5,"导入"),

	/** 导出 */
	EXPORT(6,"导出"),

    /** 授权 */
    AUTHORIZATION(7,"授权"),
    
    /** 重置密码 */
    RESETPASSWORD(8,"重置密码"),
    
    /**启用用户*/
    ENABLE(9,"启用用户"),
    
    /**禁用用户*/
    DISABLE(10,"禁用用户"),
    
    /**修改密码*/
    MODIFYPASSWORD(11,"修改密码"),
    
    /**真实删除数据*/
    DELETEREAL(12,"物理删除"),
    
    /**恢复数据*/
    RECOVERY(13,"恢复数据"),
    
    /**线索转客户*/
    MODIFYLEADCONVERTER(14,"线索转客户")
    ;

	private int operationType;

	private String operationChineseName;
	
	
	private EnumOperationType(int operationType, String operationChineseName) {
		this.operationType = operationType;
		this.operationChineseName = operationChineseName;
	}

	public String getOperationChineseName() {
		return operationChineseName;
	}

	public void setOperationChineseName(String operationChineseName) {
		this.operationChineseName = operationChineseName;
	}

	private EnumOperationType(int operationType){
		this.operationType = operationType;
	}

	public int getOperationType(){
		return operationType;
	}
}
