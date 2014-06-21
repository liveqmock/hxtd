package com.baihui.test.spring;

import com.baihui.hxtd.soa.system.entity.User;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;

import javax.annotation.Resource;

/**
 * @author xiayouxue
 * @date 2014/6/8
 * @modify 新增XX功能 xiayouxue 2014/6/8
 */
@ContextConfiguration(value = "classpath*:ApplicationContext.xml")
public class SpringTest {

    @Resource
    private User user;

    @Test
    public void testSpring() throws Exception {
//        BeanFactory factory = new ClassPathXmlApplicationContext("classpath*:ApplicationContext*.xml");
//        Bean工厂通过Bean的id得到JavaBean
//        user = factory.getBean(User.class);
        System.out.println(user.getCreateTime());
    }
}
