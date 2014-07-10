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

	/**系统数据管理员（可以看到所有数据）*/
    private Boolean isSysDataManager = false;
    
    /**组织数据管理员（可以看到同一组织中的数据）*/
    private Boolean isOrgDataManager = false;
    
    private String userFieldName = "owner";
    private String userAlias = "owner";
    private String organizationFieldName = "organization";
    private String organizationAlias = "organization";
    private Long userId;
    private Range<Long> orderRange;

    public DataShift(boolean isSysDataManager, boolean isOrgDataManager,Long userId, Range<Long> orderRange) {
        this.isSysDataManager = isSysDataManager;
        this.isOrgDataManager = isOrgDataManager;
        this.userId = userId;
        this.orderRange = orderRange;
    }

    public DataShift(boolean isSysDataManager, boolean isOrgDataManager,String userFieldName, Long userId, Range<Long> orderRange) {
        this.isSysDataManager = isSysDataManager;
        this.isOrgDataManager = isOrgDataManager;
        this.userFieldName = userFieldName;
        this.userId = userId;
        this.orderRange = orderRange;
    }

    public DataShift(boolean isSysDataManager,boolean isOrgDataManager, String organizationFieldName, String organizationAlias, String userFieldName, String userAlias, Long userId, Range<Long> orderRange) {
        this.isSysDataManager = isSysDataManager;
        this.isOrgDataManager = isOrgDataManager;
        this.organizationFieldName = organizationFieldName;
        this.organizationAlias = organizationAlias;
        this.userFieldName = userFieldName;
        this.userAlias = userAlias;
        this.userId = userId;
        this.orderRange = orderRange;
    }

    /**
     * 重命名用户字段名称
     * 1.根据当前对象创建出修改用户字段名称后的对象
     */
    public DataShift renameUserFieldName(String userFieldName) {
        return new DataShift(this.getIsSysDataManager(),this.getIsOrgDataManager(), userFieldName, this.getUserId(), this.getOrderRange());
    }

    /**
     * 转换为部分HQL语句，包括级联抓取和条件筛选部分
     */
    public String toHql(String aliasName) {
        StringBuffer hql = new StringBuffer();
        hql.append(String.format(" inner join fetch %s.%s %s", aliasName, getUserFieldName(), getUserAlias()));
        hql.append(String.format(" inner join fetch %s.%s %s", getUserAlias(), getOrganizationFieldName(), getOrganizationAlias()));
        String siftUserId = String.format("%s.id=%s", getUserAlias(), getUserId());
        String siftOrganization = String.format("%s.order between %s and %s", getOrganizationAlias(), getOrderRange().getMinimum(), getOrderRange().getMaximum());
        hql.append(String.format(" where (%s) or (%s)", siftUserId, siftOrganization));
        return hql.toString();
    }

    public Boolean getIsSysDataManager() {
        return isSysDataManager;
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

	public Boolean getIsOrgDataManager() {
		return isOrgDataManager;
	}

}
