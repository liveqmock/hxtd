package com.baihui.hxtd.soa.system;

/**
 * 字典大分类常量
 *
 * @author lihua
 * @description 分类常量
 * @date 2014/06/09
 */
public class DictionaryConstant {

    /** 性别 */
    public final static String VC_SEX = "性别";
    /** 打开方式 */
    public final static String VC_OPENTYPE = "打开方式";
    /** 显示位置 */
    public final static String VC_DISPLAYPOSITION = "显示位置";
    /** 机构类型 */
    public final static String VC_ORGTYPE = "机构类型";
    /** 用户类型 */
    public final static String VC_USERTYPE = "用户类型";
    /** 在岗状态 */
    public final static String VC_JOBSTAE = "在岗状态";
    /** 数据存储状态 */
    public final static String VC_DATASTORETYPE = "数据存储状态";
    /** 角色类型 */
    public final static String VC_ROLETYPE = "角色类型";
    /** 权限级别 */
    public final static String VC_AUTHLEVEL = "权限级别"; 
    /** 活动类型 */
    public final static String VC_ACTIVITYTYPE = "活动类型";
    /** 活动类型 */
    public final static String VC_ACTIVITYSTATUS = "活动状态";
    /** 线索状态 */
    public final static String VC_LEADSTATUS = "线索状态";
    /** 线索来源 */
    public final static String VC_LEADSOURCE = "线索来源";
    /** 银行卡类型 */
    public final static String VC_BANKCARDTYPE = "银行卡类型";
    /** 行业 */
    public final static String VC_BUSINESS = "行业";
    /** 客户类型 */
    public final static String VC_CUSTOMERTYPE = "客户类型";
    /** 客户来源 */
    public final static String VC_CUSTOMERSOURCE = "客户来源";
    /** 证件类型 */
    public final static String VC_DOCTYPE = "证件类型";
    /** 风险等级 */
    public final static String VC_RISKLEVEL = "风险等级";
    /** 所有权 */
    public final static String VC_OWNERSHIP = "公司性质";
    /** 开户行 */
    public final static String VC_OPENBANK = "开户行";
    /** 供应商类型 */
    public final static String VC_SUPPLIERTYPE = "供应商类型";
    /** 附件类型 */
    public final static String VC_ATTACHMENTTYPE = "附件类型";
    /** 产品类型 */
    public final static String VC_PRODUCTTYPE = "产品类型";
    /** 期限单位 */
    public final static String VC_DEADLINEUNIT = "期限单位";
    /** 支付类型 */
    public final static String VC_PAY_TYPE = "支付方式";
    /** 订单审批状态 */
    public final static String VC_ORDERAPPROVE = "审批状态";
    /** 赎回方式 */
    public final static String VC_REDEEM_TYPE = "赎回方式";
    /** 投资方式 */
    public final static String VC_INVESTMENT_WAY = "投资方式";
    /** 附件类型 */
    public final static String VC_ATTACHMENT_TYPE = "附件类型";
    /** 财务状态 */
    public final static String VC_FINANCIAL_WAY = "财务状态";
    
    /*公共的*/
    /** 性别 */
    public final static String PUBLIC_SEX = "0001";
    /** 男性 */
    public final static String PUBLIC_SEX_MAN = "000101";
    /** 女性 */
    public final static String PUBLIC_SEX_WOMAN = "000102";

    /*模块*/
    /** 模块类型 */
    public final static String MODULE_TYPE = "990101";
    /** 报表 */
    public final static String MODULE_TYPE_REPORT = "99010101";


     /*报表*/
    /** 报表分组类型 */
    public final static String REPORT_GROUP = "090001";

    /** 日期 */
    public final static String REPORT_GROUP_TIME = "09000101";
    /** 年 */
    public final static String REPORT_GROUP_TIME_YEAR = "0900010101";
    /** 季度 */
    public final static String REPORT_GROUP_TIME_QUARTER = "0900010102";
    /** 月 */
    public final static String REPORT_GROUP_TIME_MONTH = "0900010103";
    /** 周 */
    public final static String REPORT_GROUP_TIME_WEEK = "0900010104";
    /** 日 */
    public final static String REPORT_GROUP_TIME_DATE = "0900010105";
    /** 时 */
    public final static String REPORT_GROUP_TIME_HOUR = "0900010106";
    /** 分 */
    public final static String REPORT_GROUP_TIME_MINUTE = "0900010107";
    /** 秒 */
    public final static String REPORT_GROUP_TIME_SECOND = "0900010108";

    /** 其他 */
    public final static String REPORT_GROUP_ELSE = "09000199";
    /** 最细化 */
    public final static String REPORT_GROUP_ELSE_MOSTDETAIL = "0900019901";


    /** 报表聚合类型 */
    public final static String REPORT_AGGREGATE = "090002";
    /** 总计 */
    public final static String REPORT_AGGREGATE_COUNT = "09000201";
    /** 求和 */
    public final static String REPORT_AGGREGATE_SUM = "09000202";
    /** 平均 */
    public final static String REPORT_AGGREGATE_AVG = "09000203";
    /** 最大 */
    public final static String REPORT_AGGREGATE_MAX = "09000204";
    /** 最小 */
    public final static String REPORT_AGGREGATE_MIN = "09000205";

