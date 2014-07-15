package com.baihui.hxtd.soa.base.utils.report;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 报表工具类
 *
 * @author xiayouxue
 * @date 14-7-11
 */
public class ChartUtil {

    private static Logger logger = LoggerFactory.getLogger(ChartUtil.class);

    /** 二维表格数据转换 */
    public static List<Number> toTable(List sourceTable, List<AxisInfo> xAxises) {
        List<Number> targetTable = ChartUtil.buildEmptyTable(xAxises);

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


    /** 创建空的二维表格 */
    public static List<Number> buildEmptyTable(List xAxises) {
        List<Number> emptyTable = new ArrayList<Number>(xAxises.size());
        for (int i = 0; i < xAxises.size(); i++) {
            emptyTable.add(0);
        }
        return emptyTable;
    }

    /** 三维表格数据转换 */
    public static List<List<Number>> toTable(List sourceTable, List<AxisInfo> xAxises, List<AxisInfo> zAxises) {
        List<List<Number>> targetTable = ChartUtil.buildEmptyTable(xAxises, zAxises);


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
    public static List<List<Number>> buildEmptyTable(List xAxises, List zAxises) {
        List<List<Number>> emptyTable = new ArrayList<List<Number>>();
        int ySize = zAxises.size();
        for (int i = 0; i < ySize; i++) {
            emptyTable.add(buildEmptyTable(xAxises));
        }
        return emptyTable;
    }
}
