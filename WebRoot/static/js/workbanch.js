window.workbanch = window.workbanch || {};
workbanch.modules = {
	lead : {
		titles : [ '线索', '公司', '电话', '手机', '传真' ],
		fields : [ 'name', 'company', 'phone', 'mobile', 'fax' ]
	},
	customer : {
		titles : [ '客户', '公司', '电话', '手机', '传真' ],
		fields : [ 'name', 'company', 'phone', 'mobile', 'fax' ]
	},
	contact : {
		titles : [ '联系人', '公司', '电话', '手机', '传真' ],
		fields : [ 'name', 'company', 'phone', 'mobile', 'fax' ]
	},
	supplier : {
		titles : [ '供应商', '法人', '电话', '手机', '传真' ],
		fields : [ 'name', 'corporation', 'phone', 'mobile', 'fax' ]
	}
};
workbanch.getModule = function(module) {
	return workbanch.modules[module];
};
workbanch.initList = function() {
	$(".gbin1-list li[type=list]").each(function() {
		workbanch.loadData(this);
	});
};
workbanch.loadData = function(ele) {
	var $this;
	if (ele) {
		$this = $(ele);
	} else {
		$this = $(this);
	}
	var url = $this.attr("uri");
	var module = $this.attr("module");
	var $div = $this.find('>div:last');
	$div.html("");
	if (url) {
		RcmsAjax.ajaxNoMsg(url, function(result) {
			$div.append(workbanch.result2Html(result, module));
		},null,null);
	}
};
workbanch.result2Html = function(result, module) {
	var module = workbanch.getModule(module);
	var title = module.titles;
	var fields = module.fields;
	var table = new Array();
	table.push("<table cellspacing='1' style='width:100%; line-height:25px;border-collapse: collapse;border-spacing: 0;'>");
	table.push("<tr>");
	for ( var i = 0; i < title.length; i++) {
		table.push("<th>", title[i], "</th>");
	}
	table.push("</tr>");
	var list = result.result.result;
	if(!list||list.length==0){
		table.push('<tr><td colspan="'+title.length+'" align="center"><div class="allnone m10"></div></td></tr>');
	}else{
		for ( var i = 0; i < list.length; i++) {
			table.push("<tr");
			if (i % 2 == 0) {
				table.push(" class='bg_c_blue'");
			}
			table.push(">");
			for ( var j = 0; j < fields.length; j++) {
				var value = list[i][fields[j]];
				table.push("<td>");
				table.push(value);
				table.push("</td>");
			}
			table.push("</tr>");
		}
	}
	table.push("</table>");
	
	return table.join("");
};
workbanch.modifyOrder = function() {
	var ids = new Array();
	$(".gbin1-list li").each(function() {
		ids.push("ids=", $(this).attr("id"), "&");
	});
	if (ids.length > 1) {
		ids.pop();
	}
	RcmsAjax.ajaxNoMsg(jsUtil.getRootPath() + "/workbanch/modifyOrder.do?"
			+ ids.join(""));
};
workbanch.bindDelete = function() {
	$(".delete").click(
			function() {
				var $this = $(this).parent().parent().parent().parent();
				var id = $this.attr("id");
				jsUtil.confirm("是否删除工作台组件", function() {
					RcmsAjax.ajaxNoMsg(jsUtil.getRootPath()
							+ "/workbanch/delete.do?ids=" + id, function() {
						$this.remove();
					});
				}, "警告");
			});
};
workbanch.bindRefresh = function() {
	$(".refresh").click(function() {
		var eleLi = $(this).parent().parent().parent().parent();
		workbanch.loadData(eleLi);
	});
};
workbanch.bindClose = function() {
	var $this = $(this);
	$this.parent().parent().parent().parent().find('>div:last')
			.stop(true, true).slideUp('normal');
	$this.removeClass("g_small").addClass("go_add");
	$this.click(workbanch.bindOpen);
};
workbanch.bindOpen = function() {
	var $this = $(this);
	$this.parent().parent().parent().parent().find('>div:last')
			.stop(true, true).slideDown('normal');
	$this.removeClass("go_add").addClass("g_small");
	$this.click(workbanch.bindClose);
};
workbanch.bindFunction = function() {
	workbanch.bindDelete();
	workbanch.bindRefresh();
	$(".close").click(workbanch.bindClose);
};
$(function() {
	workbanch.bindFunction();
});