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
        if (menu.equals(Menu.ROOT)) {
            treeNode.setpId(0l);
            treeNode.setIsParent(true);
            treeNode.setOpen(true);
        } else if (menu.getLevel() == 1) {
            treeNode.setpId(Menu.ROOT.getId());
            treeNode.setIsParent(!menu.getIsLeaf());
        } else if (menu.getLevel() == 2) {
            treeNode.setpId(menu.getParent().getId());
            treeNode.setIsParent(!menu.getIsLeaf());
        }
        return treeNode;
    }

}