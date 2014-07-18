package com.baihui.hxtd.soa.util;

import org.apache.commons.lang3.Range;
import org.apache.commons.lang3.time.DateUtils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 共通日历类
 *
 * @author jason 1.0
 * @version 1.0
 */
public class CommonCalendar {

    /** 推导模式 向前 */
    public static final int MODE_AHEAD = -1;

    /** 推导模式 向后 */
    public static final int MODE_BEHIND = 1;

    /** 日期格式 年月 yyyy */
    public static final String FORMAT_Y1 = "yyyy";

    /** 日期格式 年月 yyyyMM */
    public static final String FORMAT_YM1 = "yyyyMM";

    /** 日期格式 年月 yyyy-MM */
    public static final String FORMAT_YM2 = "yyyy-MM";

    /** 日期格式 年月日 yyyyMMdd */
    public static final String FORMAT_YMD1 = "yyyyMMdd";

    /** 日期格式 年月日 yyyy-MM-dd */
    public static final String FORMAT_YMD2 = "yyyy-MM-dd";

    /** 日期格式 年月日时分秒 yyyy-MM-dd HH:mm:ss */
    public static final String FORMAT_YMDHMS1 = "yyyy-MM-dd HH:mm:ss";

    /**
     * 获取当前日期转换为指定格式、指定单位、指定模式、指定数量的偏离量日期
     *
     * @param unit
     * @param mode
     * @param quantity
     * @return
     */
    public static Date currentDate2Offset(int unit, int mode, int quantity) {

        return date2Offset(null, unit, mode, quantity);
    }

    /**
     * 获取当前日期转换为指定格式、指定单位、指定模式、指定数量的偏离量日期
     *
     * @param format
     * @param unit
     * @param mode
     * @param quantity
     * @return
     */
    public static String currentDate2Offset(String format, int unit,
                                            int mode, int quantity) {

        return date2Offset(null, format, unit, mode, quantity);
    }

    /**
     * 根据指定日期，转换为指定单位、指定模式、指定数量的偏离量日期
     *
     * @param defaultDate
     * @param unit
     * @param mode
     * @param quantity
     * @return
     */
    public static Date date2Offset(Date defaultDate, int unit, int mode,
                                   int quantity) {

        Calendar calendar = Calendar.getInstance();

        if (defaultDate != null) {
            calendar.setTime(defaultDate);
        }

		/* 设置日历按指定单位、指定模式、指定数量改变后的日期 */
        calendar.add(unit, mode * quantity);

		/* 取得指定的日期 */
        return calendar.getTime();    // 日期
    }

    /**
     * 根据指定日期，转换为指定格式、指定单位、指定模式、指定数量的偏离量日期
     *
     * @param defaultDate
     * @param format
     * @param unit
     * @param mode
     * @param quantity
     * @return
     */
    public static String date2Offset(Date defaultDate, String format,
                                     int unit, int mode, int quantity) {

		/* 日期格式化 */
        SimpleDateFormat sf = new SimpleDateFormat(format);

		/* 格式化指定的日期 */
        return sf.format(date2Offset(defaultDate, unit, mode, quantity));
    }

    /**
     * 获得上周星期一的日期
     *
     * @return
     */
    public static String getPreviousMonday(Calendar calendar) {
        calendar.add(Calendar.DATE, -6 - (calendar.get(Calendar.DAY_OF_WEEK) - 1));
        return DateFormat.getDateInstance().format(calendar.getTime());
    }

    /**
     * 获得上周星期日的日期
     *
     * @return
     */
    public static String getPreviousSunday(Calendar calendar) {
        calendar.add(Calendar.DATE, -(calendar.get(Calendar.DAY_OF_WEEK) - 1));
        return DateFormat.getDateInstance().format(calendar.getTime());
    }

    /**
     * 获得上月第一天
     *
     * @return
     */
    public static String getPreviousMonthFirst(Calendar lastDate) {
        lastDate.set(Calendar.DATE, 1);// 设为当前月的1号   
        lastDate.add(Calendar.MONTH, -1);// 减一个月，变为上月的1号   

        return new SimpleDateFormat("yyyy-MM-dd").format(lastDate.getTime());
    }

