package com.baihui.hxtd.soa.base.orm;

import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExtendItemSelectHqlTest {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Test
    public void testToFrom() throws Exception {
        SelectHql selectHql = new SelectHql("name", "User");
        logger.info("selectHql={}", selectHql);

        ExtendItemSelectHql hqlSelectExtend = new ExtendItemSelectHql("User", "user");
        hqlSelectExtend.getSelectItems().add("user.name");
        hqlSelectExtend.getWhereItems().add("user.name like ?");
        logger.info("hqlSelectFrom={}", hqlSelectExtend);

    }
}