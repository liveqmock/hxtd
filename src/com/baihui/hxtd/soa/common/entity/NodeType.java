package com.baihui.hxtd.soa.common.entity;

/**
 * 节点类型
 *
 * @author xiayouxue
 * @date 2014/7/22
 */
public enum NodeType {

    start(1), business(2), end(3);

    private int value;

    NodeType(int value) {
        this.value = value;
    }

    public static NodeType findByValue(int value) {
        NodeType[] nodeTypes = NodeType.values();
        for (int i = 0; i < nodeTypes.length; i++) {
            NodeType nodeType = nodeTypes[i];
            if (nodeType.getValue() == value) {
                return nodeType;
            }
        }
        return null;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
