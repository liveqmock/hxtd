package com.baihui.hxtd.soa.base;

/**
 * 常量类
 *
 * @author xiayouxue
 * @date 2014/4/24
 */
public class Constant {

    /*application中变量定义*/
    /**功能编码*/
    public final static String VC_FUNCTION_CODES = "VC_FUNCTION_CODES";

    /**组件编码*/
    public final static String VC_COMPONENT_CODES = "VC_COMPONENT_CODES";

    /**名称描述*/
    public final static String VC_NAMEDESCS = "VC_NAMEDESCS";

    /**描述名称*/
    public final static String VC_DESCNAMES = "VC_DESCNAMES";

    /**导入导出*/
    public final static String VC_IMPORTEXPORTS = "VC_IMPORTEXPORTS";

    /**省份集合*/
    public final static String VC_PCAS = "VC_PCAS";

    /*session中变量定义*/
    /**用户编号*/
    public final static String VS_USER_ID = "VS_USER_ID";

    /**用户名*/
    public final static String VS_USER_NAME = "VS_USER_NAME";

    /**用户*/
    public final static String VS_USER = "VS_USER";

    /**组织编号*/
    public final static String VS_ORG_ID = "VS_ORGANIZATION_ID";

    /**组织*/
    public final static String VS_ORG = "VS_ORG";

    /**数据级筛选*/
    public final static String VS_DATASHIFT = "VS_DATASHIFT";

    /**菜单列表*/
    public final static String VS_MENUS = "VS_MENUS";

    /**标题栏一级菜单列表*/
    public final static String VS_SETPAGE_MENUS = "VS_SETPAGE_MENUS";

    /**菜单栏菜单列表*/
    public final static String VS_MENUBAR_MENUS = "VS_MENUBAR_MENUS";

    /**菜单栏一级菜单列表*/
    public final static String VS_MENUBAR_FIRST_MENUS = "VS_MENUBAR_FIRST_MENUS";

    /**菜单栏二级菜单列表*/
    public final static String VS_MENUBAR_SECOUND_MENUS = "VS_MENUBAR_SECOUND_MENUS";

    /**角色列表*/
    public final static String VS_ROLES = "VS_ROLES";

    /**功能列表*/
    public final static String VS_FUNCTIONS = "VS_FUNCTIONS";

    /**Boolean型可判断的功能*/
    public final static String VS_HAS_FUNCTIONS = "VS_HAS_FUNCTIONS";

    /**Boolean型可判断的组件*/
    public final static String VS_HAS_COMPONENTS = "VS_HAS_COMPONENTS";

    /**组件列表*/
    public final static String VS_COMPONENTS = "VS_COMPONENTS";

    /**页面JS的全局信息*/
    public final static String VS_JS_GLOBALINFO = "VS_JS_GLOBALINFO";

    /**session检查标志*/
    public final static String VS_SESSION_CHECK = VS_USER_NAME;


    /*request内变量定义 */
    /**当前日期*/
    public final static String VR_DATE = "VR_DATE";

    /**一级菜单，当前请求在菜单栏位置对应的一级菜单*/
    public final static String VR_FIRST_MENU = "VR_FIRST_MENU";

    /**功能，显示在首页当前位置*/
    public final static String VR_TITLE_FUNCTION = "VR_TITLE_FUNCTION";

    /**菜单列表，显示在首页当前位置*/
    public final static String VR_TITLE_MENUS = "VR_TITLE_MENUS";

    /**最后菜单*/
    public final static String VR_LAST_MENU = "VR_LAST_MENU";

    /**功能，每次请求对应的功能*/
    public final static String VR_FUNCTION = "VR_FUNCTION";

    /**参数，每次请求对应的参数*/
    public final static String VR_PARAMS = "VR_PARAMS";

    /**组件，每次请求对应的功能*/
    public final static String VR_COMPONENT = "VR_COMPONENT";

    /**页面JS的全局信息*/
    public final static String VR_JS_GLOBALINFO = "VR_JS_GLOBALINFO";



    /*信息变量定义*/
    /**全局信息*/
    public final static String VM_GLOBAL = "VM_GLOBAL";

    /**业务信息*/
    public final static String VM_BUSINESS = "VM_BUSINESS";

    /**错误信息*/
    public final static String VM_ERROR = "VM_ERROR";

    /**角色管理员代码*/
    public final static String ROLE_MANAGER_CODE = "2";

    /**组织序号层次长度*/
    public final static int ORG_ORDER_TIER_LENGTH = 2;


}
