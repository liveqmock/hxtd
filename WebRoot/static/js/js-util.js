//dialog全局对象
var DIALOG;
var jsUtil = {
	getRootPath:function(){
		//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
		var curWwwPath = window.document.location.href;
		//获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
		var pathName = window.document.location.pathname;
		var pos = curWwwPath.indexOf(pathName);
		//获取主机地址，如： http://localhost:8083
		var localhostPaht = curWwwPath.substring(0, pos);
		//获取带"/"的项目名，如：/uimcardprj
		var projectName = pathName.substring(0,
				pathName.substr(1).indexOf('/') + 1);
		if(projectName=="/hxtd"){
			return (localhostPaht + projectName);
		}
			return localhostPaht;
	},
	init:function(){ 
		//动态加载有时会使页面上的js代码的效果失效，改用直接加载
		$('body').append("<div id='dialog' style='display:none; overflow:hidden;'></div>");
		DIALOG = $( "#dialog" );
	},
	getDialogConfig:function(title,width,height){
		var config = {
			resizable:false,
			bgiframe: true,
			autoOpen: false,
			modal: true,
			closeOnEscape: true,
			title: '提示',
			width:300,
			height:160
		};
		if(title){
			config.title=title;
		}
		if(width){
			config.width=width;
		}
		if(height){
			config.height=height;
		}
		return config;
	},
	dialogIframe:function(url,title,width,height,yesFun){
		//this.height=this.contentWindow.document.documentElement.scrollHeight;
		DIALOG.html("<div style='padding:0px;'>" +
		"<iframe onload='javascript:this.height=this.contentWindow.document.body.scrollHeight;'" +
		" id='dialogIframe' name='dialogIframe' height='100%' width='100%' frameborder='no' border='0' " +
		" scrolling='no' src='"+url+"'></iframe></div>");
		var config = jsUtil.getDialogConfig(title,width,height);
		if(yesFun){
			config.buttons = {
				"确定" : function() {
					yesFun();
					DIALOG.dialog("close");
				},
				"关闭" : function() {
					DIALOG.dialog("close");
				}
			};
		}else{
			config.buttons = {
				"关闭" : function() {
					DIALOG.dialog("close");
				}
			};
		}
		DIALOG.dialog(config);
		DIALOG.dialog("open");
	},
	alert:function(msg,title,width,height){
		DIALOG.text(msg);
		var config = jsUtil.getDialogConfig(title,width,height);
		config.buttons={"确定":function(){
				DIALOG.dialog( "close" );
			}};
		DIALOG.dialog(config);
		DIALOG.dialog("open");
	},
	confirm:function(msg,yesFun,title,width,height){
		DIALOG.text(msg);
		var config = jsUtil.getDialogConfig(title,width,height);
		// if(!yesFun){
		// 	return null;
		// }
		config.buttons={"确定":function(){
				DIALOG.dialog( "close" );
				yesFun();
			},"取消":function(){
				DIALOG.dialog( "close" );
			}};
		DIALOG.dialog(config);
		DIALOG.dialog("open");
	},
	datepicker:function(rep){
		var path = jsUtil.getRootPath();
		$.getScript(path+ "/static/js/ui/jquery.ui.datepicker.js",function(){
			$.datepicker.regional['zh-CN'] = {
				closeText : '关闭',
				prevText : '&#x3c;上月',
				nextText : '下月&#x3e;',
				currentText : '今天',
				monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月',
						'九月', '十月', '十一月', '十二月' ],
				monthNamesShort : [ '一', '二', '三', '四', '五', '六', '七', '八',
						'九', '十', '十一', '十二' ],
				dayNames : [ '星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六' ],
				dayNamesShort : [ '周日', '周一', '周二', '周三', '周四', '周五', '周六' ],
				dayNamesMin : [ '日', '一', '二', '三', '四', '五', '六' ],
				weekHeader : '周',
				dateFormat : 'yy-mm-dd',
				firstDay : 1,
				isRTL : false,
				showMonthAfterYear : true,
				yearSuffix : '年'
			};  
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
        var time = $(rep);
			if (time.length != 2) {
				time.datepicker();
			} else {
				var begin = time[0];
				var end = time[1];
				var setting_begin = {
					showAnim : '',
					numberOfMonths : 1,
					beforeShow : function(input, inst) {
						var myDate = new Date();
						var m = myDate.getMonth() + 1;
						var dateNow = myDate.getFullYear() + "-" + m + "-"
								+ myDate.getDate();
						var end = $(end).val();
						var max;
						if (!end) {
							max = dateNow;
						} else {
							max = dateNow < end ? dateNow : end;
						}
						$(this).datepicker("option", "maxDate", max);
					}
				};
				var setting_end = {
					showAnim : '',
					numberOfMonths : 1,
					beforeShow : function(input, inst) {
						var myDate = new Date();
						var m = myDate.getMonth() + 1;
						var dateNow = myDate.getFullYear() + "-" + m + "-"
								+ myDate.getDate();
						$(this).datepicker("option", "maxDate", dateNow);
						var min = $(begin).val();
						$(this).datepicker("option", "minDate", min);
					}
				};
				$(begin).datepicker(setting_begin);
				$(end).datepicker(setting_end);
			}
		});
	},
	datepickerNotNow:function(rep){
		$.getScript(jsUtil.getRootPath()+ "/static/js/ui/jquery.ui.datepicker.js",function(){
			$.datepicker.regional['zh-CN'] = {
				closeText : '关闭',
				prevText : '&#x3c;上月',
				nextText : '下月&#x3e;',
				currentText : '今天',
				monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月',
						'九月', '十月', '十一月', '十二月' ],
				monthNamesShort : [ '一', '二', '三', '四', '五', '六', '七', '八',
						'九', '十', '十一', '十二' ],
				dayNames : [ '星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六' ],
				dayNamesShort : [ '周日', '周一', '周二', '周三', '周四', '周五', '周六' ],
				dayNamesMin : [ '日', '一', '二', '三', '四', '五', '六' ],
				weekHeader : '周',
				dateFormat : 'yy-mm-dd',
				firstDay : 1,
				isRTL : false,
				showMonthAfterYear : true,
				yearSuffix : '年'
			};  
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
        var time = $(rep);
        var beginTime = time[0];
		var endTime = time[1];
		var setting_begin = {
					showAnim : '',
					numberOfMonths : 1,
					beforeShow : function(input, inst) {
						var end = $(endTime).val();
						if (end) {
							$(beginTime).datepicker("option", "maxDate", end);
						}
					}
				};
		var setting_end = {
					showAnim : '',
					numberOfMonths : 1,
					beforeShow : function(input, inst) {
						var min = $(beginTime).val();
						if(min){
							$(endTime).datepicker("option", "minDate", min);
						}
					}
				};
		$(beginTime).datepicker(setting_begin);
		$(endTime).datepicker(setting_end);
		
		for(var i=2;i<time.length;i++){
			$(time[i]).datepicker();
		}
		});
	},
	easyTree : {
		init:function(data,chileNodeFun){
			var path = jsUtil.getRootPath();
			$('head').append('<link rel="stylesheet" href="'+path+'/static/css/zTreeStyle.css">');
			$.getScript(path+"/static/js/jquery.ztree.core-3.5.js",function(){
				var setting = {
					view: {
						dblClickExpand: false,
						showLine: false,
						selectedMulti: false,
						showIcon: false,
						showTitle: false
					},
					data: {
						simpleData: {
							enable:true,
							idKey: "id",
							pIdKey: "pId",
							rootPId: ""
						}
					},
					callback: {
						beforeClick: function(treeId, treeNode) {
							var zTree = $.fn.zTree.getZTreeObj("tree");
							if (treeNode.isParent) {
								zTree.expandNode(treeNode);
								return false;
							} else {
								chileNodeFun(treeNode);
								return true;
							}
						}
					}};
				var t = $("#tree");
				if(t.length <= 0){
					$('body').append("<div id='treeDiv' class='ztree' style='background-color:white;position:absolute;border:1px solid #eee;display:none;'><ul id='tree' style='max-height:200px; overflow:hidden; overflow-y:auto;'></ul></div>");
					var t = $("#tree");
				}
				$.fn.zTree.init(t, setting, data);
			});
		},
		show:function(rep){
			var obj = $(rep);
			var Offset = obj.offset();
			$("#treeDiv").css({left:Offset.left + "px", top:Offset.top + obj.outerHeight() + "px"}).slideDown("fast");
			$("#tree").css({width:obj.outerWidth() + "px"});
		
			$(document).bind("mousedown", jsUtil.easyTree.onBodyDown);
		},
		hide:function(){
			$("#treeDiv").fadeOut("fast");
			$(document).unbind("mousedown", jsUtil.easyTree.onBodyDown);
		},
		onBodyDown:function(event){
			if (!(event.target.id == "treeDiv" || $(event.target).parents("#treeDiv").length>0)) {
				jsUtil.easyTree.hide();
			}
		}
	}
};
$(function(){
	jsUtil.init();
});