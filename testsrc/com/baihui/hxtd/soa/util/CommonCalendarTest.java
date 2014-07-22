package com.baihui.hxtd.soa.util;

import org.apache.commons.lang3.time.DateUtils;
import org.junit.Test;

import java.util.Calendar;
import java.util.Date;

public class CommonCalendarTest {

    @Test
    public void testGenerateDateRange() throws Exception {
        Calendar calendar = Calendar.getInstance();
        int week = calendar.get(Calendar.WEEK_OF_MONTH);
        System.out.println("week:" + week);
        Date truncate = DateUtils.truncate(calendar.getTime(), Calendar.WEEK_OF_MONTH);
        calendar.setTime(truncate);
        week = calendar.get(Calendar.WEEK_OF_MONTH);
        System.out.println("week:" + week);
    }
}