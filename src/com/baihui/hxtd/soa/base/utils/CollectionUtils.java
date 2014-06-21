package com.baihui.hxtd.soa.base.utils;

import java.util.Collection;

/**
 * 集合工具类
 *
 * @author xiayouxue
 * @date 2014/6/20
 */
public class CollectionUtils {

    /**
     * 转换集合至父类
     */
    public static <X extends Collection<P>, P, T extends P> X castToSuper(Collection<T> sources, Collection<P> targets) {
        for (T source : sources) {
            targets.add(source);
        }
        return (X) targets;
    }
}