    /** 报表图表类型 */
    public final static String REPORT_CHART = "090003";
    /** 饼状图 */
    public final static String REPORT_CHART_PIE = "09000301";
    /** 柱状图 */
    public final static String REPORT_CHART_BAR = "09000302";
    /** 折线图 */
    public final static String REPORT_CHART_LINE = "09000303";



    /*菜单*/
    /** 显示位置 */
    public final static String MENU_SHOWLOCATION = "010404";

    /*用户*/
    /** 用户在岗情况 */
    public final static String USER_JOBSITUATION = "010403";
    /** 在岗 */
    public final static String USER_JOBSITUATION_ON = "01040301";

    /** 数据存储状态 */
    public final static String USER_STORESTATUS = "010404";
    /** 最新的 */
    public final static String USER_STORESTATUS_NEWEST = "01040401";
    /** 延迟的 */
    public final static String USER_STORESTATUS_DELAYED = "01040402";

    
     /*功能*/
    /** 权限级别 */
    public final static String FUNCTION_PRIVILEGELEVEL = "010601";
    /** 公共的 */
    public final static String FUNCTION_PRIVILEGELEVEL_PUBLIC = "01060101";
    /** 身份认证 */
    public final static String FUNCTION_PRIVILEGELEVEL_IDENTITY = "01060102";
    /** 权限认证 */
    public final static String FUNCTION_PRIVILEGELEVEL_AUTHORITY = "01060103";


    /*流程环节*/
    /** 流程环节类型 */
    public final static String NODE_TYPE = "990201";
    /** 订单审批 */
    public final static String NODE_TYPE_ORDERAPPROVE = "99020101";
    /** 市场活动（金额） */
    public final static String NODE_TYPE_MARKETACTIVITY_MONEY = "99020102";
    /** 市场活动（非金额） */
    public final static String NODE_TYPE_MARKETACTIVITY_NOMONEY = "99020103";

    
    /* 线索*/
    /**来源 */
    public final static String LEAD_SOURCE = "040101";
    /**状态 */
    public final static String LEAD_STATUS = "040102";
    /**卡类型 */
    public final static String LEAD_CARD_TYPE = "040103";
    /** 行业*/
    public final static String INDUSTRY = "040305";
    
    /* 客户*/
    /**类型 */
    public final static String CUSTOMER_TYPE = "040301";
    /**客户来源*/
    public final static String CUSTOMER_SOURCE = "040302";
    /**证件类型*/
    public final static String CUSTOMER_CARD_TYPE = "040303";
    /**风险等级*/
    public final static String CUSTOMER_RISK_TYPE = "040304";
    /**行业*/
    public final static String CUSTOMER_INDUSTRY = "040305";
    /**所有权*/
    public final static String CUSTOMER_OWNERSHIP = "040306";
    /**开户行*/
    public final static String CUSTOMER_OPENBANK = "040307";
    
    
    /*订单 */
    /** 支付方式*/
    public final static String INVESTMENT_WAY = "060101";
    /** 订单状态 */
    public final static String ORDER_STATUS = "070101";
    /** 支付状态 */
    public final static String ORDER_PAY_STATUS = "070102";
    
    /*订单支付状态*/
    /** (订单)hxtd未收款 */
    public final static String ORDER_PAY_2_HXTD_STATUS_NONE = "06010301";
    
    /** (订单)hxtd部分收款 */
    public final static String ORDER_PAY_2_HXTD_STATUS_SOME = "06010303";
    
    /** (订单)hxtd全部收款 */
    public final static String ORDER_PAY_2_HXTD_STATUS_ALL = "06010302";
    
    /** (订单)hxtd未打款给客户 */
    public final static String ORDER_PAY_2_CUSTOMER_STATUS_NONE = "06010304";
    
    /** (订单)hxtd已经打款给客户 */
    public final static String ORDER_PAY_CUSTOMER_HXTD_STATUS_ALL = "06010305";
    
    
    /*订单状态*/
    /** 订单开始时默认状态(待审核) */
    public final static String ORDER_STATUS_START = "07010101";
    
    /** 订单审核中 */
    public final static String ORDER_STATUS_NODEING = "07010102";
    
    /** 订单审核通过 */
    public final static String ORDER_STATUS_NODE_FINIAL = "07010103";
    
    /** 订单提前赎回 */
    public final static String ORDER_STATUS_ADVANCE_REDEMPTION = "07010106";
    
    /** 订单到期赎回 */
    public final static String ORDER_STATUS_FINISH_REDEMPTION = "07010107";
    
    /** 订单客户主动作废 */
    public final static String ORDER_STATUS_INVALID_CUSTOMER = "07010104";
    
    /** 订单公司作废 */
    public final static String ORDER_STATUS_INVALID_OWNER = "07010105";
    
    /**合同*/
    public final static String CONTRACT_REDEEM_TYPE = "080101";
    
    /*供应商 */
    /** 供应商类型*/
    public final static String SUPPLIER_TYPE = "050101";
     /**卡类型 */
    public final static String SUPPLIER_CARD_TYPE = "040303";
    
    /*项目 */
    /** 支付类型*/
    public final static String PROJECT_PAY_TYPE = "040201";
    
     
}
