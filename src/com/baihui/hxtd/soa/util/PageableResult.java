package com.baihui.hxtd.soa.util;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;


/**
 * 可翻页数据处理结果
 * @author hpwang
 *
 * @param <T>
 */
public class PageableResult<T> extends Result {

	/** 翻页信息 */
	private HibernatePage<T> pageBean;

	public HibernatePage<T> getPageBean() {
		return pageBean;
	}

	public void setPageBean(HibernatePage<T> pageBean) {
		this.pageBean = pageBean;
	}

}
