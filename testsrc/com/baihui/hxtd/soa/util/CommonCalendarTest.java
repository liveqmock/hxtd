package com.baihui.hxtd.soa.util;

import org.apache.commons.lang3.Range;
import org.apache.commons.lang3.time.DateUtils;
import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

@SuppressWarnings("unchecked")
public class CommonCalendarTest {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Test
    public void testUnitMin() throws Exception {


    }

    @Test
    public void testUnitMax() throws Exception {


    }

    @Test
    public void testFindQuarter() throws Exception {
        int quarter = CommonCalendar.findQuarter(1);
        Assert.assertEquals(1, quarter);

        quarter = CommonCalendar.findQuarter(4);
        Assert.assertEquals(2, quarter);

        quarter = CommonCalendar.findQuarter(7);
        Assert.assertEquals(3, quarter);

        quarter = CommonCalendar.findQuarter(11);
        Assert.assertEquals(4, quarter);

        try {
            quarter = CommonCalendar.findQuarter(13);
            Assert.fail("无效月份值，未抛出异常！");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

    }

    @Test
    public void testQuarterMin() throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("MM HH:mm:ss");
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, 1);
        Date date = CommonCalendar.quarterMin(calendar);
        Assert.assertEquals("01 00:00:00", format.format(date));

        calendar.set(Calendar.MONTH, 4);
        date = CommonCalendar.quarterMin(calendar);
        Assert.assertEquals("02 00:00:00", format.format(date));

    }

    @Test
    public void testQuarterMax() throws Exception {
        Date now = new Date();
        Date year = DateUtils.truncate(now, Calendar.YEAR);
    }


    @Test
    public void testGenerateDateRange() throws Exception {
        Calendar calendar = Calendar.getInstance();
        Map<String, Range<Date>> timeRanges = CommonCalendar.generateDateRange();

    }
}