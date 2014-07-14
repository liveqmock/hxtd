package com.baihui.hxtd.soa.base.orm;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;


/**
 * @author xiayouxue
 * @date 14-7-13
 */
public class SelectHql {

    protected String select;
    protected String from;
    protected String where;
    protected String groupBy;
    protected String having;
    protected String orderBy;

    public SelectHql() {
    }

    public SelectHql(String select, String from) {
        this.select = select;
        this.from = from;
    }

    @Override
    public String toString() {
        Validate.notEmpty(getSelect(), "select is empty");
        Validate.notEmpty(getFrom(), "from is empty");
        StringBuffer hql = new StringBuffer(String.format("select %s from %s", getSelect(), getFrom()));
        hql.append(getUnitHql("where", getWhere()));
        hql.append(getUnitHql("group by", getGroupBy()));
        hql.append(getUnitHql("having", getHaving()));
        hql.append(getUnitHql("order by", getOrderBy()));
        return hql.toString();
    }

    /**
     * 转换各部分的hql语句
     */
    public String getUnitHql(String unit, String value) {
        return StringUtils.isBlank(value) ? "" : String.format(" %s %s", unit, value);
    }

    public String getSelect() {
        return select;
    }

    public void setSelect(String select) {
        this.select = select;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getWhere() {
        return where;
    }

    public void setWhere(String where) {
        this.where = where;
    }

    public String getGroupBy() {
        return groupBy;
    }

    public void setGroupBy(String groupBy) {
        this.groupBy = groupBy;
    }

    public String getHaving() {
        return having;
    }

    public void setHaving(String having) {
        this.having = having;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
}
