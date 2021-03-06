package com.baihui.hxtd.soa.common.service.imports;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.common.dao.CommonDao;
import com.baihui.hxtd.soa.common.dao.ImportDao;
import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.system.entity.User;
@Service
public abstract class ImportServiceAbstract<T,E>  {
	
	@Resource
	protected ImportDao importDao;
	
	@Resource
	private CommonDao commonDao;

    /**
     * 导入到DB
     * @param entityList
     * @param typeList 主键类型
     * @param duplicateType 重复数据的合并方式(覆盖,忽略,合并)
     * @throws NoSuchMethodException 
     * @throws InvocationTargetException 
     * @throws IllegalAccessException 
     * @throws SecurityException 
     * @throws IllegalArgumentException 
     */
	@Transactional
    public void importData2DB(List<T> entityList, List<String> typeList,String duplicateType,User user) throws IllegalArgumentException, SecurityException, IllegalAccessException, InvocationTargetException, NoSuchMethodException{
    	//如果导入的内容为空,则返回null
    	if(entityList==null || entityList.size()==0){
    		return ;
    	}
    	//如果主键为空,则返回
    	if(typeList==null || typeList.size()==0){
    		return ;
    	}
    	// 新增的集合
    	List<E> insertList = new ArrayList<E>();
		// 修改的集合
		List<E> updateList = new ArrayList<E>();
		Iterator<T> ite = entityList.iterator();
		T t = null;
		// 1.循环遍历集合,获取每一条记录
		while (ite.hasNext()) {
			t = ite.next();
			if (t == null) {
				continue;
			}
			// 2.判断这条数据是新增还是修改
			Map<Integer, E> entityMap = isAddOrUpdate(t, typeList, duplicateType);
			Integer isFlag = entityMap.keySet().iterator().next();
			//isFlag=1新增
			if(isFlag == 1){
				insertList.add(convertT2E(t));
			}else{
				//isFlag=2修改
				updateList.add(entityMap.get(isFlag));
			}
		}
		//批量处理数据
		batchHandleData(insertList, updateList,user);
    	
	}
    
    /**
     * 批量处理数据,批量新增或批量修改
     * @param insertList
     * @param updateList
     * @return
     * @throws NoSuchMethodException 
     * @throws InvocationTargetException 
     * @throws IllegalAccessException 
     * @throws SecurityException 
     * @throws IllegalArgumentException 
     */
   @Transactional
   public void batchHandleData(List<E> insertList, List<E> updateList,User user) throws IllegalArgumentException, SecurityException, IllegalAccessException, InvocationTargetException, NoSuchMethodException{
	   //新增数据
	   if(insertList!=null && insertList.size()>0){
		   //为数据添加创建人,创建时间,修改人,修改时间
		   addCreateAndModifyInfo(insertList, user);
		   List<T> list = addOrModify(insertList);
		   if(list == null || list.size()==0){
			   Set<Integer> addRecord = ImportMessage.databaseRepeatRowNums;
			   //新增数据失败,要么全部失败,要么全部成功,list==null||list.size()==0,全部失败
			   ImportMessage.databaseRepeatRowNums.removeAll(addRecord);
		   }
		   System.out.println("新增："+list.size());
	   }
		// 修改数据
		if (updateList != null && updateList.size() > 0) {
			// 为数据添加创建人,创建时间,修改人,修改时间
			addCreateAndModifyInfo(updateList, user);
			List<T> list = addOrModify(updateList);
			if(list == null || list.size()==0){
				   List<Integer> addRecord = ImportMessage.databaseNewRowNums;
				   //修改数据失败,要么全部失败,要么全部成功,list==null||list.size()==0,全部失败
				   ImportMessage.databaseNewRowNums.removeAll(addRecord);
			   }
			System.out.println("修改："+list.size());
		}
   }
   
   /**
    * 为对象添加创建人,创建时间,修改人,修改时间
    * @return
    */
   public List<E> addCreateAndModifyInfo(List<E> list, User user) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException, SecurityException, NoSuchMethodException{
	   if(list==null || list.size()==0){
			return null;
		}
		for(E e:list){
			//添加创建时间
			Method getCreatorMethod = e.getClass().getMethod("getCreator");
			Method setCreatorMethod = e.getClass().getMethod("setCreator",User.class);
			User creator = (User)getCreatorMethod.invoke(e);
			if(creator == null){
				setCreatorMethod.invoke(e, user);
			}
			
			//添加创建人
			Method getCreatedTimeMethod = e.getClass().getMethod("getCreatedTime");
			Method setCreatedTimeMethod = e.getClass().getMethod("setCreatedTime",Date.class);
			Date createdTime = (Date) getCreatedTimeMethod.invoke(e);
			if(createdTime == null){
				setCreatedTimeMethod.invoke(e, getDBNow());
			}
			
			//添加修改时间
			Method setModifiedTimeMethod = e.getClass().getMethod("setModifiedTime",Date.class);
			setModifiedTimeMethod.invoke(e, getDBNow());
			
			//添加修改人
			Method setModifierMethod = e.getClass().getMethod("setModifier",User.class);
			setModifierMethod.invoke(e, user);
		}
		return list;
   }

   /**
    * 新增或修改数据
    * @param entities
    * @return
    */
	@SuppressWarnings("unchecked")
	@Transactional
	public List<T> addOrModify(List entities) {
		return (List<T>) importDao.saveOrUpdate(entities);
	}
    
    /**
     * 判断这条记录时新增还是修改
     * @param args
     */
    public abstract Map<Integer,E> isAddOrUpdate(T t,List<String> typeList, String duplicateType);
	
    /**
     * 合并数据:根据"重复类型"合并重复数据,返回实体类
     * @param e1 excel导入的数据
     * @param e2 数据库中查询出的重复数据
     * @param duplicateType 重复数据的处理方式
     * @return
     */
    public E mergeDataByDuplicateType(E e1,E e2,String duplicateType){
    	//设置默认重复数据处理方式:合并
    	if(duplicateType==null || "".equals(duplicateType.trim())){
    		duplicateType = "merge";
    	}
    	
    	
    	if ("cover".equals(duplicateType)) {//覆盖
    		setId(e1,e2);//将id添加到对象中
			return e1;
		} else if ("jump".equals(duplicateType)) {//跳过
			return e2;
		} else if ("merge".equals(duplicateType)) {// 合并的原则是,如果有都有,一新的为准
			setId(e1,e2);//将id添加到对象中
			return mergeData(e1, e2);
		}
		return mergeData(e1, e2);
    }
    
    /**
     * 修改数据时给对象赋id
	 * e1:来自excel的对象,所以没有id
	 * e2:来自DB的对象,有id
	 * 如果修改数据,需要把id带上
	 */
    public abstract E setId(E e1,E e2);
    
    /**
     * 获取数据库时间
     * @return
     */
    @Transactional(readOnly = true)
    public Date getDBNow(){
    	return commonDao.getDBNow();
    }
    
    public abstract E mergeData(E e1, E e2);

    /**
     * 实体对象转换
     * 将T类型的实体对象转换成E类型的实体对象
     * @param t
     * @return
     */
    public abstract E convertT2E(T t);
}
