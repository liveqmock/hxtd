package com.baihui.hxtd.soa.base.utils;

import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import org.junit.Assert;
import org.junit.Test;

/**
 * @author xiayouxue
 * @date 2014/6/9
 * @modify 新增XX功能 xiayouxue 2014/6/9
 */
public class ReflectionUtilsTest {
    @Test
    public void testToMap() throws Exception {

    }

    @Test
    public void testGetTierFieldValue() throws Exception {
        User user = new User();
        user.setOrganization(new Organization(1l));
        Assert.assertEquals(1l, ReflectionUtils.getTierFieldValue(user, "organization.id"));
        user.setName("admin");
        Assert.assertEquals("admin", ReflectionUtils.getTierFieldValue(user, "name"));
    }
}
