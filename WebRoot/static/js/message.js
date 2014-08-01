var HXTD_CRM_MSG = {}; 

//首先定义一个命名空间window.message ,如果页面已经有window.message这个命名空间了,那么就直接调用.如果没有,就创建一个新的
HXTD_CRM_MSG.message = {};
//定义这个页面的属性,rootPath是这个页面的属性,jsUtil.getRootPath()是属性的值,但是一个变量.从其他jquery页面取得.获得的是页面的绝对路径
HXTD_CRM_MSG.message.setting={
	rootPath:jsUtil.getRootPath()
};
//初始化message.在页面的底部自动调用init()方法,初始化执行.
HXTD_CRM_MSG.message.init=function(){
	HXTD_CRM_MSG.message._requestAjax();
	setInterval(message._refreshAjax, 10*60*1000);
};

/*
 * 这里定义了一个函数.这个函数就相当于function requestMessageAjax(){}方法,
 * 当在jquery中为方便其他对象调用.定义成requestMessageAjax = function (data){}形式
 * 其中每一个变量名前都要加上message,表示是message这个js类的属性
 */
HXTD_CRM_MSG.message._requestMessageAjax = function (data){
		var messageSize = data.result.result.length;
		/*
	 	* 如果数据库中查询出未读消息数>0,则显示带红点的图标,否则显示不带红点的图标
 		*/
		if(messageSize>0){
			$("#message").removeClass("head_news").addClass("head_news1");
   		}else{
   			$("#message").removeClass("head_news1").addClass("head_news");
   		}
	    var ss=$("#message").val();
   		var messages=eval(data.result.result);
   		var len=messages.length>3?3:messages.length;
   		if(len==0){
   			ss='<li>暂无系统消息</li>';
   		}else{
   		    ss='<li>系统消息：</li>';
   		for(var i=0;i<len;i++){
            ss+='<li><c:if test=\"${VS_HAS_FUNCTIONS.messageView}\"><a href=\"'+HXTD_CRM_MSG.message.setting.rootPath+'/system/message/toViewPage.do?id='+messages[i].id+'\">'+messages[i].message.title+'</a></c:if></li>';
   		}
   		}
   		$("#messages").html(ss);
};

/**
 * 这个是ajax的返回值处理
 * @param {Object} data
 */
HXTD_CRM_MSG.message._requestNoticeAjax=function (data){
		var noticeSize = data.result.result.length;
		/*
		 * 如果数据库中查询出未读消息数>0,则显示带红点的图标,否则显示不带红点的图标
		 */
		if(noticeSize>0){
			$("#notice").removeClass("head_system").addClass("head_system1");
   		}else{
   			$("#notice").removeClass("head_system1").addClass("head_system");
   		}
		var notices=eval(data.result.result);
		var ss=$("#notice").val();
		if(notices.length>0){
			  ss='<li>系统公告：</li>';
		      ss+='<li><c:if test=\"${VS_HAS_FUNCTIONS.noticeView}\"><a href=\"'+HXTD_CRM_MSG.message.setting.rootPath+'/system/notice/toViewPage.do?id='+notices[0].id+'\">'+notices[0].title+'</a></c:if></li>';
		}else{
			  ss='<li>暂无系统公告</li>';
		}
		$("#notices").html(ss);
};

/*
 * 在这里调用调用了其他属性,则直接调用,如 message._requestMessageAjax
 */
HXTD_CRM_MSG.message._requestAjax=function (){
	   RcmsAjax.ajaxNoMsg (HXTD_CRM_MSG.message.setting.rootPath+"/system/message/query.do?search_EQ_status=0&type=recived",HXTD_CRM_MSG.message._requestMessageAjax);
	   RcmsAjax.ajaxNoMsg (HXTD_CRM_MSG.message.setting.rootPath+"/system/notice/query.do?type=sended&orderBy=sentTime&order=desc",HXTD_CRM_MSG.message._requestNoticeAjax);
};

/*
 * 当调用该js的页面,自动初始化该页面.即执行init()中的方法
 */
$(function(){
	HXTD_CRM_MSG.message.init();
});