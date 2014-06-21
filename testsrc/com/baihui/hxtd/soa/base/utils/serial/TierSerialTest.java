package com.baihui.hxtd.soa.base.utils.serial;

import org.junit.Assert;
import org.junit.Test;

/**
 * @author xiayouxue
 * @date 2014/6/6
 * @modify 新增XX功能 xiayouxue 2014/6/6
 */
public class TierSerialTest {
    @Test
    public void testGetRoot() throws Exception {
        TierSerial tierSerial = TierSerials.parse(1010101, 2);
        Assert.assertEquals(1000000, tierSerial.getRoot().getSerial());
    }

    @Test
    public void testGetParent() throws Exception {
        TierSerial tierSerial = TierSerials.parse(1010101, 2);
        Assert.assertEquals(1010100, tierSerial.getParent().getSerial());
    }

    @Test
    public void testGetParents() throws Exception {
        TierSerial tierSerial = TierSerials.parse(1010101, 2);
        Assert.assertEquals(4, tierSerial.getParents().size());

    }
}
