package com.baihui.hxtd.soa.base.utils.serial;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * TierSerial工具类
 */
public class TierSerials {


    /**
     * 解析排序号获取TierSerial
     * //TODO 关于解析时传入count的严格限定
     */
    public static TierSerial parse(long serial, int length) {
        TierSerial tierSerial = new TierSerial();

        //转换为string
        String serialstr = String.valueOf(serial);
        int remainder = serialstr.length() % length;
        if (remainder != 0) {
            int differ = length - remainder;
            serialstr = StringUtils.repeat("0", differ) + serialstr;
        }

        //设置count和length
        tierSerial.setCount(serialstr.length() / length);
        tierSerial.setLength(length);
        tierSerial.setValues(new ArrayList<Integer>(tierSerial.getCount()));
        for (int i = 0; i < serialstr.length(); i = i + length) {
            tierSerial.getValues().add(Integer.parseInt(serialstr.substring(i, i + length)));
        }

        /*设置value和level*/
        //设置默认的value和level为values的最后一个
        tierSerial.setLevel(tierSerial.getCount());
        //设置实际找到的value和level，实际未找到即=最后一个=默认的
        for (int i = 0; i < tierSerial.getValues().size(); i++) {
            if (tierSerial.getValues().get(i) == 0) {
                tierSerial.setLevel(i);
                break;
            }
        }

        return tierSerial;
    }


    public static int generatStartSerial(int count, int length) {
        return (int) Math.pow(10, (count - 1) * length);
    }

    /**
     * 获取层次级别增长值
     */
    public static int getTierIncrease(int length) {
        return (int) Math.pow(10, length);
    }

    /**
     * 获取级别增长值
     */
    public static long getIncrease(long serial, int length) {
        int tierIncrease = getTierIncrease(length);
        int increase = tierIncrease;
        int level = 0;
        while (serial % tierIncrease == 0) {
            serial = serial / tierIncrease;
            level++;
        }
        return (long) Math.pow(increase, level);
    }

    /**
     * 获取上级序列号
     */
    public static List<Long> getParents(long serial, int length) {
        List<Long> serials = new ArrayList<Long>();

        int increase = getTierIncrease(length);
        long current = serial;
        int increases = 1;
        long remainder = current % increase;
        while (remainder == 0) {
            current = current / increase;
            remainder = current % increase;
            increases *= increase;
        }

        current = current / increase;
        increases *= increase;
        while (current > 0) {
            serials.add(current * increases);
            current = current / increase;
            increases *= increase;
        }

        Collections.reverse(serials);

        return serials;
    }

    public static Long getMinChild(long serial, int length) {
        int increase = getTierIncrease(length);
        return serial + serial / increase;
    }

    public static Long getMaxChild(long serial, int length) {
        int increase = getTierIncrease(length);
        return serial + serial / increase * (increase - 1);
    }


    /**
     * 获取上级序列号
     */
    public static List<Long> getParentsUntil(long serial, long until, int length) {
        List<Long> serials = getParents(serial, length);
        int index = serials.indexOf(until);
        for (int i = 0; i < index; i++) {
            serials.remove(i);
        }
        return serials;
    }


}
