var attachment = {};

attachment.init=function(setting){
	if(setting){
		attachment.setting = setting;
		/*
		 * 作用是给子页面传递公用参数.
		 * @return {TypeName} 
		 */
		window.uploadURL = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/upload.do";
	}
};

attachment.query=function(){
		var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/query.do";
		RcmsAjax.ajaxNoMsg(url,attachment.array2Html,function(){return;},'id='+attachment.setting.id);
};

/**
 * 预览--预览具体某一个附件的详细内容
 * @param {Object} id
 */
attachment.view=function(id){
		var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/view.comp";
		jsUtil.dialogIframe(url+"?id="+id,"预览",500,600,null);
};
/**
 * 搜open和href的区别
 * todo  herf 改 open
 * @param {Object} id
 */
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
/**
 * 生成附件列表
 * @param {Object} result
 * @return {TypeName} 
 */
attachment.array2Html=function(result){
	var list = result.result.list;
	if(!list||list.length==0){
		$("#attBody").html('<tr><td colspan="5" align="center"><div class="allnone"></div></td></tr>');
		return false;
	}
	var table = new Array();
	for(var i=0;i<list.length;i++){
		var att = list[i];
		var fileName = att.name;//文件名
		//获取文件的扩展名
		var extName = fileName.substr((fileName.lastIndexOf(".")+1));
		table.push('<tr><td  align="center">'+att.name+'</td>');
		table.push('<td align="center">'+att.type.key+'</td>');
		table.push('<td align="center">'+att.createdTime+'</td>');
		table.push('<td align="center">' );
		if(attachment.setting.down){
			table.push('<a href="javascript:attachment.download('+att.id+');" class=" block_inline s_download globle_img""></a>' );
		}
		table.push('&nbsp');
		if(attachment.setting.deleteF){
			table.push('<a href="javascript:attachment.deleteAtt('+att.id+');" class="block_inline s_dump_btn globle_img ml10"></a>');
		}
		if(attachment.setting.view){
			if("jpg,png,fig".indexOf(extName)!=-1){
				table.push('<a href="javascript:attachment.view('+att.id+');" class="block_inline block s_preview globle_img ml10"></a>');
			}else{
				table.push('<div class="block_inline block s_preview ml10" style="cursor:default;"></div>');
			}
		}
		table.push('</td></tr>')
	}	
	$("#attBody").html(table.join(''));
};
attachment.upload=function(){
		var url = jsUtil.getRootPath()+"/"+attachment.setting.module+"/attachment/upload.comp";
		jsUtil.dialogIframe(url,"文件上传",500,600,null,attachment.query)
};