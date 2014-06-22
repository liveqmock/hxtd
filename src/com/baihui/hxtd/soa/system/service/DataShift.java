package com.baihui.hxtd.soa.system.service;

import org.apache.commons.lang3.Range;

/**
 * 数据筛选类
 * 1.一般情况下使用session中的DataShift
 * 2.如果对应的字段名或者别名有更改，需要自己重新实例化对象，不提供set方法
 *
 * @author xiayouxue
 * @date 2014/6/22
 */
public class DataShift {

    private Boolean isDataManager = false;
    private String userFieldName = "owner";
    private String userAlias = "owner";
    private String organizationFieldName = "organization";
    private String organizationAlias = "organization";
    private Long userId;
    private Range<Long> orderRange;

    public DataShift(boolean isDataManager, Long userId, Range<Long> orderRange) {
        this.isDataManager = isDataManager;
        this.userId = userId;
        this.orderRange = orderRange;
    }

    public DataShift(boolean isDataManager, String userFieldName, Long userId, Range<Long> orderRange) {
        this.isDataManager = isDataManager;
        this.userFieldName = userFieldName;
        this.userId = userId;
        this.orderRange = orderRange;
    }

    public DataShift(boolean isDataManager, String organizationFieldName, String organizationAlias, String userFieldName, String userAlias, Long userId, Range<Long> orderRange) {
        this.isDataManager = isDataManager;
        this.organizationFieldName = organizationFieldName;
        this.organizationAlias = organizationAlias;
        this.userFieldName = userFieldName;
        this.userAlias = userAlias;
        this.userId = userId;
        this.orderRange = orderRange;
    }

    public Boolean getIsDataManager() {
        return isDataManager;
    }

    public String getUserFieldName() {
        return userFieldName;
    }

    public String getUserAlias() {
        return userAlias;
    }

    public String getOrganizationFieldName() {
        return organizationFieldName;
    }

    public String getOrganizationAlias() {
        return organizationAlias;
    }

    public Long getUserId() {
        return userId;
    }

    public Range<Long> getOrderRange() {
        return orderRange;
    }

}
