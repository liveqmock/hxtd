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
		return (localhostPaht + projectName+"/");
	},
	init:function(){
		var path = jsUtil.getRootPath();
		$('head').append('<link rel="stylesheet" href="'+path+'css/themes/base/jquery.ui.all.css">');
		$.getScript(path+ "js/ui/jquery.ui.core.js");
		$.getScript(path+ "js/ui/jquery.ui.widget.js");
		$.getScript(path+ "js/ui/jquery.ui.mouse.js");
		$.getScript(path+ "js/ui/jquery.ui.draggable.js");
		$.getScript(path+ "js/ui/jquery.ui.position.js");
		$.getScript(path+ "js/ui/jquery.ui.resizable.js");
		$.getScript(path+ "js/ui/jquery.ui.button.js");
		$.getScript(path+ "js/ui/jquery.ui.dialog.js");
		$.getScript(path+ "js/ui/jquery.ui.effect.js");
		$.getScript(path+ "js/ui/jquery.ui.effect-blind.js");
		$('body').append("<div id='dialog' style='display:none;'></div>");
	},
	getDialogConfig:function(title,width,height){
		var config = {
			autoOpen: false,
			modal:true,
			title:'提示',
			show: {
				effect: "blind",
				duration: 400
			},
			hide: {
				effect: "blind",
				duration: 400
			}
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
	alert:function(msg,title,width,height){
		var d = $( "#dialog" );
		d.text(msg);
		var config = jsUtil.getDialogConfig(title,width,height);
		config.buttons={"确定":function(){
				d.dialog( "close" );
			}};
		d.dialog(config);
		d.dialog("open");
	},
	confirm:function(msg,yesFun,title,width,height){
		var d = $( "#dialog" );
		d.text(msg);
		var config = jsUtil.getDialogConfig(title,width,height);
		// if(!yesFun){
		// 	return null;
		// }
		config.buttons={"确定":function(){
				d.dialog( "close" );
				yesFun();
			},"取消":function(){
				d.dialog( "close" );
			}};
		d.dialog(config);
		d.dialog("open");
	},
	datepicker:function(rep){
		$.getScript( "js/ui/jquery.ui.datepicker.js",function(){
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
        $(rep).datepicker();
		});
	},
	easyTree : {
	init:function(data,chileNodeFun){
			var path = jsUtil.getRootPath();
			$('head').append('<link rel="stylesheet" href="'+path+'css/zTreeStyle.css">');
			$.getScript(path+"js/jquery.ztree.core-3.5.js",function(){
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
				$('body').append("<div id='treeDiv' class='ztree' style='background-color:white;position:absolute;border:1px solid #eee;display:none;'><ul id='tree'></ul></div>");
				var t = $("#tree");
			}
			$.fn.zTree.init(t, setting, data);
		});

	},
	show:function(rep){
			var obj = $(rep);
			var Offset = obj.offset();
			$("#treeDiv").css({left:Offset.left + "px",
			 				   top:Offset.top + obj.outerHeight() + "px",
			 				   'z-index':999999}).slideDown("fast");

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