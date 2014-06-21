
package com.baihui.hxtd.soa.common.controller.model;

import java.util.List;

import com.baihui.hxtd.soa.util.Result;

public class ListModel<T> extends Result{
		
	private List<T> list;

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}
	
	
	
}
