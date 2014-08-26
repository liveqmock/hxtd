package com.baihui.hxtd.soa.base;

import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 获取数据库时间
 *
 * @author xiayouxue
 * @date 2014/8/26
 */
@Component
public class DBDateServiceInjecter {

    private static DBDateService dbDateService;

    public static Date nowDate() {
        return dbDateService.nowDate();
    }

    public static Date nowTime() {
        return dbDateService.nowTime();
    }

    public DBDateService getDbDateService() {
        return dbDateService;
    }

    @Resource
    public void setDbDateService(DBDateService dbDateService) {
        DBDateServiceInjecter.dbDateService = dbDateService;
    }
}
