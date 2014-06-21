package com.baihui.test.logger;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

@ContextConfiguration(value = "classpath*:ApplicationContext.xml")
public class LoggerTest extends AbstractJUnit4SpringContextTests {
    @Test
    public void testLoginForm() throws Exception {
        Logger logger = LoggerFactory.getLogger(this.getClass());
        logger.debug("调试");
        logger.info("信息");
        logger.warn("警告");
        logger.error("错误");
    }
}
