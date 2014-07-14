package com.baihui.hxtd.soa.base.utils.report;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Administrator
 * @date 14-7-11
 */
public class ChartUtil {

    private static Logger logger = LoggerFactory.getLogger(ChartUtil.class);

    /**
     * 二维表格数据转换
     */
    public static <T extends Number> List<T> toTable(List sourceTable, List xAxises, Class<T> numberType) {
        List<T> targetTable = ChartUtil.buildEmptyTable(xAxises, numberType);

        //存储x轴索引
        Map<Object, Integer> xAxisIndexs = new HashMap<Object, Integer>();
        for (int i = 0; i < xAxises.size(); i++) {
            xAxisIndexs.put(xAxises.get(i), i);
        }

        //转换数据
        int sourceXIndex = 0, sourceYIndex = 1;
        for (int i = 0; i < sourceTable.size(); i++) {
            Object[] row = (Object[]) sourceTable.get(i);
            Integer xIndex = xAxisIndexs.get(row[sourceXIndex]);
            if (xIndex == null) {
                logger.warn("({},{})={},不在xAxises{}范围内，略过", i, sourceXIndex, row[sourceXIndex], xAxises);
                continue;
            }
            targetTable.set(xIndex, numberType.cast(row[sourceYIndex]));
        }

        return targetTable;
    }

    private final static Map<Class<? extends Number>, Number> zeros = new HashMap<Class<? extends Number>, Number>();

    static {
        zeros.put(Integer.class, 0);
        zeros.put(Long.class, 0l);
        zeros.put(Float.class, 0f);
        zeros.put(Double.class, 0d);
    }

    /**
     * 创建空的二维表格
     */
    public static <T extends Number> List<T> buildEmptyTable(List xAxises, Class<T> numberType) {
        List<T> emptyTable = new ArrayList<T>(xAxises.size());
        T zero = numberType.cast(zeros.get(numberType));
        for (int i = 0; i < xAxises.size(); i++) {
            emptyTable.add(zero);
        }
        return emptyTable;
    }

    /**
     * 三维表格数据转换
     */
    public static <T extends Number> List<List<T>> toTable(List sourceTable, List xAxises, List zAxises, Class<T> numberType) {
        List<List<T>> targetTable = ChartUtil.buildEmptyTable(xAxises, zAxises, numberType);


        //存储x轴索引
        Map<Object, Integer> xAxisIndexs = new HashMap<Object, Integer>();
        for (int i = 0; i < xAxises.size(); i++) {
            xAxisIndexs.put(xAxises.get(i), i);
        }

        //存储z轴索引
        Map<Object, Integer> zAxisIndexs = new HashMap<Object, Integer>();
        for (int i = 0; i < zAxises.size(); i++) {
            zAxisIndexs.put(zAxises.get(i), i);
        }

        //转换数据
        int sourceXIndex = 0, sourceZIndex = 1, sourceYIndex = 2;
        for (int i = 0; i < sourceTable.size(); i++) {
            Object[] row = (Object[]) sourceTable.get(i);
            Integer xIndex = xAxisIndexs.get(row[sourceXIndex]);
            if (xIndex == null) {
                logger.warn("({},{})={},不在xAxises{}范围内，略过", i, sourceXIndex, row[sourceXIndex], xAxises);
                continue;
            }
            Integer zIndex = zAxisIndexs.get(row[sourceZIndex]);
            if (zIndex == null) {
                logger.warn("({},{})={},不在zAxises{}范围内，略过", i, sourceZIndex, row[sourceZIndex], zAxises);
                continue;
            }
            targetTable.get(zIndex).set(xIndex, numberType.cast(row[sourceYIndex]));
        }

        return targetTable;
    }

    /**
     * 构建空的三维表格
     */
    public static <T extends Number> List<List<T>> buildEmptyTable(List xAxises, List zAxises, Class<T> numberType) {
        List<List<T>> emptyTable = new ArrayList<List<T>>();
        int ySize = zAxises.size();
        for (int i = 0; i < ySize; i++) {
            emptyTable.add(buildEmptyTable(xAxises, numberType));
        }
        return emptyTable;
    }
}
