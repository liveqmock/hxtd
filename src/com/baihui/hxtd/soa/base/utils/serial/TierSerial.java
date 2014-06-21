package com.baihui.hxtd.soa.base.utils.serial;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 有层次的序号
 * <p/>
 * 10101按层次长度为2解析得到values=[1,1,1],level=3,value=1
 * 10100按层次长度为2解析得到values=[1,1,0],level=2,value=1
 */
public class TierSerial implements Cloneable {

    private int count;//层次数目
    private int length;//层次长度
    private List<Integer> values;//各个层次对应值的集合
    private int level;//当前级别，从左至右由1开始

    /**
     * 获取当前级别对应值
     */
    public int getValue() {
        return getValues().get(getLevel() - 1);
    }

    /**
     * 获取层次级别增长值
     */
    public int getTierIncrease() {
        return (int) Math.pow(10, getLength());
    }

    /**
     * 获取当前级别对应的增长值
     */
    public long getIncrease() {
        return (long) Math.pow(10, (getCount() - getLevel()) * getLength());
    }

    /**
     * 获取序号值
     */
    public long getSerial() {
        StringBuffer serial = new StringBuffer();
        for (int i = 0; i < getValues().size(); i++) {
            Integer value = getValues().get(i);
            serial.append(StringUtils.leftPad(String.valueOf(value), getLength(), '0'));
        }
        return Long.parseLong(serial.toString());
    }

    /**
     * 增长值
     * 1.在当前层级上
     */
    public void increaseValue(int number) {
        TierSerial tierSerial = this;
        int newValue = tierSerial.getValue() + number;
        int min = 1;
        int max = (int) Math.pow(10, tierSerial.getLength());
        if (newValue >= min && newValue <= max) {
            tierSerial.getValues().set(tierSerial.getLevel() - 1, newValue);
        } else {
            throw new OverSerialTierContentException(newValue, min, max);
        }
    }

    /**
     * 获取当前节点对应的跟节点
     * 1.保留首位数值
     * 2.其他位全部设为0
     * //TODO 总是返回拷贝或者当自身是根节点是返回自身
     */
    public TierSerial getRoot() {
        TierSerial root = clone();
        for (int i = 1; i < root.getLevel(); i++) {
            root.getValues().set(i, 0);
        }
        return root;
    }

    /**
     * 获取父节点
     */
    public TierSerial getParent() {
        //当且节点为根节点，返回null
        if (isRoot()) {
            return null;
        }
        TierSerial parent = clone();
        parent.setLevel(parent.getLevel() - 1);
        parent.getValues().set(parent.getLevel(), 0);
        return parent;
    }

    /**
     * 获取所有父节点
     */
    public List<TierSerial> getParents() {
        List<TierSerial> tierSerials = new ArrayList<TierSerial>();
        TierSerial current = this;
        while (current != null) {
            tierSerials.add(current);
            current = current.getParent();
        }
        Collections.reverse(tierSerials);
        return tierSerials;
    }

    /**
     * 获取所有父节点
     */
    public List<TierSerial> getParentsUntil() {
        List<TierSerial> tierSerials = new ArrayList<TierSerial>();
        TierSerial current = this;
        while (current != null) {
            tierSerials.add(current);
            current = current.getParent();
        }
        Collections.reverse(tierSerials);
        return tierSerials;
    }

    /**
     * 获取当前级别下一位兄弟节点
     */
    public TierSerial next() {
        TierSerial next = clone();
        next.increaseValue(1);
        return next;
    }

    /**
     * 获取当前级别最小的子节点
     */
    public TierSerial getMinChild() {
        if (getLevel() == getCount())
            throw new NoChildAllowedException();
        TierSerial minChild = clone();
        minChild.getValues().set(getLevel(), 1);
        return minChild;
    }

    /**
     * 是否叶子节点
     */
    public boolean isLeaf() {
        return getLevel() == getValues().size();
    }

    /**
     * 是否根节点
     */
    public boolean isRoot() {
        return getLevel() == 1;
    }


    protected TierSerial clone() {
        try {
            return (TierSerial) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new InternalError();
        }
    }

    public int getCount() {
        return count;
    }

    protected void setCount(int count) {
        this.count = count;
    }

    public int getLength() {
        return length;
    }

    protected void setLength(int length) {
        this.length = length;
    }

    public List<Integer> getValues() {
        return values;
    }

    public void setValues(List<Integer> values) {
        this.values = values;
    }

    public int getLevel() {
        return level;
    }

    protected void setLevel(int level) {
        this.level = level;
    }
}
