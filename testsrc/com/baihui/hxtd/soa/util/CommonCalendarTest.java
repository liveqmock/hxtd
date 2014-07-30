package com.baihui.hxtd.soa.util;

import org.apache.commons.lang3.Range;
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

    SimpleDateFormat format = new SimpleDateFormat("MM-dd HH:mm:ss");
    Calendar calendar = Calendar.getInstance();


    @Test
    public void testUnitMin() throws Exception {


    }

    @Test
    public void testUnitMax() throws Exception {
        calendar.set(2014, Calendar.JULY, 27);
        Date date = CommonCalendar.unitMin(calendar, Calendar.DAY_OF_WEEK);
        Assert.assertEquals("07-21 00:00:00", format.format(date));

        calendar.set(2014, Calendar.JULY, 27);
        date = CommonCalendar.unitMin(calendar, Calendar.DATE);
        Assert.assertEquals("07-27 00:00:00", format.format(date));

        calendar.set(2014, Calendar.JULY, 27);
        date = CommonCalendar.unitMin(calendar, Calendar.MONTH);
        Assert.assertEquals("07-00 00:00:00", format.format(date));
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
        calendar.set(Calendar.MONTH, 0);
        Date date = CommonCalendar.quarterMin(calendar);
        Assert.assertEquals("01 00:00:00", format.format(date));

        calendar.set(Calendar.MONTH, 1);
        date = CommonCalendar.quarterMin(calendar);
        Assert.assertEquals("01 00:00:00", format.format(date));

        calendar.set(Calendar.MONTH, 2);
        date = CommonCalendar.quarterMin(calendar);
        Assert.assertEquals("01 00:00:00", format.format(date));

        calendar.set(Calendar.MONTH, 4);
        date = CommonCalendar.quarterMin(calendar);
        Assert.assertEquals("04 00:00:00", format.format(date));

        calendar.set(Calendar.MONTH, 5);
        date = CommonCalendar.quarterMin(calendar);
        Assert.assertEquals("04 00:00:00", format.format(date));
    }

    @Test
    public void testQuarterMax() throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("MM-dd HH:mm:ss");
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, Calendar.FEBRUARY);
        Date date = CommonCalendar.quarterMax(calendar);
        Assert.assertEquals("03-31 23:59:59", format.format(date));

        calendar.set(Calendar.MONTH, 4);
        date = CommonCalendar.quarterMax(calendar);
        Assert.assertEquals("06-30 23:59:59", format.format(date));

    }

    @Test
    public void testQuarterRange() throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, 0);
        Range<Date> range = CommonCalendar.quarterRange(calendar);
        Assert.assertEquals("01-01 00:00:00", format.format(range.getMinimum()));
        Assert.assertEquals("03-31 23:59:59", format.format(range.getMaximum()));

        calendar.set(Calendar.MONTH, 4);
        range = CommonCalendar.quarterRange(calendar);
        Assert.assertEquals("04-01 00:00:00", format.format(range.getMinimum()));
        Assert.assertEquals("06-30 23:59:59", format.format(range.getMaximum()));
    }

    @Test
    public void testWeekMin() throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DATE, 27);
        Date date = CommonCalendar.weekMin(calendar);
        Assert.assertEquals("07-21 00:00:00", format.format(date));

        calendar.set(Calendar.DATE, 28);
        date = CommonCalendar.weekMin(calendar);
        Assert.assertEquals("07-28 00:00:00", format.format(date));

        calendar.set(Calendar.DATE, 31);
        date = CommonCalendar.weekMin(calendar);
        Assert.assertEquals("07-28 00:00:00", format.format(date));
    }

    @Test
    public void testWeekMax() throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.set(2014, Calendar.JULY, 27);
        Date date = CommonCalendar.weekMax(calendar);
        Assert.assertEquals("07-27 23:59:59", format.format(date));

        calendar.set(2014, Calendar.JULY, 28);
        date = CommonCalendar.weekMax(calendar);
        Assert.assertEquals("08-03 23:59:59", format.format(date));

        calendar.set(2014, Calendar.JULY, 31);
        date = CommonCalendar.weekMax(calendar);
        Assert.assertEquals("08-03 23:59:59", format.format(date));
    }

    @Test
    public void testWeekRange() throws Exception {
        calendar.set(2014, 06, 29);
        Range<Date> range = CommonCalendar.weekRange(calendar);
        Assert.assertEquals("07-28 00:00:00", format.format(range.getMinimum()));
        Assert.assertEquals("08-03 23:59:59", format.format(range.getMaximum()));

    }


    @Test
    public void testGenerateDateRange() throws Exception {
        Calendar calendar = Calendar.getInstance();
        Map<String, Range<Date>> timeRanges = CommonCalendar.generateDateRange();

    }
}