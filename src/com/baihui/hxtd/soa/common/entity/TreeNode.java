package com.baihui.hxtd.soa.common.entity;

import java.util.List;

/**
 * 树形的
 *
 * @author xiayouxue
 * @date 2014/6/20
 */
public interface TreeNode<T extends TreeNode> extends Orderable, Idable {

    public Integer getLevel();

    public void setLevel(Integer level);

    public Boolean getIsLeaf();

    public void setIsLeaf(Boolean isLeaf);

    public T getParent();

    public void setParent(T treeNode);

    public List<T> getChildren();
}
