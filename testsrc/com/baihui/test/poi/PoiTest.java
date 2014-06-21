package com.baihui.test.poi;

import com.baihui.hxtd.soa.system.entity.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.dozer.DozerBeanMapper;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.*;

public class PoiTest {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public static Map<String, String> descNames = new LinkedHashMap<String, String>();

    static {
        descNames.put("主键编号", "id");
        descNames.put("名称", "name");
        descNames.put("真实姓名", "realName");
    }

    @Test
    public void testLinkedHashMap() throws Exception {
        for (int i = 0; i < 100; i++)
            for (String key : descNames.keySet()) {
                logger.info("key:{}", key);
            }
    }


    @Test
    public void testExport() throws Exception {
        List<User> users = new ArrayList<User>();

        User user = new User();
        user.setId(0l);
        user.setName("admin");
        users.add(user);

        user = new User();
        user.setId(1l);
        user.setName("test");
        users.add(user);

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet();

        XSSFRow header = sheet.createRow(0);
        int i = 0;
        for (String key : descNames.keySet()) {
            header.createCell(i++).setCellValue(key);
        }


        for (i = 0; i < users.size(); i++) {
            User user1 = users.get(i);
            Map<String, Object> map = new DozerBeanMapper().map(user1, Map.class);
            XSSFRow row = sheet.createRow(i + 1);
            int j = 0;
            for (String key : descNames.keySet()) {
                XSSFCell cell = row.createCell(j++);
                Object value = map.get(descNames.get(key));
                if (value != null)
                    setValue(cell, value);
            }
        }
        File file = new File("E:\\project\\company\\hxtd\\testsrc\\com\\baihui\\test\\poi\\test.xls");

        if (!file.exists()) file.createNewFile();
        workbook.write(new FileOutputStream(file));
    }

    @Test
    public void testExportUsingConfig() throws Exception {
        List<User> users = new ArrayList<User>();

        User user = new User();
        user.setId(0l);
        user.setName("admin");
        users.add(user);

        user = new User();
        user.setId(1l);
        user.setName("test");
        users.add(user);

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet();

        Properties namedescs = new Properties();
        namedescs.load(this.getClass().getResourceAsStream("/application.namedesc.properties"));
        for (String key : namedescs.stringPropertyNames()) {
            logger.info("key:{},value:{}", key, new String(namedescs.getProperty(key).getBytes("ISO-8859-1"), "GBK"));
        }

        Properties export = new Properties();
        export.load(this.getClass().getResourceAsStream("/application.export.properties"));
        for (String key : export.stringPropertyNames()) {
            logger.info("key:{},value:{}", key, export.getProperty(key));
        }

        String[] names = export.getProperty("user.export").split(",");

        XSSFRow header = sheet.createRow(0);
        for (int i = 0; i < names.length; i++) {
            String name = names[i];
            String value = namedescs.getProperty(name);
            header.createCell(i).setCellValue(new String(value.getBytes("ISO-8859-1"), "GBK"));
        }

        for (int i = 0; i < users.size(); i++) {
            User user1 = users.get(i);
            Map<String, Object> map = new DozerBeanMapper().map(user1, Map.class);
            XSSFRow row = sheet.createRow(i + 1);
            for (int j = 0; j < names.length; j++) {
                String name = names[j];
                XSSFCell cell = row.createCell(j);
                String[] nameParts = name.split("\\.");
                Object value = map.get(nameParts[nameParts.length - 1]);
                if (value != null)
                    setValue(cell, value);
            }
        }
        File file = new File("E:\\project\\company\\hxtd\\testsrc\\com\\baihui\\test\\poi\\test.xls");

        if (!file.exists()) file.createNewFile();
        workbook.write(new FileOutputStream(file));
    }

    private void setValue(XSSFCell cell, Object value) {
        if (value instanceof String)
            cell.setCellValue((String) value);
        else if (value instanceof Boolean)
            cell.setCellValue((Boolean) value);
        else if (value instanceof Number)
            cell.setCellValue(Double.parseDouble(String.valueOf(value)));
        else if (value instanceof Date)
            cell.setCellValue((Date) value);
        else
            cell.setCellValue(String.valueOf(value));
    }


    @Test
    public void testImport() throws Exception {
        List<User> users = new ArrayList<User>();
        InputStream is = new FileInputStream("E:\\project\\company\\hxtd\\testsrc\\com\\baihui\\test\\poi\\test.xls");
        XSSFWorkbook hssfWorkbook = new XSSFWorkbook(is);
        logger.info("getNumberOfSheets:{}", hssfWorkbook.getNumberOfSheets());
        for (int i = 0; i < hssfWorkbook.getNumberOfSheets(); i++) {
            XSSFSheet sheet = hssfWorkbook.getSheetAt(i);
            if (sheet == null) continue;

            Map<String, String> descNames = new HashMap<String, String>();
            descNames.put("主键编号", "id");
            descNames.put("名称", "name");

            Map<Integer, String> indexNames = new HashMap<Integer, String>();
            XSSFRow header = sheet.getRow(0);
            logger.info("header.getLastCellNum:{}", header.getLastCellNum());
            for (int j = 0; j < header.getLastCellNum(); j++) {
                indexNames.put(j, descNames.get(header.getCell(j).getStringCellValue()));
            }

            logger.info("LastRowNum:{}", sheet.getLastRowNum());
            for (int j = 1; j <= sheet.getLastRowNum(); j++) {
                XSSFRow row = sheet.getRow(j);
                if (row == null) continue;
                Map<String, Object> userMap = new HashMap<String, Object>();
                for (int k = 0; k < row.getLastCellNum(); k++) {
                    XSSFCell cell = row.getCell(k);
                    userMap.put(indexNames.get(k), getValue(cell));
                }
                users.add(new DozerBeanMapper().map(userMap, User.class));
            }
        }
        System.out.println(new ObjectMapper().writeValueAsString(users));
    }


    private Object getValue(XSSFCell cell) {
        if (cell.getCellType() == XSSFCell.CELL_TYPE_BOOLEAN) {
            return cell.getBooleanCellValue();
        } else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
            return cell.getNumericCellValue();
        } else {
            return cell.getStringCellValue();
        }
    }


}
