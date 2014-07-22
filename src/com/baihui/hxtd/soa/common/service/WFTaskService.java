package com.baihui.hxtd.soa.common.service;

import com.baihui.hxtd.soa.common.controller.model.FlowModel;
import com.baihui.hxtd.soa.common.dao.WFNodeDao;
import com.baihui.hxtd.soa.common.dao.WFTaskDao;
import com.baihui.hxtd.soa.common.entity.WFNode;
import com.baihui.hxtd.soa.common.entity.WFTask;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 功能描述：联系纪要service层
 *
 * @author lihua
 * @version (版本)1
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司
 * @ClassName: com.baihui.hxtd.soa.common.service.WFTaskService.java
 * @date 2014-5-26 上午11:16:20
 * @since (该版本支持的 JDK 版本) ： 1.5
 */
@Service
@Transactional
public class WFTaskService {

    @Resource
    private WFTaskDao wfTaskDao;

    @Resource
    private WFNodeDao wfNodeDao;

    //private Logger logger = LoggerFactory.getLogger(MemoirService.class);
    /**********订单审批相关角色代码****************//*
    private final String finanManager = "OD_001"; //理财经理
	private final String investManager = "OD_002"; //投资经理
	private final String principleManager = "OD_003"; //投资总监
	private final String vicePresManager = "OD_004"; //副总经理  -> 副总裁
	private final String presidentManager = "OD_005"; //总裁
	
	@Resource
	private WFTaskDao wfTaskDao;
	
	@Resource
	private WFNodeService wfNodeService;
	
	@Resource
	private DictionaryService dicService;
	
	*//**
     * insertOrderWfTask(批量新增订单审批任务)
     * @Description: 批量新增订单审批任务
     * @param userId 订单创建人ID
     * @param orgId  订单创建人所在机构Id
     * @param wfType 流程类型
     *//*
    public void insertOrderWfTask(Long userId, Long orgId, String wfType){
		*//****************获取订单流程节点******************//*
        List<WFNode> nodeLst = wfNodeService.findByFlowValue(wfType);
		
		*//****************生成审批任务*********************//*
        List<WFTask> taskLst = new ArrayList<WFTask>();
		//String nodeCode;
		for(WFNode node : nodeLst){
			WFTask task = new WFTask();
			task.setWfNode(node);
			User user = new User(userId);
			task.setCreator(user);
			task.setCreatedTime(new Date());
			task.setModifier(user);
			
			//nodeCode = node.getCode();
			if(nodeCode.equals("001")){ //理财经理
				task.setApprover(user);
				task.setOrg(new Organization(orgId));
			} else if(nodeCode.equals("002")){ //投资经理
				task.setOrg(new Organization(orgId));
			} else if(nodeCode.equals("003")){ //投资总监
				
			} else if(nodeCode.equals("004")){ //副总经理  -> 副总裁
				
			} else if(nodeCode.equals("005")){ //总裁
				
			}
			taskLst.add(task);
		}
		wfTaskDao.save(taskLst);
	}
	
	*//**
     * getWfNodeApprover(获取流程节点的审批者)
     * @Description: 获取流程节点的审批者
     * @param wfType 流程类型
     * @param nodeId 节点ID
     * @param roleCode 角色代码
     * @return List<User> 审批者
     *//*
    public List<User> getWfNodeApprover(String wfType, Long nodeId, String roleCode){
		
		
		return null;
	}
	
	*//**
     * updateOrderApprove(更新订单审批任务)
     * @Description: 更新订单审批任务
     * @param task 审批任务实体类
     * @return Boolean
     *//*
    public Boolean updateOrderApprove(WFTask task){
		
		return true;
	}
	
	*//**
     * getEntity(获取任务实体)(              退回有问题：  todo )
     * @Description: 获取下一节点及审批者
     * @param order 当前流程节点顺序号
     * @param recordId 关联模块记录ID
     * @param moduleType 关联模块
     * @return WFTask 任务实体
     *//*
    public WFTask getEntity(Long order, Long recordId, String moduleType){
		*//************获取模块字典id**************************//*
        Long dicId = dicService.getIdByValue(moduleType);
		
		*//************获取下一流程节点************************//*
        WFNode nodeEntity = wfNodeService.getNextWFNode(order);
		
		*/

    /** *****获取任务****************************** *//*
        String hql = "select t from WFTask t " +
				"left join fetch t.wfNode " +
				"left join fetch t.approver " +
				"where t.status is null " +
				"and t.wfNode.Id = ? " +
				"and t.moduleType.id = ? " +
				"and t.moduleId = ?";
		
		return wfTaskDao.findUnique(hql, (null != nodeEntity ? nodeEntity.getId() : 0), dicId, recordId);
	}*/

    /** 查找预存储未执行的task */
    public List<WFTask> findFuture(String moduleName, Long id) {
        String hql = "select task from WFTask task" +
                " inner join fetch task.module" +
                " where task.module.name=?" +
                " and task.moduleId=?" +
                " and task.status is null";
        return wfTaskDao.find(hql, moduleName, id);
    }

    /** 查找已执行的task */
    public List<WFTask> findHistory(String moduleName, Long id) {
        String hql = "select task from WFTask task" +
                " inner join fetch task.module" +
                " inner join fetch task.status" +
                " where task.module.id=?" +
                " and task.moduleId=?" +
                " and task.status is not null";
        return wfTaskDao.find(hql, moduleName, id);
    }


    /**
     * 启动流程
     * 1.设置流程归属对象的环节为开始
     * 2.保存流程节点到审批记录中
     * 3.更新开始流程记录
     */
    @Transactional
    public void startFlow(FlowModel flowModel) {
        String hql = String.format("update %s entity set entity.status=? where id=?", flowModel.getModule().getEntityClass());
        WFNode startNode = wfNodeDao.findStartByFlowValue(flowModel.getFlowType());
        wfTaskDao.batchExecute(hql, startNode, flowModel.getId());

        List<WFNode> nodes = flowModel.getNodes();
        List<WFTask> tasks = new ArrayList<WFTask>(nodes.size());
        for (int i = 0; i < nodes.size(); i++) {
            WFTask task = new WFTask();
            if (i == 0) {
                task.setApprover(flowModel.getOperater());
                task.setApproveTime(flowModel.getOperateTime());
            }
            task.setWfNode(nodes.get(i));
            task.setModule(flowModel.getModule());
            task.setModuleId(flowModel.getId());
            task.setApprover(task.getWfNode().getApprover());
            task.setCreator(flowModel.getOperater());
            task.setCreatedTime(flowModel.getOperateTime());
            task.setModifier(flowModel.getOperater());
            task.setModifiedTime(flowModel.getOperateTime());
            tasks.add(task);
        }
        wfTaskDao.save(tasks);

//        WFTask task = tasks.get(0);
//        task.setApprover(flowModel.getOperater());
//        task.setApproveTime(flowModel.getOperateTime());
//        wfTaskDao.save(task);

    }


}
