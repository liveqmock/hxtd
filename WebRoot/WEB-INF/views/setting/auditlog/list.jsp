
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
	<head>
		<title>审计日志列表页</title>
		<link href="${ctx}/static/css/stressing/empower.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/static/css/recommend/detail.css?v=1" rel="stylesheet" type="text/css" />
		<link href="${ctx}/static/css/application.css?v=1" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx}/static/js/jquery-jtemplates.js?v=1"></script>
		<script type="text/javascript" src="${ctx}/static/js/js-util.common.js?v=1"></script>
		<script type="text/javascript" src="${ctx}/static/js/scrollTitle.js?v=1"></script>
		<script type="text/javascript">

$(function() {
	var grid = new Grid().init();
});
</script>
	</head>

	<body style="min-width: 1100px;">
		<div style="min-height: 750px;">
			<div class="margin0 ml35 mr35 listcontainer">
				<div class="w">
					<form id="form" action="${ctx}/setting/auditlog/query.do"
						onsubmit="return false;">
						<table class="fl mt5 w">
							<tr>
								<td class="f14" align="right" width="7%">
									用户：
								</td>
								<td class="f14" align="left" width="13%">
									<input type="text" class="text_input1" id="typeId"
										name="search_EQ_operator" />
								</td>
								<td class="f14" align="right" width="7%">
									模块：
								</td>
								<td class="f14" align="left" width="13%">
									<select name="type" name="search_EQ_moduleName"
										class="select2 pr">
										<option value="all">
											--全部--
										</option>
										<option value="市场活动">
											市场活动
										</option>
										<option value="线索">
											线索
										</option>
										<option value="联系人">
											联系人
										</option>
										<option value="客户">
											客户
										</option>
										<option value="供应商">
											供应商
										</option>
										<option value="项目">
											项目
										</option>
										<option value="产品">
											产品
										</option>
										<option value="订单">
											订单
										</option>
									</select>
								</td>
								<td class="f14" align="right" width="7%">
									操作类型：
								</td>
								<td class="f14" align="left" width="13%">
									<input type="text" class="text_input1" id="typeId"
										name="search_EQ_type" />
								</td>
								<%--
    --%>
								<td width="15%">
									<a class="reset block dump_btn globle_img fr mr35"
										href="javascript:formReset()"></a>
									<a href="javascript:void(0)"
										class="block c_white lh25 fr mr10 submit"> <b
										class="allbtn_l block fl"></b> <b
										class="allbtn_r pr13 block fl w_auto f14">查&nbsp;&nbsp;询</b> </a>
								</td>
								<td class="f14" align="right" width="7%"></td>
								<td class="f14" align="left" width="18%"></td>
								<tags:paginationparams page="${page}" />
							</tr>
						</table>
					</form>
					<!--查询条件结束-->
					<ul class="fl id_table3 w block cb mt10"
						style="border-bottom: 5px solid #626262; height: 32px;">
						<li>
							<b class="h_tabbtn_l w25 block fl"></b>
							<b
								class="h_tabbtn_r c_white pr25 w_auto f14 block fr lh32 cp id_nav pr">市场活动
							</b>
						</li>
						<li>
							<b class="h_tabbtn_l w25 block fl"></b>
							<b
								class="h_tabbtn_r c_white pr25 w_auto f14 block fr lh32 cp id_nav pr">线索
							</b>
						</li>
						<li>
							<b class="h_tabpitchbtn_l w25 block fl"></b>
							<b
								class="h_tabpitchbtn_r c_222 pr25 w_auto f14 block fr lh32 cp id_nav pr">联系人</b>
						</li>
						<li>
							<b class="h_tabpitchbtn_l w25 block fl"></b>
							<b
								class="h_tabpitchbtn_r c_222 pr25 w_auto f14 block fr lh32 cp id_nav pr">客户</b>
						</li>
						<li>
							<b class="h_tabpitchbtn_l w25 block fl"></b>
							<b
								class="h_tabpitchbtn_r c_222 pr25 w_auto f14 block fr lh32 cp id_nav pr">供应商</b>
						</li>
						<li>
							<b class="h_tabpitchbtn_l w25 block fl"></b>
							<b
								class="h_tabpitchbtn_r c_222 pr25 w_auto f14 block fr lh32 cp id_nav pr">项目
							</b>
						</li>
						<li>
							<b class="h_tabpitchbtn_l w25 block fl"></b>
							<b
								class="h_tabpitchbtn_r c_222 pr25 w_auto f14 block fr lh32 cp id_nav pr">产品
							</b>
						</li>
						<li>
							<b class="h_tabpitchbtn_l w25 block fl"></b>
							<b
								class="h_tabpitchbtn_r c_222 pr25 w_auto f14 block fr lh32 cp id_nav pr">订单
							</b>
						</li>
						<li style="float:right;"><a class="block c_white lh25 mr10" href="javascript:;"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">还&nbsp;&nbsp;原</b></a>
