
package com.baihui.hxtd.soa.common.controller.model;

import java.util.List;

import com.baihui.hxtd.soa.util.Result;
/**
 * 数据模型
 * 就是将list集合放到jsonDTO的result中
 * 注意extends 
 * @author Administrator
 *
 * @param <T>
 */
public class ListModel<T> extends Result{
		
	private List<T> list;

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}
	
	public ListModel(List<T> list){
		this.list=list;
	}
	
	public ListModel(){
	}
}
