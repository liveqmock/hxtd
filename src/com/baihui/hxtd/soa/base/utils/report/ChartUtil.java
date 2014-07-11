package com.baihui.hxtd.soa.base.utils.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Administrator
 * @date 14-7-11
 */
public class ChartUtil {

    public static <T extends Number> List<List<T>> toTable(List sourceTable, List xAxises, List zAxises, Class<T> numberType) {
        List<List<T>> targetTable = ChartUtil.buildEmptyTable(xAxises, zAxises, numberType);

        int sourceXIndex = 0, sourceZIndex = 1, sourceYIndex = 2;
        int targetXIndex = 0, targetZIndex = 0, targetYIndex = 0;

        Map<Object, Integer> xAxisIndexs = new HashMap<Object, Integer>();
        for (int i = 0; i < xAxises.size(); i++) {
            xAxisIndexs.put(xAxises.get(i), i);
        }

        if (zAxises != null) {
            Map<Object, Integer> zAxisIndexs = new HashMap<Object, Integer>();
            for (int i = 0; i < zAxises.size(); i++) {
                zAxisIndexs.put(zAxises.get(i), i);
            }

            for (int i = 0; i < sourceTable.size(); i++) {
                Object[] row = (Object[]) sourceTable.get(i);
                Integer xIndex = xAxisIndexs.get(row[sourceXIndex]);
                Integer zIndex = zAxisIndexs.get(row[sourceZIndex]);
                targetTable.get(zIndex).set(xIndex, numberType.cast(row[sourceYIndex]));
            }
        } else {
            sourceYIndex = 1;
            targetXIndex = 0;

            for (int i = 0; i < sourceTable.size(); i++) {
                Object[] row = (Object[]) sourceTable.get(i);
                Integer xIndex = xAxisIndexs.get(row[sourceXIndex]);
//                Integer yIndex = zAxisIndexs.get(row[sourceZIndex]);
//                targetTable.get(yIndex).set(xIndex, numberType.cast(row[2]));
            }
        }


        return targetTable;
    }

    public static <T extends Number> List<List<T>> buildEmptyTable(List xAxises, List zAxises, Class<T> numberType) {
        List<List<T>> emptyTable = new ArrayList<List<T>>();
        int xSize = xAxises.size();
        int ySize = zAxises == null ? 1 : zAxises.size();
        for (int i = 0; i < ySize; i++) {
            List<T> row = new ArrayList<T>(xSize);
            for (int j = 0; j < row.size(); j++) {
                row.add(numberType.cast(0));
            }
            emptyTable.add(row);
        }
        return emptyTable;
    }
}