</li>
                <li style="float:right;"><a class="block c_white lh25 mr10" href="javascript:;"><b class="allbtn_l block fl"></b><b class="allbtn_r pr13 block fl w_auto f14">删&nbsp;&nbsp;除</b></a></li>
					</ul>
					<ul class=" cb fr ">



					</ul>
					<!-- 浮动表头html开始 -->
					<div id="title" style="display: none; background-color: #f5f5f6;"
						class="mr35">
						<table class="cb id_table2 w">
							<tr>
								<th>
									<input type="checkbox" name="" id="id" class="checkall" />
								</th>
								<th width="7%">
									功能名
								</th>
								<th width="10%">
									功能编号
								</th>
								<th width="10%">
									归属菜单
								</th>
								<th width="15%">
									功能调用入口
								</th>
								<th width="15%" class="sortable orderby" orderby="createTime">
									创建时间
								</th>
								<th width="7%">
									创建者
								</th>
								<th width="15%" class="sortable orderby" orderby="modifiedTime">
									修改时间
								</th>
								<th width="7%">
									修改者
								</th>
								<th width="12%">
									操作
								</th>
							</tr>

						</table>
					</div>
					<!-- 浮动表头html结束 -->
					<!--列表开始-->
					<table class="cb id_table2 w tablesorter">
						<tr id="recordDiv">
							<th width="4%">
								<input name="Fruit" type="checkbox" value="" />
							</th>
							<th width="10%">
								操作人
							</th>
							<th width="9%">
								操作类型
							</th>
							<th width="9%">
								模块
							</th>
							<th width="9%">
								记录ID
							</th>
							<th width="9%">
								记录名称
							</th>
							<th width="11%">
								<span>操作时间</span>
								<tbody id="tbody" class="list"></tbody>
								<span class="margin0 block_inline ml5 vm"> <a
									href="javascript:;" class="sort_top globle_img block"></a> <a
									href="javascript:;" class="sort_btm globle_img block mt3"></a>
								</span>
							</th>
						</tr>

					</table>

					<div class="pagination  cb ml35 mt20 h40 "></div>
					<textarea id="template-tbody" class="template template-tbody">
          {#foreach $T.result as row}
          <tr class="{$T.row$index%2==1?'':'bg_c_blue'} row w">
              <td>
					<input type="checkbox" name="id" class="checkitem"
									value="{$T.row.id}" />
						
				</td>
              <td>
                  {$T.row.operator}
              </td>
              <td>{$T.row.type.key}</td>
              <td>{$T.row.moduleName}</td>
              <td>{$T.row.recordId}</td>
              <td>{$T.row.recordName}</td>
              <td>{$T.row.operateTime}</td>
              
          </tr>
          {#/for} 
      </textarea>
					<%@include file="/WEB-INF/template/sort.jsp"%>
					<%@include file="/WEB-INF/template/pagination.jsp"%>
				</div>
			</div>
			<!--列表结束-->
		</div>

	</body>
</html>
