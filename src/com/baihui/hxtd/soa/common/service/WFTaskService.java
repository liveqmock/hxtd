
package com.baihui.hxtd.soa.common.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.common.dao.WFTaskDao;
import com.baihui.hxtd.soa.common.entity.WFNode;
import com.baihui.hxtd.soa.common.entity.WFTask;
import com.baihui.hxtd.soa.system.entity.Organization;
import com.baihui.hxtd.soa.system.entity.User;
import com.baihui.hxtd.soa.system.service.DictionaryService;
/**
 * 
 * 功能描述：联系纪要service层
 * @author lihua 
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.service.WFTaskService.java
 * @version (版本)1 
 * @date 2014-5-26 上午11:16:20
 */
@Service
@Transactional
public class WFTaskService {
	
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
		List<WFNode> nodeLst = wfNodeService.findByModuleId(wfType);
		
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
		
		*//***********获取任务*******************************//*
		String hql = "select t from WFTask t " +
				"left join fetch t.wfNode " +
				"left join fetch t.approver " +
				"where t.status is null " +
				"and t.wfNode.Id = ? " +
				"and t.moduleType.id = ? " +
				"and t.moduleId = ?";
		
		return wfTaskDao.findUnique(hql, (null != nodeEntity ? nodeEntity.getId() : 0), dicId, recordId);
	}*/
}
