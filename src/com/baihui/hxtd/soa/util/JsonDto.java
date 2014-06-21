package com.baihui.hxtd.soa.util;

import com.baihui.hxtd.soa.base.utils.mapper.HibernateAwareObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;


/**
 * JSON数据对象
 *
 */
public class JsonDto {

	/** 消息 */
	private String message;

	/** 操作结果标识 */
	private boolean successFlag = true;

	/** 数据处理结果 */
	private Result result;
	
	/** session是否超时标识  */
	private boolean sessionIsTimeOut = false;
	
	/** 列表查询没有结果的JsonDto */
	public static final JsonDto NO_RESULT = new JsonDto("没有符合当前检索条件的结果.");
	
	public JsonDto(){
		
	}
	
	/**
	 * JsonDto构造函数
	 * @param message (successFlag为false的时候才去设置message)
	 */
	public JsonDto(String message) {
		this.successFlag = false;
		this.message = message;
	}

	/**
	 * 判断是否过滤html特殊字符
	 * 
	 * @param filterFlag
	 * @return
	 */
	public String toString(boolean filterFlag){
		if (filterFlag) {
			return filterHtmlChar(convert());
		} else {
			return convert();
		}
	}

	/**
	 * 不过滤html特殊字符直接转换为JSON字符
	 */
	public String toString(){
		return convert();
	}

	/**
	 * 转换JSON对象
	 * @return
	 */
	private String convert() {
		String result = null;
		try {
			HibernateAwareObjectMapper mapper = new HibernateAwareObjectMapper();
			//ObjectMapper mapper = new ObjectMapper();
		      mapper.disable(SerializationFeature.FAIL_ON_EMPTY_BEANS) ;
		      result = mapper.writeValueAsString(this);
		} catch (Exception e) {
			this.setSuccessFlag(false);
			this.setMessage("json 转换失败.");
			this.setResult(null);
			result = this.convert();
		}
		return result;
	}

	/**
	 * JSON字符串特殊字符处理   
	 * @Methods Name string2Json
	 * @Create In 2012-5-31 By jingliangma
	 * @param s
	 * @return String
	 */
	private String filterHtmlChar(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			switch (c) {
			case '\'':
				sb.append("\\\'");
				break;
			case '/':
				sb.append("\\/");
				break;
			case '\b':
				sb.append("\\b");
				break;
			case '\f':
				sb.append("\\f");
				break;
			case '\n':
				sb.append("\\n");
				break;
			case '\r':
				sb.append("\\r");
				break;
			case '\t':
				sb.append("\\t");
				break;
			default:
				sb.append(c);
			}
		}
		return sb.toString();
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message
	 *            the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return the successFlag
	 */
	public boolean isSuccessFlag() {
		return successFlag;
	}

	/**
	 * @param successFlag
	 *            the successFlag to set
	 */
	public void setSuccessFlag(boolean successFlag) {
		this.successFlag = successFlag;
	}

	/**
	 * @return the result
	 */
	public Result getResult() {
		return result;
	}

	/**
	 * @param result
	 *            the result to set
	 */
	public void setResult(Result result) {
		this.result = result;
	}

	/**
	 * @param sessionIsTimeOut the sessionIsTimeOut to set
	 */
	public void setSessionIsTimeOut(boolean sessionIsTimeOut) {
		this.sessionIsTimeOut = sessionIsTimeOut;
	}

	/**
	 * @return the sessionIsTimeOut
	 */
	public boolean isSessionIsTimeOut() {
		return sessionIsTimeOut;
	}
}
