package com.baihui.test.clone;

import com.baihui.hxtd.soa.system.entity.User;
import org.junit.Test;
import org.springframework.beans.BeanUtils;
import org.springside.modules.mapper.JsonMapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author xiayouxue
 * @date 2014/6/8
 */
public class SpringBeanUtilsTest {


    @Test
    public void testClone() throws Exception {
        User user = new User();
        user.setName("admin");

        Map userMap = new HashMap();

        System.out.println(JsonMapper.nonEmptyMapper().toJson(userMap));

        List<User> users = new ArrayList<User>();
        users.add(user);

    }
}
