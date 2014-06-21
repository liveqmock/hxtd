package com.baihui.hxtd.soa.util;


/**
 * 业务数据处理结果
 * @param <T>
 */
public class BusinessResult<T> extends Result {

	public BusinessResult() {
		
	}

	public BusinessResult(T t) {
		this.result = t;
	}

	/** 业务数据 */
	private T result;

	/**
	 * @return the result
	 */
	public T getResult() {
		return result;
	}

	/**
	 * @param businessBean the businessBean to set
	 */
	public void setResult(T result) {
		this.result = result;
	}
}
