package com.baihui.hxtd.soa.common.dao;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernateDAOImpl;
import com.baihui.hxtd.soa.common.entity.FlowNode;
import com.baihui.hxtd.soa.common.entity.NodeType;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 功能描述：联系纪要持久化层
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.dao.ApproveDao.java
 * @date 2014-5-26 上午11:15:52
 * @since (该版本支持的 JDK 版本) ： 1.5
 */
@Repository
public class FlowNodeDao extends HibernateDAOImpl<FlowNode, Long> {

    /** 查找流程环节通过流程类型值 */
    public List<FlowNode> findAllOfFlow(String flowValue) {
        String hql = "select node from FlowNode node" +
                " inner join fetch node.flow flow" +
                " left join fetch node.role role" +
                " where flow.value=?" +
                " order by node.code";
        return find(hql, flowValue);
    }

    /** 查找开始流程环节通过流程类型值 */
    public FlowNode findStartOfFlow(String flowValue) {
        String hql = "select node from FlowNode node" +
                " left join fetch node.flow flow" +
                " left join fetch node.role role" +
                " where flow.value=? and node.type=?";
        return findUnique(hql, flowValue, NodeType.start.getValue());
    }

    /** 查找结束流程环节通过流程类型值 */
    public List<FlowNode> findEndOfFlow(String flowValue) {
        String hql = "select node from FlowNode node" +
                " left join fetch node.role role" +
                " left join fetch node.flow flow" +
                " where flow.value=? and node.type=?";
        return find(hql, flowValue, NodeType.end.getValue());
    }

}
