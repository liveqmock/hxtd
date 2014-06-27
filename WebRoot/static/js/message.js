window.message = window.message||{};

message.setting={
	rootPath:jsUtil.getRootPath()
};

message.init=function(){
	message._requestAjax();
	setInterval(message._refreshAjax, 10*60*1000);
};

message._requestMessageAjax = function (data){
 		   var messageSize = data.result.result.length;
		   if(messageSize>0){
		   		$("#message").removeClass().addClass("head_news1 globle_img fl");
	   		}else{
	   			$("#message").removeClass().addClass("head_news globle_img fl");
	   		}
	   		var messages=eval(data.result.result);
	   		var ss='<li>系统消息：</li>';
	   		var len=messages.length>3?3:messages.length;
	   		for(var i=0;i<len;i++){
	           ss+='<li><a href=\"'+message.setting.rootPath+'/system/message/toViewPage.do?id='+messages[i].id+'\">'+messages[i].message.title+'</a></li>';
	   		}
	   		$("#messages").html(ss);
};

message._requestNoticeAjax=function (data){
		var noticeSize = data.result.result.length;
		if(noticeSize>0){
			$("#notice").removeClass().addClass("head_system1 globle_img fl mr15");
		}else{
			$("#notice").removeClass().addClass("head_system globle_img fl mr15");
		}
		var notices=eval(data.result.result);
		var ss='<li>公告：</li>';
		if(notices.length>0){
		      ss+='<li><a href=\"'+message.setting.rootPath+'/system/notice/toViewPage.do?id='+notices[0].id+'\">'+notices[0].title+'</a></li>';
			$("#notices").html(ss);
		}
};

message._requestAjax=function (){
	   RcmsAjax.ajaxNoMsg (message.setting.rootPath+"/system/message/query.do?search_EQ_status=0&type=recived",message._requestMessageAjax);
	   RcmsAjax.ajaxNoMsg (message.setting.rootPath+"/system/notice/query.do",message._requestNoticeAjax);
};

$(function(){
	message.init();
});