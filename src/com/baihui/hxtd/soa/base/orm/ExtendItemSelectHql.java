package com.baihui.hxtd.soa.base.orm;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * HqlSelectFrom
 *
 * @author xiayouxue
 * @date 14-7-12
 */
public class ExtendItemSelectHql extends ItemSelectHql implements Cloneable {

    private String entityName;                  //实体类名
    private String entityAlias;                 //实体类别名
    private List<String> associationItems;      //关联部分各项值

    private Map<String, Object> conditionValues;//条件值，用于参数占位

    public ExtendItemSelectHql() {
        setAssociationItems(new ArrayList<String>());
        setConditionValues(new HashMap<String, Object>());
    }

    public ExtendItemSelectHql(String entityName) {
        this();
        Validate.notBlank(entityName, "entityName is blank");
        this.setEntityName(entityName);
    }

    public ExtendItemSelectHql(String entityName, String entityAlias) {
        this(entityName);
        Validate.notBlank(entityAlias, "entityAlias is blank");
        this.setEntityAlias(entityAlias);
    }

    @Override
    public ExtendItemSelectHql toFrom() {
        String entityAlias = this.entityAlias == null ? "" : this.entityAlias;
        String associationItems = CollectionUtils.isEmpty(this.associationItems) ? "" : StringUtils.join(this.associationItems, " ");
        setFrom(String.format("%s %s %s", entityName, entityAlias, associationItems));
        return this;
    }

    @Override
    public ExtendItemSelectHql clone() {
        try {
            return (ExtendItemSelectHql) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new RuntimeException("未预料到的异常！", e);
        }
    }

    public String getEntityName() {
        return entityName;
    }

    public void setEntityName(String entityName) {
        this.entityName = entityName;
    }

    public String getEntityAlias() {
        return entityAlias;
    }

    public void setEntityAlias(String entityAlias) {
        this.entityAlias = entityAlias;
    }

    public List<String> getAssociationItems() {
        return associationItems;
    }

    public void setAssociationItems(List<String> associationItems) {
        this.associationItems = associationItems;
    }

    public Map<String, Object> getConditionValues() {
        return conditionValues;
    }

    public void setConditionValues(Map<String, Object> conditionValues) {
        this.conditionValues = conditionValues;
    }
}
