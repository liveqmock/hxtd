package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.common.dao.WFNodeDao;
import com.baihui.hxtd.soa.common.entity.WFNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 功能描述：联系纪要service层
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.service.ApproveService.java
 * @date 2014-5-26 上午11:16:20
 * @since (该版本支持的 JDK 版本) ： 1.5
 */
@Service
@Transactional
public class WFNodeService {

    private Logger logger = LoggerFactory.getLogger(MemoirService.class);

    @Resource
    private WFNodeDao wfNodeDao;


    public List<WFNode> findByModuleId(Long moduleId) {
        String hql = "select node from WFNode node" +
                " inner join fetch node.role" +
                " inner join fetch node.module module" +
                " where module.id=?" +
                " order by node.code";
        return wfNodeDao.find(hql, moduleId);
    }


    public WFNode getNextWFNode(Long order) {
        String hql = "select n from WFNode n where n.order = ?";
        return wfNodeDao.findUnique(hql, order + 1);
    }

}
