var HXTD_CRM_WB = {};
HXTD_CRM_WB.workbanch = {};
HXTD_CRM_WB.workbanch.modules = {
	lead : {
		titles : [ '线索', '公司', '电话', '手机', '传真' ],
		fields : [ 'name', 'company', 'phone', 'mobile', 'fax' ]
	},
	customer : {
		titles : [ '客户', '公司', '电话', '手机', '公司' ],
		fields : [ 'name', 'company', 'phone', 'mobile', 'company' ]
	},
	contact : {
		titles : [ '联系人', '公司', '电话', '手机', '传真' ],
		fields : [ 'name', 'company', 'phone', 'mobile', 'fax' ]
	},
	supplier : {
		titles : [ '供应商', '法人', '电话', '手机', '传真' ],
		fields : [ 'name', 'corporation', 'phone', 'mobile', 'fax' ]
	},
	notice : {
		titles : [ '公告名称', '内容', '发布时间', '过期时间' ],
		fields : [ 'title', 'content', 'sentTime', 'deadTime' ]
	},
	message : {
		titles : [ '标题', '内容', '接收时间' ],
		fields : [ 'title', 'content', 'createdTime' ]
	},
	order : {
		titles : [ '编号' ,'金额', '创建时间', '修改时间' ],
		fields : [ 'code', 'purchaseMoney' , 'createdTime', 'modifiedTime']
	}
};
HXTD_CRM_WB.workbanch.getModule = function(module) {
	return HXTD_CRM_WB.workbanch.modules[module];
};
HXTD_CRM_WB.workbanch.initList = function() {
	$(".gbin1-list li[type=list]").each(function() {
		HXTD_CRM_WB.workbanch.loadData(this);
	});
};

HXTD_CRM_WB.workbanch.loadData = function(ele) {
	var $this;
	if (ele) {
		$this = $(ele);
	} else {
		$this = $(this);
	}
	var url = $this.attr("uri");
	var moduleName = $this.attr("module");
	var $div = $this.find('>div:last');
	$div.html("");
	if (url) {
		RcmsAjax.ajaxNoMsg(url, function(result) {
			$div.html((HXTD_CRM_WB.workbanch.result2Html(result, moduleName)));
		},null, null);
	}
};

HXTD_CRM_WB.workbanch.result2Html = function(result, moduleName) {
	var module = HXTD_CRM_WB.workbanch.getModule(moduleName);
	var title = module.titles;
	var fields = module.fields;
	var table = new Array();
	table.push("<table cellspacing='1' style='width:100%; line-height:25px;border-collapse: collapse;border-spacing: 0;'>");
	var list = result.result.result;
	if(!list||list.length==0){
		table.push('<tr><td colspan="'+title.length+'" align="center"><div class="allnone mt10"></div></td></tr>');
	}else{
		table.push("<tr>");
		for ( var i = 0; i < title.length; i++) {
			table.push("<th>", title[i], "</th>");
		}
		table.push("</tr>");
		var showObj;
		if(moduleName == "message"){
			console.warn("list.length:"+list.length);
			for ( var i = 0; i < list.length; i++) {
				showObj = list[i].message;
				table.push("<tr  class='cp ");
				if (i % 2 == 0) {
					table.push(" bg_c_blue");
				}
				table.push("' onclick='workbanch.href(this,",list[i].id,")'>");
				for ( var j = 0; j < fields.length; j++) {
					table.push("<td>");
					table.push(showObj[fields[j]]);
					table.push("</td>");
				}
				table.push("</tr>");
			}
		} else {
			for ( var i = 0; i < list.length; i++) {
				showObj = list[i];
				table.push("<tr  class='cp ");
				if (i % 2 == 0) {
					table.push(" bg_c_blue");
				}
				table.push("' onclick='workbanch.href(this,",list[i].id,")'>");
				for ( var j = 0; j < fields.length; j++) {
					table.push("<td>");
					table.push(showObj[fields[j]]);
					table.push("</td>");
				}
				table.push("</tr>");
			}
		}
	}
	table.push("</table>");
	
	return table.join("");
};

HXTD_CRM_WB.workbanch.getParams=function(ele){
	var $this;
	if (ele) {
		$this = $(ele);
	} else {
		$this = $(this);
	}
	var flag = $this.attr("timeParam");
	var time;
	if(flag){
		time = {};
		var date = new Date();
		switch(flag){
			case "today":
				var today = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
				time.search_GTE_createdTime=today;
				time.search_LTE_createdTime=today;
				break;
			case "week":
				var year = date.getFullYear();
				var month = date.getMonth()+1;
				var currDay = date.getDate();
				var day = date.getDay();
				time.search_GTE_createdTime=year+"-"+month+"-"+(currDay+1-day);
				time.search_LTE_createdTime=year+"-"+month+"-"+(currDay+7-day);;
				break;
			case "month":
				var year = date.getFullYear();
				var month = date.getMonth()+1;
				var lastDay = HXTD_CRM_WB.workbanch.getLastDay(year,month);
				time.search_GTE_createdTime=year+"-"+month+"-1";
				time.search_LTE_createdTime=year+"-"+month+"-"+lastDay;
				break;
		}
	}
	var pa = $this.attr("params");
	var param = eval("("+pa+")");
	return $.param(time)+"&"+$.param(param);
};


