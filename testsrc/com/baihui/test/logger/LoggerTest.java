package com.baihui.test.logger;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Stack;

public class LoggerTest {
    @Test
    public void testLoginForm() throws Exception {
        Logger logger = LoggerFactory.getLogger(this.getClass());
        System.out.println(new String("1") == "1");
        logger.debug("");
        logger.debug("调试");
        logger.info("信息");
        logger.warn("警告");
        logger.error("错误");

    }
}
