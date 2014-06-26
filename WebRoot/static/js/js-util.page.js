/**
 * js渲染列表页使用的类
 * @auth ruisong.luan 
 */
jsUtil.page = {};
/**防重复提交标识*/
jsUtil.page.loadFlag=true;
/**
 * 参数组装的方法，
 * @params 在模糊查询的所有输入框外面嵌套一个ID为form的<form>
 * @return {TypeName} 
 */
jsUtil.page.getParams=function(){
	var pageSize = $("#pageSize").val()== undefined?10:$("#pageSize").val();
	var pageNo = $("#pageNo").val()== undefined?1:$("#pageNo").val();
	var params = $('#form').formSerialize();
	return params+"&hibernatePageSize="+pageSize+"&hibernatePageNo="+pageNo;
};
/**
 * 加载列表页，调用时传入query的权限代码
 * @param {Object} query 权限代码 例：010701
 * @param {Object} successFun 成功后的回调函数用于拼接列表
 */
jsUtil.page.loadData=function(query,successFun){
	//var query = '010701';
	if(jsUtil.page.loadFlag){
		jsUtil.page.loadFlag=false;
		jsUtil.page.removeFunction();
		if(query in window.baseInfo.session.functions){
			RcmsAjax.ajax(jsUtil.getRootPath()+window.baseInfo.session.functions[query].url,successFun,null,jsUtil.page.getParams());
		}
	}
};
/**
 * 给删除按钮提供的事件方法
 * @param {Object} deleteFlag 删除权限代码 例：'010705'
 * @param {Object} id 需要删除的ID
 */
jsUtil.page.deleteById=function(deleteFlag,id){
	if(deleteFlag in window.baseInfo.session.functions){
		jsUtil.confirm("危险操作，是否继续",function(){
			RcmsAjax.ajax(jsUtil.getRootPath()+window.baseInfo.session.functions[deleteFlag].url,function(){
				$("#rel").trigger('click');
			},null,"id="+id);
		},"警告");
	}
};
/**
 * 后台hibernatePage对象转换列表底部
 * 注：需在列表table下首先加入一个id为tableFoot的div
 * @param {Object} page hibernatePage对象
 * @param {Object} query 查询权限标识
 * @param {Object} successFun 回调函数，同loadData时的回调
 */
jsUtil.page.page2TableFoot=function(page,query,successFun){
	var foot = new Array();
	var path = jsUtil.getRootPath();
	foot.push('<table cellspacing="1" class="tablesorter"><tr><td><div class="fl">每页条数：<select name="pageSize" id="pageSize">');
	for(var i=1;i<=5;i++){
		foot.push('<option value="',i*10,'"');
		if(page.hibernatePageSize==i*10){
			foot.push(' selected');
		}
		foot.push('>',i*10,'</option>');
	}
	foot.push('</select></div><div class="clear"></div>');
	foot.push('<ul class="fynew"><li>|</li>');		
	if(page.hibernatePageNo==1){
		foot.push('<li><a><img src="',path,'/static/images/llbtn_h.png" alt="" /></a></li>');
		foot.push('<li><a><img src="',path,'/static/images/lbtn_h.png"');
	}else{
		foot.push('<li><a href="javascript:void(0)" id="first"><img src="',path,'/static/images/llbtn.png" alt="" /></a></li>');
		foot.push('<li><a href="javascript:void(0)" id="pre"><img src="',path,'/static/images/lbtn.png"');
	}
	foot.push(' alt="" /></a></li><li>|</li>');		
	foot.push('<li>第<input type="text" id="pageNo" value="',page.hibernatePageNo ,'"/>页 <a href="javascript:;" style="color:blue;">go</a>，共<label id="totalPages">',page.totalPageValue,'</label>页</li><li>|</li>');
	if(page.hibernatePageNo==page.totalPageValue){
		foot.push('<li><a><img src="',path,'/static/images/rbtn_h.png" alt="" /></a></li>');
		foot.push('<li><a><img src="',path,'/static/images/rrbtn_h.png" alt="" /></a></li>');
	}else{
		foot.push('<li><a href="javascript:void(0)" id="next"><img src="',path,'/static/images/rbtn.png" alt="" /></a></li>');
		foot.push('<li><a href="javascript:void(0)" id="end"><img src="',path,'/static/images/rrbtn.png" alt="" /></a></li>');
	}
	foot.push('<li>|</li><li><a href="javascript:void(0)" id="rel"><img src="',path,'/static/images/gengxi.png" alt="" /></a></li></ul><div id="pageDiv" class="fr" style="margin-right:10px;">');
	foot.push('显示',page.first,'到',page.endRow,'，共',page.totalCount,'<label id="totalCount"></label>记录</div></td></tr></table>');			
	$("#tableFoot").html(foot.join(""));
	jsUtil.page.addFunction(page,query,successFun);
};
jsUtil.page.addFunction=function(page,query,successFun){
	$("#pageSize").change(function(){
		$("#pageNo").val(1);
		jsUtil.page.loadData(query,successFun);	
	});
	$("#pageNo").blur(function(){
		var no = $("#pageNo").val();
		var rep = /^\d*$/;
		if(!rep.test(no)||parseInt(no)>page.totalPageValue||parseInt(no)==0){
			jsUtil.alert("请输入正确的页码");
			return false;
		}
		$("#pageNo").val(no);
		jsUtil.page.loadData(query,successFun);	
	});
	$("#first").click(function(){
		$("#pageNo").val(1);
		jsUtil.page.loadData(query,successFun);	
	});
	$("#pre").click(function(){
		var no = $("#pageNo").val();
		no = no-1>0?no-1:1;
		$("#pageNo").val(no);
		jsUtil.page.loadData(query,successFun);	
	});
	$("#next").click(function(){
		var no = parseInt($("#pageNo").val());
		var count = parseInt($("#totalPages").text());
		no = no+1;
		no = no>count?count:no;
		$("#pageNo").val(no);
		jsUtil.page.loadData(query,successFun);	
	});
	$("#end").click(function(){
		var count = parseInt($("#totalPages").text());
		$("#pageNo").val(count);
		jsUtil.page.loadData(query,successFun);	
	});
	$("#rel").click(function(){
		jsUtil.page.loadData(query,successFun);	
	});
	jsUtil.page.loadFlag=true;
};
jsUtil.page.removeFunction=function(){
	var path = jsUtil.getRootPath();
	$("#pageSize").removeAttr("onchange");
	$("#pageNo").removeAttr("onblur");
	
	jsUtil.page.removeAttr($("#first"),path+'/static/images/llbtn_h.png');
	jsUtil.page.removeAttr($("#pre"),path+'/static/images/lbtn_h.png');
	jsUtil.page.removeAttr($("#next"),path+'/static/images/rbtn_h.png');
	jsUtil.page.removeAttr($("#end"),path+'/static/images/rrbtn_h.png');
	$("#rel").removeAttr("onclick");
};
jsUtil.page.removeAttr=function(ele,imgPath){
	ele.removeAttr("onclick");
	ele.removeAttr("href");
	ele.html('<img src="'+imgPath+'" alt="" />');
}
