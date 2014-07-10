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

	ADD(1),

	MODIFY(2),

	/** 逻辑删除 */
	LOGIC_DELETE(3),

	/** 删除（清空） */
	DELETE(4),

	/** 导入 */
	IMPORT(5),

	/** 导出 */
	EXPORT(6),

    /** 授权 */
    AUTHORIZATION(7),
    
    /** 重置密码 */
    RESETPASSWORD(8),
    
    /**启用用户*/
    ENABLE(9),
    
    /**禁用用户*/
    DISABLE(10),
    
    /**修改密码*/
    MODIFYPASSWORD(11),
    
    /**真实删除数据*/
    DELETEREAL(12),
    
    /**恢复数据*/
    RECOVERY(13)
    ;

	private int operationType;

	private EnumOperationType(int operationType){
		this.operationType = operationType;
	}

	public int getOperationType(){
		return operationType;
	}
}
