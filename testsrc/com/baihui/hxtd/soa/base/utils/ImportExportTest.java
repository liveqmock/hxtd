package com.baihui.hxtd.soa.base.utils;

import com.baihui.hxtd.soa.system.entity.User;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * @author xiayouxue
 * @date 2014/6/5
 * @modify 新增XX功能 xiayouxue 2014/6/5
 */
public class ImportExportTest {
    @Test
    public void testToListMap() throws Exception {
        List<User> users = new ArrayList<User>();
        User user = new User();
        user.setId(1l);
        user.setName("admin");
        users.add(user);


    }

    @Test
    public void testExportExcel() throws Exception {
        Properties properties = new Properties();
        try {
            properties.load(getClass().getResourceAsStream("/application.namedesc.properties"));

            Properties export = new Properties();
            export.load(this.getClass().getResourceAsStream("/application.export.properties"));

            List<User> users = new ArrayList<User>();
            User user = new User();
            user.setId(1l);
            user.setName("admin");
            users.add(user);


        } catch (IOException e) {
            throw new RuntimeException("加载名称描述配置文件异常", e);
        }
    }
}
