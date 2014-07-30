package com.baihui.hxtd.soa.base.utils.report;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

/**
 * 报表工具类
 *
 * @author xiayouxue
 * @date 14-7-11
 */
public class ChartUtil {

    private static Logger logger = LoggerFactory.getLogger(ChartUtil.class);

    /** 二维表格数据转换 */
    public static <T extends Number> List<Number> toTable(List sourceTable, List<AxisInfo> xAxises, Class<T> clazz) {
        List<Number> targetTable = ChartUtil.buildEmptyTable(xAxises, clazz);

        //存储x轴索引
        Map<Object, Integer> xAxisIndexs = new HashMap<Object, Integer>();
        for (int i = 0; i < xAxises.size(); i++) {
            xAxisIndexs.put(xAxises.get(i).getValue(), i);
        }

        //转换数据
        int sourceXIndex = 0, sourceYIndex = 1;
        for (int i = 0; i < sourceTable.size(); i++) {
            Object[] row = (Object[]) sourceTable.get(i);
            Integer xIndex = xAxisIndexs.get(row[sourceXIndex]);
            if (xIndex == null) {
                logger.warn("({},{})={},不在xAxises{}范围内，略过", i, sourceXIndex, row[sourceXIndex], xAxisIndexs.keySet());
                continue;
            }
            targetTable.set(xIndex, (Number) row[sourceYIndex]);
        }

        return targetTable;
    }

    private final static Map<Class<? extends Number>, Number> ZEROS = new HashMap<Class<? extends Number>, Number>();

    static {
        ZEROS.put(Long.class, 0l);
        ZEROS.put(Integer.class, 0);
        ZEROS.put(Double.class, 0d);
        ZEROS.put(Float.class, 0f);
    }

    /** 创建空的二维表格 */
    public static <T extends Number> List<Number> buildEmptyTable(List xAxises, Class<T> clazz) {
        List<Number> emptyTable = new ArrayList<Number>(xAxises.size());
        for (int i = 0; i < xAxises.size(); i++) {
            emptyTable.add(ZEROS.get(clazz));
        }
        return emptyTable;
    }

    /** 收集所有数值 */
    public static List<Number> collect(List<List<Number>> table) {
        Set<Number> numbers = new HashSet<Number>();
        for (int i = 0; i < table.size(); i++) {
            numbers.addAll(table.get(i));
        }
        return new ArrayList<Number>(numbers);
    }

    /** 三维表格数据转换 */
    public static <T extends Number> List<List<Number>> toTable(List sourceTable, List<AxisInfo> xAxises, List<AxisInfo> zAxises, Class<T> clazz) {
        List<List<Number>> targetTable = ChartUtil.buildEmptyTable(xAxises, zAxises, clazz);

        //存储x轴索引
        Map<Object, Integer> xAxisIndexs = new HashMap<Object, Integer>();
        for (int i = 0; i < xAxises.size(); i++) {
            xAxisIndexs.put(xAxises.get(i).getValue(), i);
        }

        //存储z轴索引
        Map<Object, Integer> yAxisIndexs = new HashMap<Object, Integer>();
        for (int i = 0; i < zAxises.size(); i++) {
            yAxisIndexs.put(zAxises.get(i).getValue(), i);
        }

        //转换数据
        int sourceXIndex = 0, sourceZIndex = 1, sourceYIndex = 2;
        for (int i = 0; i < sourceTable.size(); i++) {
            Object[] row = (Object[]) sourceTable.get(i);
            Integer xIndex = xAxisIndexs.get(row[sourceXIndex]);
            if (xIndex == null) {
                logger.warn("({},{})={},不在xAxises{}范围内，略过", i, sourceXIndex, row[sourceXIndex], xAxisIndexs.keySet());
                continue;
            }
            Integer yIndex = yAxisIndexs.get(row[sourceZIndex]);
            if (yIndex == null) {
                logger.warn("({},{})={},不在zAxises{}范围内，略过", i, sourceZIndex, row[sourceZIndex], yAxisIndexs.keySet());
                continue;
            }
            targetTable.get(yIndex).set(xIndex, (Number) row[sourceYIndex]);
        }

        return targetTable;
    }

    /** 构建空的三维表格 */
    public static <T extends Number> List<List<Number>> buildEmptyTable(List xAxises, List zAxises, Class<T> clazz) {
        List<List<Number>> emptyTable = new ArrayList<List<Number>>();
        int ySize = zAxises.size();
        for (int i = 0; i < ySize; i++) {
            emptyTable.add(buildEmptyTable(xAxises, clazz));
        }
        return emptyTable;
    }
}
