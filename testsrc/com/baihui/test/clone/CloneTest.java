package com.baihui.test.clone;

import com.baihui.hxtd.soa.system.entity.User;
import com.sun.org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import org.springside.modules.mapper.JsonMapper;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author xiayouxue
 * @date 2014/6/8
 */
public class CloneTest {

    @Test
    public void testMain() throws Exception {
        File file = new File("E:\\project\\company\\hxtd\\testsrc\\com\\baihui\\test\\clone\\0.5M.txt");
        if (!file.exists()) file.createNewFile();
        StringBuffer size = new StringBuffer();
        for (int i = 0; i < 1024 * 1024; i++) {
            size.append("我");
        }
        FileUtils.write(file, size);
    }

    @Test
    public void testClone() throws Exception {
        User user = new User();
        user.setName("admin");

        Map userMap = BeanUtils.describe(user);
        System.out.println(JsonMapper.nonEmptyMapper().toJson(userMap));

        List<User> users = new ArrayList<User>();
        users.add(user);

    }
}