HXTD_CRM_WB.workbanch.reportLoad=function (ele){
	var $this;
	if (ele) {
		$this = $(ele);
	} else {
		$this = $(this);
	}
	var div = $this.find('>div:last div');
    var url = $this.attr("uri")
    swfobject.embedSWF(jsUtil.getRootPath()+"/static/component/open-flash-chart-2/open-flash-chart.swf", 
    	div.attr("id"), "100%", "100%", "9.0.0","expressInstall.swf",  
  			{"data-file":url,"loading":"正在加载数据,请稍候..."});
};
HXTD_CRM_WB.workbanch.initReport=function(){
	$(".gbin1-list li[type=report]").each(function() {
		HXTD_CRM_WB.workbanch.reportLoad(this);
	});
};
HXTD_CRM_WB.workbanch.modifyOrder = function() {
	var ids = new Array();
	$(".gbin1-list li").each(function() {
		var id= $(this).attr("id");
		if(id!="add"){
			ids.push("ids="+ $(this).attr("id"));
		}
	});
	RcmsAjax.ajaxNoMsg(jsUtil.getRootPath() + "/workbanch/modifyOrder.do?"
			+ ids.join("&"));
};
HXTD_CRM_WB.workbanch.bindDelete = function() {
	$(".delete").click(function() {
		var $this = $(this).parent().parent().parent().parent();
		var id = $this.attr("id");
		jsUtil.confirm("是否删除工作台组件", function() {
			RcmsAjax.ajaxNoMsg(jsUtil.getRootPath()
					+ "/workbanch/delete.do?id=" + id, function() {
				$this.remove();
			});
		}, "警告");
	});
};
HXTD_CRM_WB.workbanch.bindRefresh = function() {
	$(".refresh").click(function() {
		var eleLi = $(this).parent().parent().parent().parent();
		var type = eleLi.attr('type');
		if(type=='list'){
			HXTD_CRM_WB.workbanch.loadData(eleLi);
		}else{
			HXTD_CRM_WB.workbanch.reportLoad(eleLi);
		}
	});
};
HXTD_CRM_WB.workbanch.bindClose = function() {
	var $this = $(this);
	$this.parent().parent().parent().parent().find('>div:last').hide();
	$this.removeClass("g_small").addClass("go_add");
	$this.click(HXTD_CRM_WB.workbanch.bindOpen);
};
HXTD_CRM_WB.workbanch.bindOpen = function() {
	var $this = $(this);
	$this.parent().parent().parent().parent().find('>div:last').show();
	$this.removeClass("go_add").addClass("g_small");
	$this.click(HXTD_CRM_WB.workbanch.bindClose);
};
HXTD_CRM_WB.workbanch.bindFunction = function() {
	HXTD_CRM_WB.workbanch.bindDelete();
	HXTD_CRM_WB.workbanch.bindRefresh();
	$(".close").click(HXTD_CRM_WB.workbanch.bindClose);
};
HXTD_CRM_WB.workbanch.href=function(ele,id){
	//var $this = $(this).parent().parent().parent().parent();
	var $ele = $(ele).parent().parent().parent().parent();
	var url= $ele.attr("uri").replace("query.do","toViewPage.do?id="+id);
	window.location.href=url;
};
HXTD_CRM_WB.workbanch.addWorkbanch=function(){//搜索弹出框
	var path = jsUtil.getRootPath();
	window.location.href=path+"/workbanch/toAddPage.do";
};
HXTD_CRM_WB.workbanch.getLastDay =function(year,month){        
	 var new_year = year;    //取当前的年份        
	 var new_month = month++;//取下一个月的第一天，方便计算（最后一天不固定）        
	 if(month>12)            //如果当前大于12月，则年份转到下一年        
	 {        
	  new_month -=12;        //月份减        
	  new_year++;            //年份增        
	 }        
	 var new_date = new Date(new_year,new_month,1);                //取当年当月中的第一天        
	 return (new Date(new_date.getTime()-1000*60*60*24)).getDate();//获取当月最后一天日期        
}  
$(function() {
	HXTD_CRM_WB.workbanch.bindFunction();
});