package com.baihui.hxtd.soa.base.utils.serial;

import org.junit.Assert;
import org.junit.Test;

import java.util.List;

/**
 * @author xiayouxue
 * @date 2014/6/6
 */
public class TierSerialsTest {
    @Test
    public void testParse() throws Exception {

    }

    @Test
    public void testGeneratStartSerial() throws Exception {

    }

    @Test
    public void testGetFullLevel() {
        Assert.assertEquals(3, TierSerials.getFullLevel(10000l, 2));
        Assert.assertEquals(2, TierSerials.getFullLevel(10000l, 3));
    }

    @Test
    public void testGetLevelDiffer() {
        Assert.assertEquals(0, TierSerials.getLevelDiffer(1l, 2));
        Assert.assertEquals(2, TierSerials.getLevelDiffer(10000l, 2));
        Assert.assertEquals(1, TierSerials.getLevelDiffer(10000l, 3));
    }

    @Test
    public void testGetLevel() {
        Assert.assertEquals(1, TierSerials.getLevel(1l, 2));
        Assert.assertEquals(1, TierSerials.getLevel(1l, 2));
        Assert.assertEquals(1, TierSerials.getLevel(10000l, 2));
        Assert.assertEquals(1, TierSerials.getLevel(10000l, 3));
        Assert.assertEquals(2, TierSerials.getLevel(10100l, 3));
        Assert.assertEquals(3, TierSerials.getLevel(10101l, 2));
    }

    @Test
    public void testGetMaxBrother() {
        Assert.assertEquals((Long) 999999l, TierSerials.getMax(10000l, 2));
        Assert.assertEquals((Long) 99l, TierSerials.getMax(10l, 2));
        Assert.assertEquals((Long) 99l, TierSerials.getMax(0l, 2));
    }

    @Test
    public void testGetTierIncrease() throws Exception {
        Long order = TierSerials.getMaxChild(10000l, 2);
        System.out.println(order);
        order = TierSerials.getMinChild(10000l, 2);
        System.out.println(order);
    }

    @Test
    public void testGetIncrease() throws Exception {
        long order = TierSerials.getIncrease(20000l, 2);
        Assert.assertEquals(10000l, order);
    }

    @Test
    public void testGetParent() throws Exception {
        Long id = TierSerials.getParent(10101l, 2);
        Assert.assertEquals((Long) 10100l, id);

        id = TierSerials.getParent(10000l, 2);
        Assert.assertEquals((Long) 0l, id);

        id = TierSerials.getParent(0l, 2);
        Assert.assertEquals((Long) 0l, id);
    }

    @Test
    public void testGetParents() throws Exception {
        List<Long> integers = TierSerials.getParents(10101l, 2);
        Assert.assertEquals(2, integers.size());
        integers = TierSerials.getParentsUntil(10101l, 10000l, 2);
        Assert.assertEquals(2, integers.size());
    }
}
