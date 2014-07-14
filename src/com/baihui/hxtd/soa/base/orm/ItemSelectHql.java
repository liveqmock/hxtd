package com.baihui.hxtd.soa.base.orm;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;

import java.util.ArrayList;
import java.util.List;

/**
 * hql select
 * 用于构建 select hql 语句的对象
 *
 * @author xiayouxue
 * @date 14-7-12
 */
public class ItemSelectHql extends SelectHql {

    protected List<String> selectItems;         //查询部分各项值
    protected List<String> fromItems;           //from部分各项值
    protected List<String> whereItems;          //查询条件部分各项值
    protected List<String> groupByItems;        //分组部分各项值
    protected List<String> havingItems;         //分组筛选部分各项值
    protected List<String> orderByItems;        //排序部分各项值

    public ItemSelectHql() {
        setSelectItems(new ArrayList<String>());
        setFromItems(new ArrayList<String>());
        setWhereItems(new ArrayList<String>());
        setGroupByItems(new ArrayList<String>());
        setHavingItems(new ArrayList<String>());
        setOrderByItems(new ArrayList<String>());
    }

    @Override
    public String toString() {
        toSelect().toFrom().toWhere().toGroupBy().toHaving().toOrderBy();
        return super.toString();
    }

    /**
     * 转换select部分
     */
    public ItemSelectHql toSelect() {
        setSelect(StringUtils.join(getSelectItems(), ","));
        return this;
    }

    /**
     * 转换from部分
     */
    public ItemSelectHql toFrom() {
        setFrom(StringUtils.join(getFromItems(), " "));
        return this;
    }

    /**
     * 转换where部分
     */
    public ItemSelectHql toWhere() {
        setWhere(StringUtils.join(getWhereItems(), " and "));
        return this;
    }

    /**
     * 转换group by部分
     */
    public ItemSelectHql toGroupBy() {
        setGroupBy(StringUtils.join(getGroupByItems(), ","));
        return this;
    }

    /**
     * 转换having部分
     */
    public ItemSelectHql toHaving() {
        setHaving(StringUtils.join(getHavingItems(), " and "));
        return this;
    }

    /**
     * 转换order by部分
     */
    public ItemSelectHql toOrderBy() {
        setOrderBy(StringUtils.join(getOrderByItems(), ","));
        return this;
    }

    public List<String> getSelectItems() {
        return selectItems;
    }

    public void setSelectItems(List<String> selectItems) {
        this.selectItems = selectItems;
    }

    public List<String> getFromItems() {
        return fromItems;
    }

    public void setFromItems(List<String> fromItems) {
        this.fromItems = fromItems;
    }

    public List<String> getWhereItems() {
        return whereItems;
    }

    public void setWhereItems(List<String> whereItems) {
        this.whereItems = whereItems;
    }

    public List<String> getGroupByItems() {
        return groupByItems;
    }

    public void setGroupByItems(List<String> groupByItems) {
        this.groupByItems = groupByItems;
    }

    public List<String> getHavingItems() {
        return havingItems;
    }

    public void setHavingItems(List<String> havingItems) {
        this.havingItems = havingItems;
    }

    public List<String> getOrderByItems() {
        return orderByItems;
    }

    public void setOrderByItems(List<String> orderByItems) {
        this.orderByItems = orderByItems;
    }
}
