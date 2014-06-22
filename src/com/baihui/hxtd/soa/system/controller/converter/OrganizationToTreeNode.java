package com.baihui.hxtd.soa.system.controller.converter;

import com.baihui.hxtd.soa.base.utils.ztree.TreeNode;
import com.baihui.hxtd.soa.system.entity.Organization;
import org.dozer.Mapper;
import org.springframework.core.convert.converter.Converter;

import javax.annotation.Resource;

/**
 * 组织转换成树节点
 */
public class OrganizationToTreeNode implements Converter<Organization, TreeNode> {

    @Resource
    private Mapper mapper;

    @Override
    public TreeNode convert(Organization organization) {
        organization.setChildren(null);
        TreeNode treeNode = mapper.map(organization, TreeNode.class);
        treeNode.setIsParent(!organization.getIsLeaf());
        try {
            Organization parent = organization.getParent();
            treeNode.setpId(parent == null ? 0l : parent.getId());
        } catch (Exception e) {
            treeNode.setpId(0l);
        }
        treeNode.setOpen(true);
        return treeNode;
    }

}