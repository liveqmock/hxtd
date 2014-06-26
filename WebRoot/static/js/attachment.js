var attachment = {};

attachment.init=function(setting){
	if(setting){
		attachment.setting = setting;
		window.uploadURL = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/upload.do";
	}
};

attachment.query=function(){
		var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/query.do";
		RcmsAjax.ajaxNoMsg(url,attachment.array2Html,function(){return;},'id='+attachment.setting.id);
};

attachment.view=function(id){
		var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/view.comp";
		jsUtil.dialogIframe(url+"?id="+id,"预览",500,600,null);
};

attachment.download=function(id){
	var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/download.do";
	window.location.href= url+"?id="+id;
};

attachment.deleteAtt=function(id){
	var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/delete.do";
	jsUtil.confirm("是否删除附件？",function(){
		RcmsAjax.ajax(url,attachment.query,function(){return;},'id='+id);
	},"警告")
};
attachment.array2Html=function(result){
	var list = result.result.list;
	if(!list||list.length==0){
		$("#attBody").html('<tr><td colspan="5" align="center"><div class="allnone"></div></td></tr>');
		return false;
	}
	var table = new Array();
	for(var i=0;i<list.length;i++){
		var att = list[i];
		table.push('<tr><td  align="center">'+att.name+'</td>');
		table.push('<td align="center">'+att.dict.key+'</td>');
		table.push('<td align="center">'+att.createdTime+'</td>');
		table.push('<td align="center">' );
		if(attachment.setting.down){
			table.push('<a href="javascript:attachment.download('+att.id+');" class=" block_inline s_download globle_img""></a>' );
		}
		table.push('&nbsp');
		if(attachment.setting.view){
			table.push('<a href="javascript:attachment.view('+att.id+');" class="block_inline block s_preview globle_img ml10"></a>');
		}
		if(attachment.setting.deleteF){
			table.push('<a href="javascript:attachment.deleteAtt('+att.id+');" class="block_inline s_dump_btn globle_img ml10"></a>');
		}
		table.push('</td></tr>')
	}	
	$("#attBody").html(table.join(''));
};
attachment.upload=function(){
		var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/upload.comp";
		jsUtil.dialogIframe(url,"文件上传",500,600,null,attachment.query)
};