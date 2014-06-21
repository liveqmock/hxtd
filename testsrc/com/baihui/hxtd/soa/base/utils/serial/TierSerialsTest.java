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
    public void testGetParents() throws Exception {
        List<Long> integers = TierSerials.getParents(10101l, 2);
        Assert.assertEquals(2, integers.size());
        integers = TierSerials.getParentsUntil(10101l, 10000l, 2);
        Assert.assertEquals(2, integers.size());
    }
}
