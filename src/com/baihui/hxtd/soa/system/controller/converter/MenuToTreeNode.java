package com.baihui.hxtd.soa.system.controller.converter;

import com.baihui.hxtd.soa.base.utils.ztree.TreeNode;
import com.baihui.hxtd.soa.system.entity.Menu;
import org.dozer.Mapper;
import org.springframework.core.convert.converter.Converter;

import javax.annotation.Resource;

/**
 * 菜单转换成树节点
 */
public class MenuToTreeNode implements Converter<Menu, TreeNode> {

    @Resource
    private Mapper mapper;

    @Override
    public TreeNode convert(Menu menu) {
        TreeNode treeNode = mapper.map(menu, TreeNode.class);
        treeNode.setIsParent(!menu.getIsLeaf());
        Menu parent = menu.getParent();
        treeNode.setpId(parent == null ? 0l : parent.getId());
        treeNode.setOpen(false);
        return treeNode;
    }

}