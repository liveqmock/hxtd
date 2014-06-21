package com.baihui.hxtd.soa.common.entity;


/**
 * 可排序的
 */
public interface Orderable extends Comparable<Orderable> {

    public Long getOrder();

    public void setOrder(Long order);

}
