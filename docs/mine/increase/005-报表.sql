# 模块类型之报表
UPDATE sm_module_type
SET type_id = (SELECT
                 id
               FROM sm_dictionary
               WHERE `value` = '99010101')
WHERE type_id = 99010101;

#