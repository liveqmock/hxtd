package com.baihui.hxtd.soa.base.utils;

import com.baihui.hxtd.soa.base.Constant;
import org.apache.commons.collections.BidiMap;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 导入导出工具类
 *
 * @author xiayouxue
 * @date 2014/6/5
 */
@SuppressWarnings("unchecked")
public class ImportExport {

    private static Logger logger = LoggerFactory.getLogger(ImportExport.class);
    private static Mapper mapper;
    //    @Value("${import.counts}")
    private static Integer importCounts = 100;


    /**
     * 创建工作簿
     * 1.根据输入流判断excel的版本
     */
    public static Workbook create(InputStream in) {

        if (!in.markSupported()) {
            in = new PushbackInputStream(in, 8);
        }

        try {
            if (POIFSFileSystem.hasPOIFSHeader(in)) {
                return new HSSFWorkbook(in);
            }
        } catch (IOException e) {
            throw new IllegalArgumentException("无法解析的文件流内容", e);
        }

        try {
            if (POIXMLDocument.hasOOXMLHeader(in)) {
                return new XSSFWorkbook(OPCPackage.open(in));
            }
        } catch (IOException e) {
            throw new IllegalArgumentException("无法解析的文件流内容", e);
        } catch (InvalidFormatException e) {
            throw new IllegalArgumentException("无法解析的文件流内容", e);
        }

        throw new IllegalArgumentException("无法解析的文件流内容");
    }

    /**
     * 导入
     */
    public static <T> List<T> imports(Workbook workbook, Map<String, String> descNames, Class<T> clazz, int limit) {
        //实体列表
        List<T> entities = new ArrayList<T>();

        for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
            //表格
            Sheet sheet = workbook.getSheetAt(i);
            if (sheet == null) continue;

            //表头
            Map<Integer, String> indexNames = new HashMap<Integer, String>();
            Row header = sheet.getRow(0);
            for (int j = 0; j < header.getLastCellNum(); j++) {
                indexNames.put(j, descNames.get(header.getCell(j).getStringCellValue()));
            }

            //内容
            int valid = 0;
            for (int j = 1; j <= sheet.getLastRowNum(); j++) {
                Row row = sheet.getRow(j);
                if (row == null) continue;

                if (++valid == limit) {
                    break;
                }

                //转换为实体
                Map<String, Object> userMap = new HashMap<String, Object>();
                for (int k = 0; k < row.getLastCellNum(); k++) {
                    Cell cell = row.getCell(k);
                    String name = indexNames.get(k);
                    String[] tierNames = name.split("\\.");
                    Map<String, Object> objectMap = userMap;
                    for (int l = 0; l < tierNames.length; l++) {
                        if (l == tierNames.length - 1) {
                            objectMap.put(tierNames[l], getValue(cell));
                        } else {
                            objectMap.put(tierNames[l], new HashMap<String, Object>());
                            objectMap = (Map<String, Object>) objectMap.get(tierNames[l]);
                        }
                    }
                    userMap.put(name, getValue(cell));
                }
                entities.add(mapper.map(userMap, clazz));
            }
        }

        return entities;
    }

    /**
     * 导入
     */
    public static <T> List<T> imports(Workbook workbook, Map<String, String> descNames, Class<T> clazz) {
        return imports(workbook, descNames, clazz, importCounts);
    }

    /**
     * 获取单元格值
     */
    private static Object getValue(Cell cell) {
        if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
            return cell.getBooleanCellValue();
        } else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
            return cell.getNumericCellValue();
        } else {
            return cell.getStringCellValue();
        }
    }

    /**
     * 导出Excel文件
     */
    public static Workbook exportExcel(Workbook workbook, List entities, String[] names, Map<String, String> nameDescs) {
        //表格
        Sheet sheet = workbook.createSheet();

        //表头
        Row header = sheet.createRow(0);
        for (int i = 0; i < names.length; i++) {
            header.createCell(i).setCellValue(nameDescs.get(names[i]));
        }

        //内容
        for (int i = 0; i < entities.size(); i++) {
            Object entity = entities.get(i);
            Row row = sheet.createRow(i + 1);
            for (int j = 0; j < names.length; j++) {
                setValue(row.createCell(j), ReflectionUtils.getTierFieldValue(entity, names[j]));
            }
        }

        return workbook;
    }

    /**
     * 导出Excel文件
     */
    public static Workbook exportExcel(HttpServletResponse response, ServletContext servletContext, String objectName, List entities) {
        logger.info("导出excel");
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + objectName + ".xls");
        Map<String, BidiMap> nameDescs = (Map<String, BidiMap>) servletContext.getAttribute(Constant.VC_NAMEDESCS);
        BidiMap userNameDescs = nameDescs.get(objectName);
        Map<String, String> export = (Map<String, String>) servletContext.getAttribute(Constant.VC_IMPORTEXPORTS);
        String exportFieldName = export.get(objectName + ".export");
        logger.debug("导出字段名称“{}”", exportFieldName);
        String[] exportFieldNames = exportFieldName.split(",");
        Workbook workbook = ImportExport.exportExcel(new HSSFWorkbook(), entities, exportFieldNames, userNameDescs);
        return workbook;
    }

    private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * 设置单元格值
     */
    private static void setValue(Cell cell, Object value) {
        if (value == null) {
            return;
        }

        if (value instanceof String)
            cell.setCellValue((String) value);
        else if (value instanceof Boolean) {
            Boolean booleanValue = (Boolean) value;
            cell.setCellValue(booleanValue ? "是" : "否");
        } else if (value instanceof Number)
            cell.setCellValue(Double.parseDouble(String.valueOf(value)));
        else if (value instanceof Date)
            cell.setCellValue(dateFormat.format((Date) value));
        else
            cell.setCellValue(String.valueOf(value));
    }

    public static Mapper getMapper() {
        return mapper;
    }

    public void setMapper(Mapper mapper) {
        ImportExport.mapper = mapper;
    }
}
