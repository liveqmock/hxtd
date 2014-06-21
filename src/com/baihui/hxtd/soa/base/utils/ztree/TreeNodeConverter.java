package com.baihui.hxtd.soa.base.utils.ztree;

import org.springframework.core.convert.ConversionService;

import java.util.ArrayList;
import java.util.List;

/**
 * 树节点转换器
 *
 * @author xiayouxue
 * @date 2014/6/6
 */
public class TreeNodeConverter {

    private static ConversionService conversionService;

    /**
     * 转换成树节点
     */
    public static <T> TreeNode convert(T t) {
        return conversionService.convert(t, TreeNode.class);
    }

    /**
     * 转换成树节点集合
     */
    public static <T> List<TreeNode> convert(List<T> ts) {
        List<TreeNode> treeNodes = new ArrayList<TreeNode>();
        for (T t : ts) {
            treeNodes.add(convert(t));
        }
        return treeNodes;
    }

    public static ConversionService getConversionService() {
        return conversionService;
    }

    public  void setConversionService(ConversionService conversionService) {
        TreeNodeConverter.conversionService = conversionService;
    }
}
