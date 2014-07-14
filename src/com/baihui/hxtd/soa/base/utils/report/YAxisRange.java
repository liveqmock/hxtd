package com.baihui.hxtd.soa.base.utils.report;

/**
 * @author xiayx
 * @date 14-7-13
 */
public class YAxisRange<T> {

    private T min;
    private T max;
    private T step;

    public YAxisRange() {
    }

    public YAxisRange(T min, T max, T step) {
        this.min = min;
        this.max = max;
        this.step = step;
    }

    public static <T> YAxisRange<T> parse(T min, T max, T step, Class<T> clazz) {
        return new YAxisRange<T>(min, max, step);
    }

    public T getMin() {
        return min;
    }

    public void setMin(T min) {
        this.min = min;
    }

    public T getMax() {
        return max;
    }

    public void setMax(T max) {
        this.max = max;
    }

    public T getStep() {
        return step;
    }

    public void setStep(T step) {
        this.step = step;
    }
}
