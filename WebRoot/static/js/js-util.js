var DIALOG; //dialog全局对象
var jsUtil = {
	getRootPath: function(){
		var curWwwPath = window.document.location.href; //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
		var pathName = window.document.location.pathname; //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
		var pos = curWwwPath.indexOf(pathName);
		var localhostPaht = curWwwPath.substring(0, pos); //获取主机地址，如： http://localhost:8083
		var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1); //获取带"/"的项目名，如：/uimcardprj
		if(projectName == "/hxtd"){
			return (localhostPaht + projectName);
		}
		return localhostPaht;
	},
	init: function(){ //动态加载有时会使页面上的js代码的效果失效，改用直接加载
		$('body').append("<div id='dialog' style='display:none; overflow:hidden;'></div>");
		DIALOG = $( "#dialog" );
	},
	getDialogConfig: function(title, width, height){
		var config = {
			resizable: false, //change the prompt box size
			bgiframe: true, //mask layer
			autoOpen: false,
			modal: true,
			closeOnEscape: true, //escape to exit
			title: '提示',
			width: 300,
			height: 160
		};
		if(title){
			config.title = title;
		}
		if(width){
			config.width = width;
		}
		if(height){
			config.height = height;
		}
		return config;
	},
	alert: function(msg, title, width, height){ //确定提示框
		DIALOG.text(msg);
		var config = jsUtil.getDialogConfig(title, width, height);
		config.buttons = {
			"确定": function(){
			DIALOG.dialog("close");
		}};
		DIALOG.dialog(config);
		DIALOG.dialog("open");
	},
	confirm: function(msg, yesFun, title, width, height){ //确认、取消提示框
		DIALOG.text(msg);
		var config = jsUtil.getDialogConfig(title, width, height);
		config.buttons = [
			{
				text: "取消",
				id:"dialogCancel",
				click: function(){
					DIALOG.dialog("close");
				},
				focus: function(){}()
			},
			{
				text: "确定",
				id:"dialogConfirm",
				click: function(){
					DIALOG.dialog("close");
					yesFun();
				}
			}
		];
		DIALOG.dialog(config);
		DIALOG.dialog("open");
		$("#dialogCancel").focus();
		return false;
	},
	dialogIframe: function(url, title, width, height, yesFun){ //jquery-dialog提示框
		DIALOG.html("<div style='padding:0px;'>" +
		"<iframe onload='javascript:this.height=this.contentWindow.document.body.scrollHeight;'" +
		" id='dialogIframe' name='dialogIframe' height='100%' width='100%' frameborder='no' border='0' " +
		" scrolling='no' src='" + url + "'></iframe></div>");
		var config = jsUtil.getDialogConfig(title, width, height);
		if(yesFun){
			config.buttons = [
			{
				text: "取消",
				id:"dialogCancel",
				click: function(){
					DIALOG.dialog("close");
				},
				focus: function(){}()
			},
			{
				text: "确定",
				id:"dialogConfirm",
				click: function(){
					var flag = yesFun();
					if (flag!=false) {
						DIALOG.dialog("close");
					}
				}
			}
		]
		}else{
			/*config.buttons = {
				"关闭": function() {
					DIALOG.dialog("close");
				}
			};*/
		}
		DIALOG.dialog(config);
		DIALOG.dialog("open");
	},
	twoOrMoreRestrictDate: function(selector, limit, limitVal){ //两个互相制约的日历   比如：开始、结束时间
		$(selector).datepicker({
			maxDate: limit == "max" ? limitVal : null,
			minDate: limit == "min" ? limitVal : null,
			onSelect: function(selectedDate){
				var sltObj = this, index = 0, option = "minDate";
				$(selector).each(function(i, obj){
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
				$(selector).eq(index).datepicker("option", option, selectedDate);
		    }
		})
		.focus(function(){
			clearDate($(this), true);
		});
	},
	SingleLimitDate: function(selector, limit, limitVal){ //单个带限制的日历
		//typeof limitVal == Date;
		$(selector).datepicker({
			maxDate: limit == "max" ? limitVal : null,
			minDate: limit == "min" ? limitVal : null
		}).focus(function(){
			clearDate($(this), false);
		});
	},
	datepicker: function(rep){
		$(rep).datepicker({
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
		    }
		}).focus(function(){
			clearDate($(this), true);
		});
	},
	datepickerNotNow: function(rep){
		$(rep).datepicker({
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
		    }
		}).focus(function(){
			clearDate($(this), true);
		});
	},
	datepickerAll: function(rep){
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
		    }
		}).focus(function(){
			clearDate($(this), true);
		});
	},
	easyTree : {
		init: function(data,chileNodeFun){
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
		show: function(rep){
			var obj = $(rep);
			var Offset = obj.offset();
			$("#treeDiv").css({left:Offset.left + "px", top:Offset.top + obj.outerHeight() + "px"}).slideDown("fast");
			$("#tree").css({width:obj.outerWidth() + "px"});
		
			$(document).bind("mousedown", jsUtil.easyTree.onBodyDown);
		},
		hide: function(){
			$("#treeDiv").fadeOut("fast");
			$(document).unbind("mousedown", jsUtil.easyTree.onBodyDown);
		},
		onBodyDown: function(event){
			if (!(event.target.id == "treeDiv" || $(event.target).parents("#treeDiv").length>0)) {
				jsUtil.easyTree.hide();
			}
		}
	},
	f: {
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
	},
	formatDiff: function(s, n){ //金额千分位， 默认保留两位小数
	    var n = n == null ? 2 : n;
	    s = parseFloat((s + "").replace(/[^\d\.-]/g,"")).toFixed(n) + "";
	    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1], t = "";
	    for(i = 0;i< l.length; i++){
	        t += l[i] + ((i + 1)%3 == 0 && (i + 1) != l.length ? "," : "");
	    }
	    var v = t.split("").reverse().join("") + "." + r;
	    if(v.match("-,")){
	        return v.replace("-,", "-");
	    } else {
	        return v;
	    }
	},
	formatMoney: function(selector){
		$(selector).bind({
			keypress: function(e){
				if(e.which == 46 || e.which == 45){
					return true;
				} else{
					if((e.which >= 48 && e.which <= 57 && e.shiftKey == false) || e.which == 0 || e.which == 8){
						return true;
					} else{
						if(e.ctrlKey && (e.which == 99 || e.which == 118)){
							return true;
						} else{
							return false;
						}
					}
				}
			},
			paste: function(){ //右键复制
				if(window.clipboardData){ 
					var s = clipboardData.getData("text");
					if(!/\D/.test(s)){
						return true;
					} else { 
						return false;
					}
				} else {
					return false;
				}
			},
			dragenter: function(){ //禁止拖拽
				return false;
			},
			blur: function(){
				var val = this.value;
				if(val.length == 0){
					val = "0";
				}
				$(this).next().val(parseFloat(val.split(',').join(""))); //千分位转换成Float
				this.value = jsUtil.formatDiff(val, 2);
			}
		});
	}
};
$(function(){
	jsUtil.init();
});

function clearDate(inst, isRestrict){ //清空日历
	$(".ui-datepicker-close").click(function(){
		if(inst.val() == '') return false;
		inst.val(''); // 清空

		if(isRestrict){ //互相制约
			var $prevDate = inst.prev(), 
				$nextDate = inst.next();
			if($prevDate.length > 0 ){
				$prevDate.datepicker("option", "maxDate", 0);
			}
			if($nextDate.length > 0){
				$nextDate.datepicker("option", "minDate", null);
			}
		}
	});
}


