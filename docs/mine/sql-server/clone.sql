insert into lead(
`OWNER`,COMPANY,`NAME`,DEPARTMENT,POSITION,EMAIL,PHONE,FAX,MOBILE,SOURCE,`STATUS`,CARD_TYPE,CARD_NUM,
INDUSTRY,POST_CODE,ADDRESS,REMARK,CREATOR_ID,CREATED_TIME,MODIFIER_ID
select `OWNER`,COMPANY,`NAME`,DEPARTMENT,POSITION,EMAIL,PHONE,FAX,MOBILE,SOURCE,`STATUS`,CARD_TYPE,CARD_NUM,
INDUSTRY,POST_CODE,ADDRESS,REMARK,CREATOR_ID,CREATED_TIME,MODIFIER_ID from lead ;              ;

insert into contact (ACCOUNT_ID, SUPPLIER_ID, OWNER, NAME, SOURCE, DEPARTMENT, POSITION, PHONE, MOBILE, EMAIL, FAX, POST_CODE, PROVINCE, CITY, COUNTY, ADDRESS, 
REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
select ACCOUNT_ID, SUPPLIER_ID, OWNER, NAME, SOURCE, DEPARTMENT, POSITION, PHONE, MOBILE, EMAIL, FAX, POST_CODE, PROVINCE, CITY, COUNTY, ADDRESS, 
REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED from contact  ;

INSERT INTO supplier (`NAME`, TYPE, PHONE, MOBILE, FAX, PROVINCE, CITY, COUNTY, ADDRESS, REMARK, 
CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
select `NAME`, TYPE, PHONE, MOBILE, FAX, PROVINCE, CITY, COUNTY, ADDRESS, REMARK, 
CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED from supplier   ;


INSERT INTO market_activity (`NAME`, TYPE, `STATUS`, BEGIN_DATE, END_DATE, PREDICT_COST, REALITY_COST, TIMES, EXPECT_EFFECT, 
EXPECT_SUCCESS_RATE, SPONSOR, BOSSHEAD, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
select `NAME`, TYPE, `STATUS`, BEGIN_DATE, END_DATE, PREDICT_COST, REALITY_COST, TIMES, EXPECT_EFFECT, 
EXPECT_SUCCESS_RATE, SPONSOR, BOSSHEAD, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED from market_activity ;

INSERT INTO customer (`OWNER`, `NAME`, TYPE, SOURCE, RISK_GRADE, CARD_TYPE, CARD_NUM, PHONE, MOBILE, 
POST_CODE, FAX, COMPANY, OPEN_BANK, BANK_NAME, BANK_ACCOUNT, OWNERSHIP, INDUSTRY, PROVINCE, CITY, COUNTY, ADDRESS, 
REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
select `OWNER`, `NAME`, TYPE, SOURCE, RISK_GRADE, CARD_TYPE, CARD_NUM, PHONE, MOBILE, 
POST_CODE, FAX, COMPANY, OPEN_BANK, BANK_NAME, BANK_ACCOUNT, OWNERSHIP, INDUSTRY, PROVINCE, CITY, COUNTY, ADDRESS, 
REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED from customer;

INSERT INTO project (SUPPLIER_ID, `CODE`, `NAME`, FINANCE_LIMIT, BEGIN_TIME, BEFORE_FINANCE_CYCLE, 
FINANCE_CYCLE, OPEN_TIME, DENDLINE_TIME, EARNING_RATE, ADVANCE_REDEEM_RATE, PAY_TYPE, 
REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
select SUPPLIER_ID, ROUND(ROUND(RAND(),12)*10000000000), `NAME`, FINANCE_LIMIT, BEGIN_TIME, BEFORE_FINANCE_CYCLE, 
FINANCE_CYCLE, OPEN_TIME, DENDLINE_TIME, EARNING_RATE, ADVANCE_REDEEM_RATE, PAY_TYPE, 
REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED from project;

INSERT INTO product (PROJECT_ID, `NAME`, `CODE`, TYPE, START_SELL_MONEY, 
MIN_ERNING_RATE, MAX_ERNING_RATE, EXPECT_PROFIT, SALE_LIMIT, SALE_UNIT, SALE_BEGIN_TIME, 
SALE_END_TIME, ADVANCE_REDEEM_RATE, ADVANCE_REDEEM_FORMULA, IS_EFFECT, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME)
select PROJECT_ID, `NAME`, ROUND(ROUND(RAND(),10)*10000000000), TYPE, START_SELL_MONEY, 
MIN_ERNING_RATE, MAX_ERNING_RATE, EXPECT_PROFIT, SALE_LIMIT, SALE_UNIT, SALE_BEGIN_TIME, 
SALE_END_TIME, ADVANCE_REDEEM_RATE, ADVANCE_REDEEM_FORMULA, IS_EFFECT, REMARK, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME from product;


insert into sysmessage(ID, TITLE, CONTENT, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED)
  select ID, TITLE, CONTENT, CREATOR_ID, CREATED_TIME, MODIFIER_ID, MODIFIED_TIME, IS_DELETED from sysmessage;

INSERT INTO user_message ( MESSAGE_ID, USER_ID, STATUS, IS_DELETED, TYPE, CREATED_TIME)
  select MESSAGE_ID, USER_ID, STATUS, IS_DELETED, TYPE, CREATED_TIME from user_message;
