<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>时间区域组件</title>
<link rel="stylesheet" href="${ctx}/static/css/public/common.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/public/reset.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/static/css/recommend/list1.css" type="text/css"/>
<link href="${ctx}/static/css/recommend/empower.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.custom.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/static/js/api/api.string.js"></script>
<script type="text/javascript" src="${ctx}/static/js/js-util.js"></script>
<script type="text/javascript" src="${ctx}/static/js/commonAjax.js"></script>
<style>
.module1{height: 20px;background:url(${ctx}/static/images/System_bg.png) repeat-x; border: 1px solid #c2c2c2;margin: 5px 5px 0 0; padding:5px; width:90%;cursor:hand}
.module2{height: 35px;line-height:35px;background:url(${ctx}/static/images/System_bg.png) repeat-x; margin: 5px 5px 0 0; padding:5px; width:90%;}
.select_border{border:1px solid #e28d1f}
.list li{ float:left; width:33%; margin-top:5px;}
.list li .module {background:url(${ctx}/static/images/System_bg.png) repeat-x; border: 1px solid #c2c2c2; height: 20px; padding:5px; width:90%; height:60px; cursor:pointer;}
</style>
<script type="text/javascript">
$(function(){
	$(".list .module1").click(function(){
			var $this = $(this);
			if($this.hasClass("select_border")){
				$this.removeClass("select_border");
			}else{
				$this.addClass("select_border");
			}
	});
	
	$(".check").click(function(){
			var $this = $(this);
			var month;
			month = eval("("+$this.attr("param")+")");
			var $divs = $("#"+month[0]+",#"+month[1]+",#"+month[2]);
			var flag=$this.attr("check");
			switch(flag){
				case "true":
					$divs.removeClass("select_border");
					$this.attr("check",false);
					$this.removeClass("allright").addClass("allnoright");//.addClass("allright");
					break;
				case "false":
					$divs.addClass("select_border");
					$this.attr("check",true);
					$this.removeClass("allnoright").addClass("allright");//.addClass("allnoright");
					break;
			}
	});
	$(".year").click(function(){
		var $this = $(this);
		var $check = $(".check");
		var flag=$this.attr("check");
		switch(flag){
			case "true":
				$(".module1").removeClass("select_border");
				$this.attr("check",false);
				$this.removeClass("allright").addClass("allnoright");
				$check.attr("check",false);
				$check.removeClass("allright").addClass("allnoright");
				break;
			case "false":
				$(".module1").addClass("select_border");
				$this.attr("check",true);
				$this.removeClass("allnoright").addClass("allright");
				$check.attr("check",true);
				$check.removeClass("allnoright").addClass("allright");
				break;
		}
	});
	var date = new Date();
	var year = date.getFullYear();
	// 给年度下拉框添加选项,当前年份+下一个年份
	$("#year").append("<option value='"+(year-1)+"'>"+(year-1)+"</option>").append("<option value='"+year+"' selected>"+year+"</option>").append("<option value='"+(year+1)+"'>"+(year+1)+"</option>");
	
});
</script>
</head>
<body>
<div class="margin0">
	<div class="w" style="line-height: 35px;margin-bottom: 30px;">
		<div class="fl" style="width: 25%"><a href="javascript:;" class="fl block mr10 year allnoright" check="false"></a>年度:</div><select id="year" class="select2"></select>
	</div>
	<div style="background: #fff;min-height:470px; ">
		<ul class="w cb list">
			<li>
				<a href="javascript:;" class="fl block mr10 check allnoright" check="false" param="[1,2,3]"></a>
				<div class="module2">
						第一季度（春）
				</div>
			</li>
			<li class="cb">
				<div class="module1" id="1">
					<table >
						<tr>
							<td>
								一月（January）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="2">
					<table >
						<tr>
							<td>
								二月（February）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="3">
					<table >
						<tr>
							<td>
								三月（March）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li class="cb" style="margin-top:20px;">
			<a href="javascript:void(0)" class="fl block mr10 check allnoright" check="false" param="[4,5,6]"></a>
				<div class="module2">
								第二季度（夏）
				</div>
			</li>
			<li class="cb">
				<div class="module1" id="4">
					<table >
						<tr>
							<td>
								四月（April）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="5">
					<table >
						<tr>
							<td>
								五月（May）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="6">
					<table >
						<tr>
							<td>
								六月（June）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li class="cb" style="margin-top:20px;">
			<a href="javascript:void(0)" class="fl block mr10 check allnoright" check="false" param="[7,8,9]"></a>
				<div class="module2">
								第三季度（秋）
				</div>
			</li>
			<li class="cb">
				<div class="module1" id="7">
					<table >
						<tr>
							<td>
								七月（July）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="8">
					<table >
						<tr>
							<td>
								八月（July）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="9">
					<table >
						<tr>
							<td>
								九月（September）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li class="cb" style="margin-top:20px;">
			<a href="javascript:void(0)" class="fl block mr10 check allnoright" check="false" param="[10,11,12]"></a>
				<div class="module2">
								第四季度（冬）
				</div>
			</li>
			<li class="cb">
				<div class="module1" id="10">
					<table >
						<tr>
							<td>
								十月（October）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="11">
					<table >
						<tr>
							<td>
								十一月（November）
							</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<div class="module1" id="12">
					<table >
						<tr>
							<td>
								十二月（December）
							</td>
						</tr>
					</table>
				</div>
			</li>
		</ul>
	</div>
</div>
</body>
</html>