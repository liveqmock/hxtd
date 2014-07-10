package com.baihui.hxtd.soa.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.fileupload.FileItem;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



public abstract class ExcelParse<T> {
	
	private Logger logger = LoggerFactory.getLogger(ExcelParse.class);
	 
	
	/**
	 * 读取excel文件
	 * @param fileItem
	 * @return
	 */
	public Collection<T> parse(FileItem fileItem, List<String> typeList){
		//第一步校验文件格式
		if(!checkFileItem(fileItem)){
			return null;
		}
		//第二步:解析excel,将excel中的row解析为Entity对象,保存到Map集合中,其中key是行号
		Map<Integer, T> entityMap = null;
		 try {
			entityMap = readExcel(fileItem);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//第三步:获取集合中的重复记录,保存到重复记录集合中
		getDuplicateDate(entityMap, typeList);
		
		//第四步:将重复记录从entityMap中删除掉,保留重复记录中的最后一条
		return removalDuplicateData(entityMap);
	}
	
	/**
	 * 校验excel文件是否符合规则
	 * @param fileItem
	 * @return
	 */
	public boolean checkFileItem(FileItem fileItem){
		String msg = null;
		if ( fileItem == null ){
			msg = "文件内容为空!";
			logger.error("上传文件失败",msg);
			ImportMessage.message = msg;
			return false;
		}
		/*
		 * fileItem.isFormField():判断fileItem是否是普通的表单类型.
		 * 返回true:是普通 表单输入域
		 * 返回false:文件上传域
		 */
		if ( fileItem.isFormField() ){
			return false;
		}
		//文件名
		String fileName = fileItem.getName();
		
		//校验文件名
		if(fileName == null || "".equals(fileName.trim()) ){
			msg = "文件名为空!";
			logger.error("上传文件失败",msg);
			ImportMessage.message = msg;
			return false;
		}
		// 获取文件类型
		String fileType = fileName.substring(fileName.lastIndexOf("."));
		
		//允许上传的文件类型
		String excelExtension = PropertyManager.getProperty("FILENAME_EXTENSION");
		String [] excelExtensionArr = excelExtension.split(",");
		
		//允许上传文件的最大容量
		long fileMaxSize = Long.valueOf(PropertyManager.getProperty("FILE_MAX_SIZE"));
		
		if(fileItem.getSize() >  fileMaxSize){
			msg="文件大小不能超过"+(fileMaxSize/1024/1024)+"MB";
			logger.error("上传文件失败",msg);
			ImportMessage.message = msg;
			return false;
		}
		
		//判断文件类型是否为可上传的文件类型
		boolean fileNameIsAllow = false;
		for(String fileExtension : excelExtensionArr){
			if( fileExtension.equals(fileType) ){
				fileNameIsAllow = true;
				break;
			}
		}
		if (!fileNameIsAllow) {
			msg="该文件类型不允许上传,只能上传"+excelExtension+"的格式文件";
			logger.error("上传文件失败",msg);
			ImportMessage.message = msg;
			return false;
		}
		//读取文件流
		InputStream fStream = null;
		try {
			fStream = fileItem.getInputStream();
		} catch (IOException e) {
			logger.error("fileItem.getInputStream() error", e);
			ImportMessage.message= "文件流读取异常";
			return false;
		}
		
		//判断文件是否为空
		if (fStream == null) {
			msg = "导入文件不能为空";
			logger.error("上传文件失败",msg);
			ImportMessage.message = msg;
			return false;
		}
		return true;
	}
	
	/**
	 * 解析excel,将excel中row行记录,解析为T对象,并保存到Map集合中.
	 * Map<Integer,T> key=行号,T=实体对象
	 * @param fileItem
	 * @param type
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public Map<Integer, T> readExcel(FileItem fileItem) throws FileNotFoundException, IOException {
		logger.info("开始解析excel文件");
		String msg = null;
		if(fileItem == null){
			msg = "文件内容为空!";
			ImportMessage.message = msg;
			return null;
		}
		//读取文件流
		InputStream in = fileItem.getInputStream();
		//读取Excel文件 到 HSSFWorkbook中
		HSSFWorkbook wb = new HSSFWorkbook(in);
		//记录sheet页中所有记录的行数,每一行有都是一个数据,里面记录了单元格的信息
		Map<Integer, T> resultMap = new HashMap<Integer, T>();
		int wbLength = wb.getNumberOfSheets();
		logger.info("一共有几个sheet页:["+wbLength+"]");
		//读取sheet页
		for (int numSheets = 0; numSheets < wbLength; numSheets++) {
			HSSFSheet sheet = wb.getSheetAt(numSheets);
			if ( sheet == null ){
				continue;
			}
			//获取sheet的行数,sheet页的row从0开始,sheet.getLastRowNum()=1时,表示已经有两条记录了
			int sheetRowNum = sheet.getLastRowNum();
			logger.info("sheet页中有"+sheetRowNum+"行记录");
			if (sheetRowNum < 1) {
				msg = "您上传的第"+numSheets+"个sheet页文件内容为空";
				logger.error(msg);
				ImportMessage.message = msg;
				continue;
			}
			//超过允许导入的最大行数,截取前10001条数据
			if(sheetRowNum>ImportMessage.LIMIT_COUNT){
				sheetRowNum = ImportMessage.LIMIT_COUNT;
				msg = ImportMessage.limitMessage(sheetRowNum);
			}
			ImportMessage.message = msg;
			//遍历sheet页中的记录,rowNumOfSheet = 1,从第二行开始读,不读取第一行,因为第一行是title.
			for (int rowNumOfSheet = 1; rowNumOfSheet <= sheetRowNum; rowNumOfSheet++) {
				//遍历的sheet页中的某一条记录不为空
				HSSFRow row = sheet.getRow(rowNumOfSheet);//rowNumOfSheet=1就是excel中的第二条数据
				if(row == null){
					continue;
				}
				//读取excel中所有sheet页中的数据,将其转换成List集合,这里rowNumOfSheet+1的原因是,读取excel的行号是从0开始的
				List<String> sheetList = HSSFRow2ListString(row, (rowNumOfSheet+1));
				//将List<String>对象转换成Map<Integer,Entity>集合
				T t = checkDataBySheetList((rowNumOfSheet+1), sheetList);
				if(t != null){
					//resultList.add(t);
					resultMap.put((rowNumOfSheet+1), t);
				}
			}
		}
		return resultMap;
	}
	
	/**
	 * 将excel中的数据行转换成List<String>的形式
	 * @param aRow
	 * @param rowNumOfSheet
	 * @return
	 */
	public List<String> HSSFRow2ListString(HSSFRow row,int rowNumOfSheet){
		// 获取总列数
		int cellNum = row.getLastCellNum();
		cellNum = cellNum <= getColumnNum() ? cellNum : getColumnNum();
		logger.info("sheet页中有["+cellNum+"]列数据");
		List<String> sheetList = new ArrayList<String>();
		 for (int cellNumOfRow = 0; cellNumOfRow < cellNum; cellNumOfRow++){
			 String strCell = "";
				//某一行中的某一列---->单元格
			 HSSFCell aCell = row.getCell(cellNumOfRow);
			if (aCell == null) {
				sheetList.add(strCell);
				continue;
			}
			// 获取单元格
			// 获取这一列所对应的数据类型
			int cellType = aCell.getCellType();
			// 返回字符串的表示形式
			switch (cellType) {
			case HSSFCell.CELL_TYPE_NUMERIC:
				if (HSSFDateUtil.isCellDateFormatted(aCell)) {
					strCell = Tools.datetimeToStr(aCell.getDateCellValue());
				} else {
					BigDecimal bd = new BigDecimal(aCell.getNumericCellValue());
					strCell = bd.toPlainString();
				}
				break;
			case HSSFCell.CELL_TYPE_STRING:
				strCell = aCell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				strCell = aCell.getBooleanCellValue() + "";
				break;
			case HSSFCell.CELL_TYPE_FORMULA:
				strCell = aCell.getCellFormula() + "";
				break;
			case HSSFCell.CELL_TYPE_BLANK:
			case HSSFCell.CELL_TYPE_ERROR:
			default:
				break;
			}
			sheetList.add(Tools.trim(strCell));
		 }
		 while ( sheetList.size() < getColumnNum() ) {
			sheetList.add(null);
		 }
		//记录在excel中的行号(当期那行号+1,因为是从第0行开始读取的)
		 sheetList.add((getColumnNum()+1), rowNumOfSheet + "");
		 return sheetList;
		 
	 }
	
	
	
	/**
	 * 添加重复数据到ImportMessage.workbookRepeats集合中
	 * 处理方式:1.如果集合为空则直接将这条数据添加到ImportMessage.workbookRepeats集合中
	 * 2.如果这条数据已经在重复记录集合中有记录了,那么直接添加到集合中
	 * 3.如果重复记录中没有这条数据,则吧这条数据添加到集合中
	 * @param key
	 * @param rowNum
	 */
	public void AddDuplicateData(String key,Integer rowNum){
		//重复数据的行号集合
		Set<Integer> rowNumSet = null;
		//获取重复数据的Map集合
		Map<String,Set<Integer>> map = ImportMessage.workbookRepeats;
		//如果map为空,则直接将记录添加到集合中,并返回
		if(map == null || map.isEmpty()){
			rowNumSet = new TreeSet<Integer>();
			rowNumSet.add(rowNum);
			ImportMessage.workbookRepeats.put(key, rowNumSet);
			return;
			
		}
		//获取主键集合
		Set<String> set = map.keySet();
		//标记是否找到主键相同的集合
		boolean flag = false;
		
		/**
		 * 判断当前的主键key在集合map中是否存在
		 * 如果存在,在直接将行号添加到set集合中
		 * 如果不存在则添加一条新的记录
		 */
		for(String str:set){
			//表示主键key已经在集合中存在了
			if(str.equals(key)){
				System.out.println(key);
				//将该记录的行号添加到Set集合中
				rowNumSet = map.get(key);
				rowNumSet.add(rowNum);
				//保存重复记录到ImportMessage.workbookRepeats
				ImportMessage.workbookRepeats.put(key, rowNumSet);
				flag = true;
				break;
			}
		}
		
		//如果flag=false,表示没有在重复记录集合中找到这条记录,那么在这个集合中新增一条
		if(!flag){
			rowNumSet = new  TreeSet<Integer>();
			rowNumSet.add(rowNum);
			ImportMessage.workbookRepeats.put(key, rowNumSet);
		}
		
		
	}
	
	/**
	 * 删除重复数据,保留重复数据中的最后一条
	 * @param entityMap
	 * @param params
	 */
	public Collection<T> removalDuplicateData(Map<Integer, T> entityMap){
		//获取重复数据的Map集合
		Map<String,Set<Integer>> map = ImportMessage.workbookRepeats;
		//重复集合如果为null,或没有重复记录,则直接返回读取的excel的实体类集合
		if(map==null || map.isEmpty()){
			return (Collection<T>)entityMap.values();
		}
		//获取主键集合--也就是唯一键集合
		Set<String> keySet = map.keySet();
		//重复集合如果为null,或没有重复记录,则直接返回读取的excel的实体类集合
		if(keySet==null || keySet.isEmpty()){
			return (Collection<T>)entityMap.values();
		}
		//记录excel行号的重复记录的Set集合
		Set<Integer> rowNumSet = null;
		for(String key:keySet){
			rowNumSet = map.get(key);
			//如果集合为空,则退出本次循环,执行下一次循环
			if(rowNumSet==null||rowNumSet.size()==0){
				continue;
			}
			/*
			 * 将set集合转换成list集合
			 * 这里这样转换的原因:因为map中的Set集合是TreeSet类型,对set中的元素进行了排序
			 * 转换成list集合后,
			 */
			List<Integer> rowNumList = new ArrayList<Integer>();
			rowNumList.addAll(rowNumSet);
			for(int i=0; i<(rowNumList.size()-1); i++){
				//有重复记录的行号
				Integer deleteRowNumber = rowNumList.get(i);
				//根据行号删除Map集合中key=deleteRowNumber的数据
				entityMap.remove(deleteRowNumber);
			}
		}
		//最后将entityMap的value取出,传回
		return (Collection<T>)entityMap.values();
	}
	
	/**
	 * 将List<String>转换成对象
	 * @param rowNumOfSheet
	 * @param sheetList
	 * @return
	 */
	public abstract T checkDataBySheetList(int rowNumOfSheet, List<String> sheetList);
	
	/**
	 * 获取excel导入文件的列数
	 * @return
	 */
	public abstract int getColumnNum();
	
	/**
	 * 查找Excel中的重复数据,并把这些重复数据添加的重复记录集合中
	 * @param entityMap 要查找的实体类Map集合
	 * @param params 查找的方式(例如:按手机,邮箱等)
	 */
	public abstract void getDuplicateDate(Map<Integer, T> entityMap,List<String> typeList);
		
}