    /**
     * 获得某月第一天
     *
     * @return
     * @throws ParseException
     */
    public static String getBiggerDay(String lastDate) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
        calendar.setTime(formater.parse(lastDate));
        calendar.add(Calendar.DATE, 1);
        return formater.format(calendar.getTime());
    }

    /**
     * 获得上季度第一天的日期
     *
     * @param month :当前是几月（01~12），共四个季度分别是：
     *              1：01-01 ~ 03-31  2：04-01 ~ 06-30
     *              3：07-01 ~ 09-30  4：10-01 ~ 12-31
     */
    public static String getPreviousSeasonFirst(String date) {
        String result = "";
        int month = Integer.valueOf(date.substring(5, 7));
        //(month - 1) / 3 :计算出上个季度是第几季度
        switch ((month - 1) / 3) {
            case 0:
                result = Integer.valueOf(date.substring(0, 4)) - 1 + "-" + "10-01";
                break;
            case 1:
                result = Integer.valueOf(date.substring(0, 4)) + "-" + "01-01";
                break;
            case 2:
                result = Integer.valueOf(date.substring(0, 4)) + "-" + "04-01";
                break;
            case 3:
                result = Integer.valueOf(date.substring(0, 4)) + "-" + "07-01";
                break;
        }
        return result;
    }

    /**
     * 获得上季度最后一天的日期
     *
     * @param month :当前是几月（01~12），共四个季度分别是：
     *              1：01-01 ~ 03-31  2：04-01 ~ 06-30
     *              3：07-01 ~ 09-30  4：10-01 ~ 12-31
     */
    public static String getPreviousSeasonLast(String date) {

        String result = "";
        int month = Integer.valueOf(date.substring(5, 7));

        //(month - 1) / 3 :计算出上个季度是第几季度
        switch ((month - 1) / 3) {
            case 0:
                result = Integer.valueOf(date.substring(0, 4)) - 1 + "-" + "12-31";
                break;
            case 1:
                result = Integer.valueOf(date.substring(0, 4)) + "-" + "03-31";
                break;
            case 2:
                result = Integer.valueOf(date.substring(0, 4)) + "-" + "06-30";
                break;
            case 3:
                result = Integer.valueOf(date.substring(0, 4)) + "-" + "09-30";
                break;
        }
        return result;
    }


    /** 日历单位配置 */
    private final static Map<String, Integer> CALENDAR_UNITS = new LinkedHashMap<String, Integer>();

    /** 季度月份配置 */
    private final static Map<Integer, Range<Integer>> QUARTER_MONTHS = new HashMap<Integer, Range<Integer>>();

    static {
        CALENDAR_UNITS.put("当前分钟", Calendar.MINUTE);
        CALENDAR_UNITS.put("当前小时", Calendar.HOUR);
        CALENDAR_UNITS.put("当日", Calendar.DAY_OF_MONTH);
        CALENDAR_UNITS.put("本周", null);     //不被支持，另行转换
        CALENDAR_UNITS.put("本月", Calendar.MONTH);
        CALENDAR_UNITS.put("本季度", null);   //不被支持，另行转换
        CALENDAR_UNITS.put("本年", Calendar.YEAR);

        for (int i = 0; i < 4; i++) {
            QUARTER_MONTHS.put(i + 1, Range.between(i * 3, (i + 1) * 3 - 1));
        }
    }

    /** 生成指定日期范围 */
    public static Map<String, Range<Date>> generateDateRange(Date current) {
        LinkedHashMap<String, Range<Date>> ranges = new LinkedHashMap<String, Range<Date>>();

        //规则的
        for (String key : CALENDAR_UNITS.keySet()) {
            Integer value = CALENDAR_UNITS.get(key);
            if (value == null) {
                ranges.put(key, null);
                continue;
            }
            Date min = DateUtils.truncate(current, value);
            Date max = DateUtils.ceiling(current, value);
            ranges.put(key, Range.between(min, DateUtils.addSeconds(max, -1)));
        }

        //本周
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current);
        int weekDay = calendar.get(Calendar.DAY_OF_WEEK);
        weekDay--;
        ranges.put("本周", truncateDateRange(calendar, Calendar.DAY_OF_MONTH, weekDay, Range.between(1, 7)));

        //本季度
        calendar.setTime(current);
        int month = calendar.get(Calendar.MONTH);
        int quarter = findQuarter(month);
        Range<Integer> monthRange = QUARTER_MONTHS.get(quarter);
        Range<Date> quarterRange = truncateDateRange(calendar, Calendar.MONTH, month, monthRange);
        ranges.put("本季度", quarterRange);

        return ranges;
    }

    /** 精确日期范围 */
    public static Range<Date> truncateDateRange(Calendar calendar, int unit, int value, Range<Integer> range) {
        calendar.add(unit, -(value - range.getMinimum()));
        Date min = DateUtils.truncate(calendar.getTime(), unit);
        calendar.add(unit, range.getMaximum() - range.getMinimum());
        Date max = DateUtils.ceiling(calendar.getTime(), unit);
        return Range.between(min, DateUtils.addSeconds(max, -1));
    }

    /** 查找季度值 */
    public static int findQuarter(int month) {
        for (Integer key : QUARTER_MONTHS.keySet()) {
            Range<Integer> value = QUARTER_MONTHS.get(key);
            if (value.contains(month)) {
                return key;
            }
        }
        return -1;
    }

    /** 生成当前日期范围 */
    public static Map<String, Range<Date>> generateDateRange() {
        return generateDateRange(new Date());
    }


}
