package com.baihui.test.dozer;

import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.dozer.DozerBeanMapper;
import org.junit.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author xiayouxue
 * @date 2014/6/4
 */
public class DozerTest {

    @Test
    public void testToEntity() throws JsonProcessingException {
        Map<String, Object> userMap = new HashMap<String, Object>();
        userMap.put("name", "admin");
        HashMap<String, Object> organization = new HashMap<String, Object>();
        organization.put("id", 1l);
        userMap.put("organization", organization);
        DozerBeanMapper dozerBeanMapper = new DozerBeanMapper();
        User user = dozerBeanMapper.map(userMap, User.class);
        System.out.println(new ObjectMapper().writeValueAsString(user));
    }

    @Test
    public void testToMap() throws JsonProcessingException {
        DozerBeanMapper dozerBeanMapper = new DozerBeanMapper();
        User user = new User();
        user.setId(1l);
        user.setName("admin");
        Map<String, Object> userMap = dozerBeanMapper.map(user, Map.class);
        System.out.println(new ObjectMapper().writeValueAsString(userMap));
    }

    @Test
    public void testToListMap() throws JsonProcessingException {
        DozerBeanMapper dozerBeanMapper = new DozerBeanMapper();

        List<User> users = new ArrayList<User>();
        User user = new User();
        user.setId(1l);
        user.setName("admin");
        users.add(user);

        List<Map<String, Object>> userMap = dozerBeanMapper.map(users, List.class);
        System.out.println(userMap.get(0).get("id"));
        //System.out.println(new ObjectMapper().writeValueAsString(userMap));
    }
}
