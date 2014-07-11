package com.baihui.hxtd.soa.base.utils.report;

import junit.framework.TestCase;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ChartUtilTest extends TestCase {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public void testToTable() throws Exception {

    }

    @Test
    public void testBuildEmptyTable() throws Exception {
        List xAxisValues = Arrays.asList( 2, 3, 4, 5);
        List zAxisValues = Arrays.asList("北京", "上海", "广州");
        List<Integer> twoEmptyTable = ChartUtil.buildEmptyTable(xAxisValues, Integer.class);
        logger.info("twoEmptyTable:{}", twoEmptyTable);

        List<List<Integer>> throwEmptyTable = ChartUtil.buildEmptyTable(xAxisValues, zAxisValues, Integer.class);
        logger.info("throwEmptyTable:{}", throwEmptyTable);

        List<Object[]> throwSourceTable = new ArrayList<Object[]>();
        throwSourceTable.add(new Object[]{1, "北京", 3});
        throwSourceTable.add(new Object[]{2, "北京", 3});
        throwSourceTable.add(new Object[]{2, "北京1", 3});
        List<List<Integer>> throwValidTable = ChartUtil.toTable(throwSourceTable, xAxisValues, zAxisValues, Integer.class);
        logger.info("throwValidTable:{}", throwValidTable);


        List<Object[]> twoSourceTable = new ArrayList<Object[]>();
        twoSourceTable.add(new Object[]{1, 3});
        twoSourceTable.add(new Object[]{2, 3});
        twoSourceTable.add(new Object[]{4, 3});
        List<Integer> twoValidTable = ChartUtil.toTable(twoSourceTable, xAxisValues, Integer.class);
        logger.info("twoValidTable:{}", twoValidTable);
    }
}