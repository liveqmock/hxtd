<%--
  功能描述：编辑销售目标
  User: xiaoli.luo
  Date:2014/5/6
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>销售目标编辑</title>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/detail_a.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/static/js/validator.js"></script>
<script type="text/javascript">
peopleFlag = true;
$(function(){
	if($("#form").attr("action").indexOf("modify")>-1){
		$(".popleC").hide();
		peopleFlag = false;
	}else{
		$(".owner").hide();
	}
	$("#saveAndAdd").click(function(){
		var $form = $("#form");
		if(!setPeopleIds()){
			return false;
		}
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				setTimeout(function(){
					window.location.replace("${ctx}/sales/salesTarget/toAddPage.do")
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
	$("#save").click(function(){
		var $form = $("#form");
		if(!setPeopleIds()){
			return false;
		}
		if($form.valid()){
			RcmsAjax.ajax($form.attr("action"),function(result){
				//redirect
				var id = result.result.result;
				setTimeout(function(){
					window.location.replace("${ctx}/sales/salesTarget/toQueryPage.do?")
				},500);
			},null,$form.formSerialize());
		}
		return false;
	});
});
function searchData(){//搜索弹出框
	var url = "${ctx}/sales/salesTarget/view.comp?type=time";
	var title = "选择时间周期";
	jsUtil.dialogIframe(url, title, 600, 600, function(){//确定回调
			var $Obj = $(".select_border", window.frames["dialogIframe"].document);
			var year = $("#year", window.frames["dialogIframe"].document).val();
			var ids = [];
			$Obj.each(function(){ids.push(parseInt(this.id))});
			var flag = true;
			for(var i=0;i<ids.length;i++){
				if(i<ids.length-1){
					if((ids[i]+1)!=ids[i+1]){
						flag = false;
					}
				}
			}
			if(flag){
				if(ids.length>0){
					var beginTime = year+"-"+ids[0]+"-1 00:00:00";
					var endTime = year+"-"+ids[ids.length-1]+"-"+getMonthEndDay(ids[ids.length-1])+" 23:59:59";
					var str = new Array();
					str.push(year);
					str.push("年 ");
					if(ids.length==1){
						str.push(ids[0],"月");
					}else{
						str.push(ids[0],"-"+ids[ids.length-1],"月");
					}
					$("#time").val(str.join(''));
					$("#beginTime").val(beginTime);
					$("#endTime").val(endTime);
				}else{
					flag=false;
					showMessage("请选择月份",false);
				}
			}else{
				showMessage("请选择连续的月份或季度",false);
			}
			return flag;
	});
}

//搜索弹出框
function searchUser(){
	var	url = "${ctx}/system/user/toQueryUser.comp?TYPE=business";
	var	title = "用户选择";
	jsUtil.dialogIframe(url, title, 400, 500, function(){//确定回调
		var userNames = $("#hide_usernames", window.frames["dialogIframe"].document).val();
		var ids = $("#hide_userids", window.frames["dialogIframe"].document).val();
		appendPeople(userNames,ids)
	});
};
function clearInputVal(obj){ //清除
	$(obj).prevAll("input").val('');
}
function getMonthEndDay(month){
	switch(month){
		case 1:
			return 31;
		case 2:
			return 28;
		case 3:
			return 31;
		case 4:
			return 30;
		case 5:
			return 31;
		case 6:
			return 30;
		case 7:
			return 31;
		case 8:
			return 31;
		case 9:
			return 30;
		case 10:
			return 31;
		case 11:
			return 30;
		case 12:
			return 31;
	}
}
function showMessage(msg,flag){
	showMsg({successFlag:flag,message:msg});
	setTimeout(_hide(),RcmsAjax.global.showTime);
}
function appendPeople(name,id){
	var names = name.split(",");
	var ids = id.split(",");
	for(var i=0;i<names.length;i++){
		if($("#"+ids[i]).length==0){
			$("#people").append('<li id="'+ids[i]+'" class="people">'+names[i]+'<a href="javascript:deletePeople('+ids[i]+');" class="none"><img src="${ctx }/static/images/wite_fulse.png" width="18" height="18" /></a></li>');
		}
	}
	
}
function deletePeople(id){
	$("#"+id).remove();
	var $owners = $("#hide_owner_id");
	var newOwners = $owners.val().replace(""+id,"");
	$owners.val(newOwners);
}
function getPeopleIds(){
	var arr = new Array();
	$(".people").each(function(){
		arr.push($(this).attr("id"));
	});
	return arr.join(",");
}
function setPeopleIds(){
	if(!peopleFlag){
		return true;
	}
	var ids = getPeopleIds();
	if(ids.length==0){
		showMessage("请选择目标的制定人员",false);
		return false;
	}else{
		$("#hide_owner_id").val(ids);
		return true;
	}
}
</script>
</head>
<body>
<form id="form" action="${ctx }${funcUrl}" method="post">
<div>
	<!--请在此处使用iframe--->
	<!--查询条件开始-->

	<!--查询条件结束-->
	<div class="cb"></div>
	<!--列表开始-->
	<div class="ml35 mr35 mt20 block cb cb">
		<b class="b1"></b>
		<b class="b2"></b>
		<b class="b3"></b>
		<b class="b4"></b>
		<div class="ie_head">
			<h1 class="f14 fbnone mt10 ml10 fl">
				销售目标详情信息
			</h1>
			<ul class="fr id_table1 mt10 ml10">
			</ul>
		</div>
	</div>
	<input type="hidden" id="id" name="id" value="${salesTarget.id}" />
	<div class="ml35 mr35 bg_c_blue cb">
		<h1 class="f14 fbnone ml40 pt10">
			基本信息
		</h1>
		<table class="cb id_table3 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>标题：
				</td>
				<td align="left">
				<input type="text" name="title"
						value="${salesTarget.title}" class="text_input3 required" />
				</td>
				<td align="right">
					<span class="w_red">*&nbsp;</span>时间周期：
				</td>
				<td align="left">
					<input type="text" id="time" name="timeStr"
						value="${salesTarget.timeStr}" class="text_input3 required" onclick="searchData()"/>
					
					<fmt:formatDate value="${salesTarget.beginTime }"
						pattern="yyyy-MM-dd HH:mm:ss" var="beginTime" />
					<input type="hidden" name="beginTime" id="beginTime" value="${beginTime}"/>
					<fmt:formatDate value="${salesTarget.endTime }"
						pattern="yyyy-MM-dd HH:mm:ss" var="endTime" />
					<input type="hidden" name="endTime" id="endTime" value="${endTime}"/>
					<i class="s_inquiry globle_img block_inline ml5 vm cp"
						title="搜索所有者" onclick="searchData();"></i>
					<i class="dump_btn globle_img block_inline ml5 vm cp empty"
						onclick="clearInputVal(this)" title="清除"></i>
				</td>
					
			</tr>
			<tr>
				<td align="right" width="15%">
					<span class="w_red">*&nbsp;</span>目标成交额（万）：
				</td>
				<td align="left">
				<input type="text" name="bargainMoney"
						value="${salesTarget.bargainMoney}" class="text_input3 required" />
				</td>
				<td align="right" width="15%" class="owner">
					目标人员：
				</td>
				<td align="left" class="owner">
					${salesTarget.owner.realName}
				</td>
				
			</tr>
		</table>
		<h1 class="pt10 f14 fbnone ml40 popleC">
			人员列表
			<i class="s_inquiry globle_img block_inline ml5 vm cp"
						title="搜索所有者" onclick="searchUser();"></i>
			<i class="dump_btn globle_img block_inline ml5 vm cp empty"
						onclick="$('#people').html('')" title="清除"></i>
		</h1>
		<input type="hidden" id="hide_owner_id" name="ownerIds"
					value="${salesTarget.owner.id}"/>
        <div class="cb id_table4 w95b bg_c_white margin0 mt10 mb10 popleC" style="overflow:hidden;min-height:150px;">
            <ul class="id_ul2 cb ml35 mr35" id="people">
            </ul>
        </div>
		
		<h1 class="f14 fbnone ml40 pt10">
			描述信息
		</h1>
		<table class="cb id_table4 w95b bg_c_white margin0 mt10">
			<tr>
				<td align="right" width="15%" valign="top">
					备注：
				</td>
				<td align="left" width="85%" valign="top">
					<textarea name="remark" class="remarks_input1 {maxlength:512}">${salesTarget.remark}</textarea>
				</td>
			</tr>

		</table>
		<div class=" h40"></div>
	</div>
	<div class="cb block h40 margin0 mt10" style="width: 350px;">
		<ul class="id_table1 cb">
			<li>
				<a href="javascript:;" id="save" class="block c_white lh25 mr35"><b
					class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保&nbsp&nbsp存</b> </a></a>
			</li>
			<li>
				<a href="javascript:;" id="saveAndAdd"
					class="block c_white lh25 mr35"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">保存并新建</b> </a>
			</li>
			<li>
				<a href="${ctx}/sales/salesTarget/toQueryPage.do"
					class="block c_white lh25"><b class="allbtn_l block fl"></b><b
					class="allbtn_r pr13 block fl w_auto f14">取&nbsp&nbsp消</b> </a>
			</li>
		</ul>
	</div>
</div>
</form>
</body>
</html>

