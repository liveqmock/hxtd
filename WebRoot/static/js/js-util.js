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
			var txtObj;
			$(rep).datepicker({//datepicker本地化
				maxDate: 0, //设置最大时间界限
				onSelect: function(selectedDate){
					var sltObj = this, index = 0, option = "minDate";
					$(rep).each(function(i, obj){
						if(sltObj == obj){
							if(i % 2 == 1){
								option = "maxDate";
								index = i - 1;
							}else{
								option = "minDate";
								index = i + 1;
							}
							return false;
						}
					});
					$(rep).eq(index).datepicker("option", option, selectedDate);
			    },
			    beforeShow: function(input, inst){
			    	txtObj = input;
			    }
			});
			$(".ui-datepicker-close").live("click", function(){
				if(txtObj.value == '') return false;
				txtObj.value = ''; // 清空
				
				var $dateTxtObj = $(txtObj), 
					$prevDate = $dateTxtObj.prev(), 
					$nextDate = $dateTxtObj.next();
				if($prevDate.length > 0 ){
					$prevDate.datepicker("option", "maxDate", 0);
				}
				if($nextDate.length > 0){
					$nextDate.datepicker("option", "minDate", null);
				}
			});
	},
	datepickerNotNow:function(rep){
			var txtObj;
			$(rep).datepicker({//datepicker本地化
				onSelect: function(selectedDate){
					var sltObj = this, index = 0, option = "minDate";
					$(rep).each(function(i, obj){
						if(sltObj == obj){
							if(i % 2 == 1){
								option = "maxDate";
								index = i - 1;
							}else{
								option = "minDate";
								index = i + 1;
							}
							return false;
						}
					});
					$(rep).eq(index).datepicker("option", option, selectedDate);
			    },
			    beforeShow: function(input, inst){
			    	txtObj = input;
			    }
			});
			$(".ui-datepicker-close").live("click", function(){
				if(txtObj.value == '') return false;
				txtObj.value = ''; // 清空
				
				var $dateTxtObj = $(txtObj), 
					$prevDate = $dateTxtObj.prev(), 
					$nextDate = $dateTxtObj.next();
				if($prevDate.length > 0 ){
					$prevDate.datepicker("option", "maxDate", 0);
				}
				if($nextDate.length > 0){
					$nextDate.datepicker("option", "minDate", null);
				}
			});
	},
	datepickerAll:function(rep){
			var txtObj;
			$(rep).datetimepicker({//datepicker本地化
				timeFormat: "HH:mm:ss",
                dateFormat: "yy-mm-dd",
				timeOnlyTitle: '选择时间',
				timeText: '时间',
				hourText: '小时',
				minuteText: '分钟',
				secondText: '秒钟',
				millisecText: '毫秒',
				microsecText: '微秒',
				timezoneText: '时区',
				currentText: '现在时间',
				closeText: '清空',
				timeFormat: 'HH:mm',
				amNames: ['AM', 'A'],
				pmNames: ['PM', 'P'],
				isRTL: false,
				onSelect: function(selectedDate){
					var sltObj = this, index = 0, option = "minDate";
					$(rep).each(function(i, obj){
						if(sltObj == obj){
							if(i % 2 == 1){
								option = "maxDate";
								index = i - 1;
							}else{
								option = "minDate";
								index = i + 1;
							}
							return false;
						}
					});
					$(rep).eq(index).datepicker("option", option, selectedDate);
			    },
			    beforeShow: function(input, inst){
			    	txtObj = input;
			    }
			});
			$(".ui-datepicker-close").live("click", function(){
				if(txtObj.value == '') return false;
				txtObj.value = ''; // 清空
				
				var $dateTxtObj = $(txtObj), 
					$prevDate = $dateTxtObj.prev(), 
					$nextDate = $dateTxtObj.next();
				if($prevDate.length > 0 ){
					$prevDate.datepicker("option", "maxDate", 0);
				}
				if($nextDate.length > 0){
					$nextDate.datepicker("option", "minDate", null);
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
	},
	f : {
		stopPropagation : function(event){
			if(event){
				if(event.stopPropagation){
					event.stopPropagation();
				}else{
					event.cancelBubble = true;
				}
			}else{
				return false;	
			}
		}
	}
};
$(function(){
	jsUtil.init();
});