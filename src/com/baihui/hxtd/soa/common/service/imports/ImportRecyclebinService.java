package com.baihui.hxtd.soa.common.service.imports;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baihui.hxtd.soa.base.DBDateServiceInjecter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.system.entity.RecycleBin;
import com.baihui.hxtd.soa.system.entity.RecyclebinDTO;
import com.baihui.hxtd.soa.util.Tools;
@Service
@Transactional
public class ImportRecyclebinService extends ImportServiceAbstract<RecyclebinDTO,RecycleBin> {

	
	
	/**
	 * 根据"实体类,主键列表"判断是否在数据库中有重复数据,在根据"重复类型"处理重复数据
	 * Map<Integer,Lead>
	 * 其中Integer有两个值1:新增,2:修改
	 */
	@Override
	public Map<Integer, RecycleBin> isAddOrUpdate(RecyclebinDTO RecyclebinDTO, List<String> uniqueString, String duplicateType) {
		String hqlParam = "";
		String value = "";
		/*
		 * 返回的集合.key是1或者2
		 * 1:新增
		 * 2:修改
		 */
		Map<Integer, RecycleBin> entityMap = new HashMap<Integer, RecycleBin>();
//		value = value.substring(0,value.lastIndexOf(","));
//		String[] values = value.split(","); 
		//将RecyclebinDTO对象转换成RecycleBin类型的对象
		RecycleBin recycleBinFromExcel = convertT2E(RecyclebinDTO);
		
		//根据一个或多个主键查询数据库
		RecycleBin recycleBinFromDB = null;
		
		if (recycleBinFromDB != null) {
			//如果leadByDB不为空,则查询到重复数据,应该修改,根据记录合并方式进行修改
			entityMap.put(2, super.mergeDataByDuplicateType(recycleBinFromExcel, recycleBinFromDB, duplicateType));
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseRepeatRowNums
			ImportMessage.databaseRepeatRowNums.add(RecyclebinDTO.getExcelRowNum());
		}else{
		    //如果leadByDB为空,则说明该记录应该是新增
			entityMap.put(1, recycleBinFromExcel);
			//添加消息提示,保存这条记录的行号到ImportMessage中databaseNewRowNums
			ImportMessage.databaseNewRowNums.add(RecyclebinDTO.getExcelRowNum());
		}
		return entityMap;
	}
	
	/**
	 * 将RecyclebinDTO对象转换成RecycleBin类型的对象
	 * convertRecyclebinDTOTlRecycleBin
	 */
	public RecycleBin convertT2E(RecyclebinDTO recyclebinDTO) {
		RecycleBin recycleBin = new RecycleBin();
		
		recycleBin.setModuleName(recyclebinDTO.getModuleName());

		recycleBin.setRecordName(recyclebinDTO.getRecordName());

		recycleBin.setCreator(recyclebinDTO.getCreator());
		
		recycleBin.setRecordId(recyclebinDTO.getRecordId());
		
		recycleBin.setCreatedTime(DBDateServiceInjecter.nowTime());
		
		recycleBin.setRemark(recyclebinDTO.getRemark());
		return recycleBin;

	}
	
	/**
	 *  将两个对象数据合并,将其有值得属性合并,如果都有,RecycleBin中的属性覆盖RecycleBinByDB中的属性
	 * @param RecycleBin
	 * @param RecycleBinByDB
	 * @return
	 */
	public RecycleBin mergeData(RecycleBin recycleBin, RecycleBin recycleBinByDB){
		recycleBin.setId(recycleBinByDB.getId());
		
		// 备注
		if(Tools.isEmpty(recycleBin.getRemark())){
			recycleBin.setRemark(recycleBinByDB.getRemark());
		}
		return recycleBin;
	}

	

	/**
	 * RecycleBin1:来自excel,所以没有id
	 * RecycleBin2:来自DB,有id
	 * 如果修改数据,需要把id带上
	 */
	@Override
	public RecycleBin setId(RecycleBin recycleBin1,RecycleBin recycleBin2) {
		recycleBin1.setId(recycleBin2.getId());
		return recycleBin1;
	}



	
}
