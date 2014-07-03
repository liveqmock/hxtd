package com.baihui.hxtd.soa.base.utils.serial;

import org.apache.commons.lang3.Range;
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
     * 获取完整的级别
     */
    public static int getFullLevel(long serial, int length) {
        int serialLength = String.valueOf(serial).length();
        int differ = serialLength % length == 0 ? 0 : 1;
        return serialLength / length + differ;
    }

    /**
     * 获取级别差值
     */
    public static int getLevelDiffer(long serial, int length) {
        int level = 0;
        int tierIncrease = getTierIncrease(length);
        long current = serial;
        while (current % tierIncrease == 0) {
            current = current / tierIncrease;
            level++;
        }
        return level;
    }

    /**
     * 获取级别差值
     */
    public static int getLevel(long serial, int length) {
        return getFullLevel(serial, length) - getLevelDiffer(serial, length);
    }

    /**
     * 获取级别增长值
     */
    public static long getIncrease(long serial, int length) {
        return (long) Math.pow(getTierIncrease(length), getLevelDiffer(serial, length));
    }

    /**
     * 是否根节点
     */
    public static boolean isRoot(long serial, int length) {
        return serial == 0l;
    }

    /**
     * 获取上级序号值
     * 1.无父节点时，返回0
     */
    public static Long getParent(long serial, int length) {
        long increase = getIncrease(serial, length) * getTierIncrease(length);
        return serial / increase * increase;
    }

    /**
     * 获取上级序号值
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

    /**
     * 获取上级序号值
     */
    public static List<Long> getParentsUntil(long serial, long until, int length) {
        List<Long> serials = getParents(serial, length);
        int index = serials.indexOf(until);
        for (int i = 0; i < index; i++) {
            serials.remove(i);
        }
        return serials;
    }

    /**
     * 获取最小的子序号
     */
    public static Long getMinChild(long serial, int length) {
        return serial + getIncrease(serial, length) / getTierIncrease(length);
    }

    /**
     * 获取最大的子序号
     */
    public static Long getMaxChild(long serial, int length) {
        int tierIncrease = getTierIncrease(length);
        long increase = getIncrease(serial, length);
        return serial + increase - increase / tierIncrease;
    }

    /**
     * 获取最大的序号
     */
    public static Long getMax(long serial, int length) {
        int tierIncrease = getTierIncrease(length);
        long increase = getIncrease(serial, length);
        return tierIncrease * increase - 1;
    }

    /**
     * 获取下级序号区间
     */
    public static Range<Long> getYoungerRange(long serial, int length) {
        int tierIncrease = getTierIncrease(length);
        long increase = getIncrease(serial, length);
        return Range.between(serial + increase / tierIncrease, serial + increase - 1);
    }


}
