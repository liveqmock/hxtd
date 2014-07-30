package com.baihui.hxtd.soa.common.imports.excel;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.baihui.hxtd.soa.base.utils.ImportExport;
import com.baihui.hxtd.soa.common.imports.ImportMessage;
import com.baihui.hxtd.soa.util.Tools;



public abstract class ExcelParse<T> {
	
	private Logger logger = LoggerFactory.getLogger(ExcelParse.class);
	 
	
	/**
	 * 读取excel文件
	 * @param fileItem
	 * @return
	 * @throws ParseException 
	 */
	public List<T> parse(MultipartFile fileItem, List<String> typeList) throws ParseException{
		if(fileItem == null){
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
		if(entityMap==null || entityMap.size()==0){
			return null;
		}
		//第三步:获取集合中的重复记录,保存到重复记录集合中
		getDuplicateDate(entityMap, typeList);
		
		//第四步:将重复记录从entityMap中删除掉,保留重复记录中的最后一条
		return removalDuplicateData(entityMap);
	}
	
	/**
	 * 解析excel,将excel中row行记录,解析为T对象,并保存到Map集合中.
	 * Map<Integer,T> key=行号,T=实体对象
	 * @param fileItem
	 * @param type
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 * @throws ParseException 
	 */
	public Map<Integer, T> readExcel(MultipartFile fileItem) throws FileNotFoundException, IOException, ParseException {
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
		Workbook wb = ImportExport.create(in);
		//记录sheet页中所有记录的行数,每一行有都是一个数据,里面记录了单元格的信息
		Map<Integer, T> resultMap = new HashMap<Integer, T>();
		//int wbLength = wb.getNumberOfSheets();
		//logger.info("一共有几个sheet页:["+wbLength+"]");
		//读取第一个sheet页
		for (int numSheets = 0; numSheets < 1; numSheets++) {
			Sheet sheet = wb.getSheetAt(numSheets);
			if ( sheet == null ){
				continue;
			}
			//获取sheet的行数,sheet页的row从0开始,sheet.getLastRowNum()=1时,表示已经有两条记录了
			int sheetRowNum = sheet.getLastRowNum();
			//记录导入记录数
			ImportMessage.totalCount = sheetRowNum;
			logger.info("第"+(numSheets+1)+"个sheet页中有"+sheetRowNum+"行记录");
			if (sheetRowNum < 1) {
				msg = "您上传的第"+(numSheets+1)+"个sheet页文件内容为空";
				logger.error(msg);
				continue;
			}
			//超过允许导入的最大行数10001,截取前10001条数据
			if(sheetRowNum>ImportMessage.LIMIT_COUNT){
				sheetRowNum = ImportMessage.LIMIT_COUNT;
				//上传大于10001条给出提示,取前10001条
				//msg = ImportMessage.limitMessage();
				//ImportMessage.message = msg;
			}
			//遍历sheet页中的记录,rowNumOfSheet = 1,从第二行开始读,不读取第一行,因为第一行是title.
			for (int rowNumOfSheet = 1; rowNumOfSheet <= sheetRowNum; rowNumOfSheet++) {
				//获取第rowNumOfSheet行数据
				Row row = sheet.getRow(rowNumOfSheet);//rowNumOfSheet=1就是excel中的第二条数据
				//遍历的sheet页中的某一条记录不为空
				if(row == null){
					continue;
				}
				//读取excel中所有sheet页中的数据,将其转换成List集合,这里rowNumOfSheet+1的原因是,读取excel的行号是从0开始的
				List<String> sheetList = HSSFRow2ListString(row, (rowNumOfSheet+1));
				//将List<String>对象转换成Map<Integer,Entity>集合
				T t = checkDataBySheetList((rowNumOfSheet+1), sheetList);
				//如果这条记录
				if(t == null){
					continue;
				}
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
	public List<String> HSSFRow2ListString(Row row,int rowNumOfSheet){
		logger.info("当前第["+rowNumOfSheet+"]行数据");
		// 获取总列数
		int cellNum = row.getLastCellNum();
		cellNum = cellNum <= getColumnNum() ? cellNum : getColumnNum();
		logger.info("sheet页中有["+cellNum+"]列数据");
		List<String> sheetList = new ArrayList<String>();
		 for (int cellNumOfRow = 0; cellNumOfRow < cellNum; cellNumOfRow++){
			 String strCell = "";
				//某一行中的某一列---->单元格
			 Cell aCell = row.getCell(cellNumOfRow);
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
		//记录在excel中的行号
		 sheetList.add((getColumnNum()), rowNumOfSheet + "");
		 return sheetList;
		 
	 }
	
	
	
	/**
	 * 添加重复数据到ImportMessage.workbookRepeats集合中
	 * 处理方式:1.如果集合为空则直接将这条数据添加到ImportMessage.workbookRepeats集合中
	 * 2.如果这条数据已经在重复记录集合中有记录了,那么直接添加到集合中
	 * 3.如果重复记录中没有这条数据,则吧这条数据添加到集合中
	 * @param key 主键(电话,邮箱)
	 * @param rowNum 行号
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
				//将该记录的行号添加到Set集合中
				rowNumSet = map.get(key);
				rowNumSet.add(rowNum);
				//删除原来的这条记录,然后在重新添加.为避免内存溢出.
				ImportMessage.workbookRepeats.remove(key);
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
	public List<T> removalDuplicateData(Map<Integer, T> entityMap){
		//获取集合entityMap的所有的values值,并保存到list集合中
		Set<Integer> keySets = entityMap.keySet();
		List<T> valueList = new ArrayList<T>();
		for(Integer integer:keySets){
			valueList.add(entityMap.get(integer));
		}
		//获取重复数据的Map集合
		Map<String,Set<Integer>> map = ImportMessage.workbookRepeats;
		//重复集合如果为null,或没有重复记录,则直接返回读取的excel的实体类集合
		if(map==null || map.isEmpty()){
			return valueList;
		}
		//获取主键集合--也就是唯一键集合
		Set<String> keySet = map.keySet();
		//重复集合如果为null,或没有重复记录,则直接返回读取的excel的实体类集合
		if(keySet==null || keySet.isEmpty()){
			return valueList;
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
				//entityMap.remove(deleteRowNumber);
				valueList.remove(entityMap.get(deleteRowNumber));
			}
		}
		//最后将entityMap的value取出,传回
		return valueList;
	}
	
	/**
	 * 手机号验证
	 * 
	 * @param  str
	 * @return 验证通过返回true
	 */
	public static boolean isMobile(String str) { 
		Pattern p = null;
		Matcher m = null;
		boolean b = false; 
		p = Pattern.compile("^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\\d{8})$"); // 验证手机号
		m = p.matcher(str);
		b = m.matches(); 
		return b;
	}
	
	/**
	 * 电话号码验证
	 * 格式:010-12345678
	 * @param  str
	 * @return 验证通过返回true
	 */
	public static boolean isPhone(String str) { 
		
		Pattern p = Pattern.compile("^\\d{3,4}-?\\d{7,9}$"); 
		Matcher m = p.matcher(str);
		return m.matches(); 
	}

	/**
	 * 电子邮件校验
	 */
	public static boolean checkEmail(String email) {

		String EMAIL_REGEX = "^((([a-z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+(\\.([a-z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(\\\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.?$";
		
		return email.matches(EMAIL_REGEX);
	}



	
	/**
	 * 邮编校验
	 */
	public static boolean checkPostCode(String postCode){
        
		return postCode.matches("^[0-9]{6}$"); 

	}
	
	public static void main(String[] args) {
		System.out.println(isMobile("11036409512"));
		System.out.println(isPhone("78965123"));
		System.out.println(checkEmail("362350061@qq.com"));
		System.out.println(checkPostCode("100000"));
	}

	
	
	/**
	 * 将List<String>转换成对象
	 * @param rowNumOfSheet
	 * @param sheetList
	 * @return
	 * @throws ParseException 
	 */
	public abstract T checkDataBySheetList(int rowNumOfSheet, List<String> sheetList) throws ParseException;
	
	/**
	 * 获取excel导入文件的列数
	 * @return
	 */
	public abstract int getColumnNum();
	
	/**
	 * 查找Excel中的重复数据,并把这些重复数据添加的重复记录集合中
	 * @param entityMap 要查找的实体类Map集合
	 * @param typeList 查找的方式(例如:按手机,邮箱等)
	 */
	public abstract void getDuplicateDate(Map<Integer, T> entityMap,List<String> typeList);
		
}
