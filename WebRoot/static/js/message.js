//首先定义一个命名空间window.message ,如果页面已经有window.message这个命名空间了,那么就直接调用.如果没有,就创建一个新的
window.message = window.message||{};

//定义这个页面的属性,rootPath是这个页面的属性,jsUtil.getRootPath()是属性的值,但是一个变量.从其他jquery页面取得.获得的是页面的绝对路径
message.setting={
	rootPath:jsUtil.getRootPath()
};
//初始化message.在页面的底部自动调用init()方法,初始化执行.
message.init=function(){
	message._requestAjax();
	setInterval(message._refreshAjax, 10*60*1000);
};

/*
 * 这里定义了一个函数.这个函数就相当于function requestMessageAjax(){}方法,
 * 当在jquery中为方便其他对象调用.定义成requestMessageAjax = function (data){}形式
 * 其中每一个变量名前都要加上message,表示是message这个js类的属性
 */
message._requestMessageAjax = function (data){
 		   var messageSize = data.result.result.length;
 		    /*
			 * 如果数据库中查询出未读消息数>0,则显示带红点的图标,否则显示不带红点的图标
			 */
		   if(messageSize>0){
		   		$("#message").removeClass().addClass("head_news1 globle_img fl");
	   		}else{
	   			$("#message").removeClass().addClass("head_news globle_img fl");
	   		}
	   		var messages=eval(data.result.result);
	   		var ss='<li>系统消息：</li>';
	   		var len=messages.length>3?3:messages.length;
	   		if(len==0){
	   			ss+='<li>无新消息</li>';
	   		}else{
	   		for(var i=0;i<len;i++){
	           ss+='<li><c:if test=\"${VS_HAS_FUNCTIONS.messageView}\"><a href=\"'+message.setting.rootPath+'/system/message/toViewPage.do?id='+messages[i].id+'\">'+messages[i].message.title+'</a></c:if></li>';
	   		}
	   		}
	   		$("#messages").html(ss);
};

/**
 * 这个是ajax的返回值处理
 * @param {Object} data
 */
message._requestNoticeAjax=function (data){
		var noticeSize = data.result.result.length;
		/*
		 * 如果数据库中查询出未读消息数>0,则显示带红点的图标,否则显示不带红点的图标
		 */
		if(noticeSize>0){
			$("#notice").removeClass().addClass("head_system1 globle_img fl mr15");
		}else{
			$("#notice").removeClass().addClass("head_system globle_img fl mr15");
		}
		var notices=eval(data.result.result);
		var ss='';
		if(notices.length>0){
		      ss+='<li><c:if test=\"${VS_HAS_FUNCTIONS.noticeView}\"><a href=\"'+message.setting.rootPath+'/system/notice/toViewPage.do?id='+notices[0].id+'\">'+notices[0].title+'</a></c:if></li>';
		}else{
			ss+='<li>无公告</li>';
		}
		$("#notices").html(ss);
};

/*
 * 在这里调用调用了其他属性,则直接调用,如 message._requestMessageAjax
 */
message._requestAjax=function (){
	   RcmsAjax.ajaxNoMsg (message.setting.rootPath+"/system/message/query.do?search_EQ_status=0&type=recived",message._requestMessageAjax);
	   RcmsAjax.ajaxNoMsg (message.setting.rootPath+"/system/notice/query.do?type=sended&orderBy=sentTime&order=desc",message._requestNoticeAjax);
};

/*
 * 当调用该js的页面,自动初始化该页面.即执行init()中的方法
 */
$(function(){
	message.init();
});