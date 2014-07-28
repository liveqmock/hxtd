package com.baihui.hxtd.soa.common.service;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.base.ContextLoaderListenerAware;
import com.baihui.hxtd.soa.common.dao.CommonDao;
import com.baihui.hxtd.soa.common.service.imports.ImportServiceAbstract;
import com.baihui.hxtd.soa.system.entity.User;
/**
 * 功能描述：导入信息类
 * @see: 与该类相关的类，写出具体的路径：包括完整的包名和类名.java
 * @author xiaoli.luo
 * @company 北京市百会纵横科技有限公司
 * @copyright (版权)  本文件归属 北京市百会纵横科技有限公司 
 * @since (该版本支持的 JDK 版本) ： 1.5 
 * @ClassName: com.baihui.hxtd.soa.common.service.ImportService.java
 * @version (版本) 1
 * @date 2014-7-6 上午11:00:53
 *
 */


@Service
@Transactional
public class ImportService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private CommonDao commonDao;
	
	@SuppressWarnings("unchecked")
	ImportServiceAbstract importServiceAbstract;
	//导入数据到DB
	@SuppressWarnings("unchecked")
	public void import2DB(List entityList, List<String> typeList,String duplicateType, String moduleName,User user) throws IllegalArgumentException, SecurityException, InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		logger.info("开始导入excel数据");
		//获取实体类
		String serviceStr = "import"+moduleName.subSequence(0, 1).toString().toUpperCase()+moduleName.substring(1)+"Service";
		ImportServiceAbstract importServiceAbstract = (ImportServiceAbstract)ContextLoaderListenerAware.ctx.getBean(serviceStr);
		//importServiceAbstract = (ImportLeadService)ImportLeadService.class.getConstructor().newInstance();
		//importServiceAbstract = new ImportLeadService();
		importServiceAbstract.importData2DB(entityList, typeList, duplicateType, user);
	}
	
	
	public static void main(String[] args) {
		String moduleName = "lEad";
		String serviceStr = "Import"+moduleName.subSequence(0, 1).toString().toUpperCase()+moduleName.substring(1).toLowerCase()+"Service";
		System.out.println(serviceStr);
	}
	/**
     * 获取数据库时间
     * @return
     */
    public Date getDBNow(){
    	return commonDao.getDBNow();
    }
    
	
}
