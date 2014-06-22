var RcmsAjax = {};

RcmsAjax.global = {
	timer: 0,
	pointDiv : '',
	showTime : 2000
}
// 通过ready函数缓冲加载
$(function(){
	//判断页面是否有所需的div
	//如果没有，追加一个到body的底部
	var div = $('#point4Ajax');
	if(div.length <= 0){
		$('body').append('<div id="point4Ajax" style="padding:5px;position: fixed;z-index:101;top:40%;left:0;border-radius:4px;-moz-border-radius:4px;-webkit-border-radius:4px;-o-border-radius:4px; display:block;"></div>');
	}
	RcmsAjax.global.pointDiv = $('#point4Ajax', window.top.document);
});


RcmsAjax.bgColor = {
	start : '#FDBB74',
	success : '#A6E290',
	error : '#FB6542'
}

RcmsAjax.bgImage = {
	start : 'wite.jpg.gif',
	success : 'wite_right.png',
	error : 'wite_fulse.png'
}

RcmsAjax.msgDiv = {
	begin : '<div class="zzc"><img width="50" height="51" class="fl mt20 ml10" src="'+jsUtil.getRootPath()+'/static/images/',
	middle : '" /><p class="fr mr35 mt40">',
	end : '</p></div>'
}



RcmsAjax.msg = {
	start : '数据请求中......',
	success : '数据请求成功！',
	error : '数据请求失败！'
}

// ajax的全局属性控制
$.ajaxSetup({
	cache:false // 清除缓存
});

/**
 * 没有提示消息的ajax
 * @param {Object} _url
 * @param {Object} _successCallBack
 * @param {Object} _params
 * @param {Object} _errorCallBack
 * @param {Object} _type
 */
RcmsAjax.ajaxNoMsg = function(_url, _successCallBack, _completeCallback, _params, _errorCallBack, _type){
	RcmsAjax._ajax(false, _url, _successCallBack, _completeCallback, _params, _errorCallBack, _type);
}

/**
 * RcmsAjax.ajax实现
 * @param {Object} _url
 * @param {Object} _successCallBack
 * @param {Object} _params
 * @param {Object} _errorCallBack
 * @param {Object} _type
 * @param {Object} _beforeMsg
 * @param {Object} _errorMsg
 */
RcmsAjax.ajax =  function (_url, _successCallBack,  _completeCallback, _params, _errorCallBack, _type, _beforeMsg, _errorMsg){
	RcmsAjax._ajax(true, _url, _successCallBack, _completeCallback, _params, _errorCallBack, _type, _beforeMsg, _errorMsg);
}
/**
 * RcmsAjax.ajax实现
 * @param {Object} _url
 * @param {Object} _successCallBack
 * @param {Object} _params
 * @param {Object} _errorCallBack
 * @param {Object} _type
 * @param {Object} _beforeMsg
 * @param {Object} _errorMsg
 */
RcmsAjax._ajax =  function (_excuteMsgFlag, _url, _successCallBack, _completeCallback, _params, _errorCallBack, _type, _beforeMsg, _errorMsg){
	if (!_type) {
		_type = 'post';
	}
	if (!_beforeMsg) {
		_beforeMsg = RcmsAjax.msg.start;
	}
	if (!_errorMsg) {
		_errorMsg = RcmsAjax.msg.error;
	}
	$.ajax({
		url: encodeURI(_url),
		beforeSend: function(){
			if (_excuteMsgFlag) {
				_beforeSend4Msg(_beforeMsg);
			}
		},
		dataType: "json",
		type: _type,
		data: _params,
		processData: false,
		headers: {
            "Access-Control-Allow-Headers":"X-Requested-With"
        },
		success: function(result){
			if(result){
				if(result.sessionIsTimeOut){
					if (_excuteMsgFlag) {
						showMsg(result);
					}
					window.focus();
					return false;
				}
				if (_excuteMsgFlag) {
					showMsg(result);
				}
				if(result.successFlag){
					if(_successCallBack){
						_successCallBack(result);
					}
				}
			}
		},
		error: function(result){
			if(result){
				if(result.sessionIsTimeOut){
					if (_excuteMsgFlag) {
						showMsg(result);
					}
					window.focus();
//					alert("您太长时间没有操作，请重新登录!");
					return false;
				}
				if (_excuteMsgFlag) {
					_error4Msg(_errorMsg);
				}
				if(_errorCallBack){
					_errorCallBack(result);
				}
			}
		},
		complete: function(XMLHttpRequest, textStatus){
			_stop();
			if(_completeCallback){
				_completeCallback();
			}
		}
	});
};

/**
 * 成功时执行回调函,失败是则不执行
 * @param {Object} data
 * @param {Object} _successCallBack
 */
function showMsg(data){
	var _successflag = data.successFlag;
	var _message = data.message;
	_showMsg(_getPointDivHtmlByStatusMsg(_successflag, _message));
}

/**
 * @param {Object} _beforeMsg
 * @memberOf {TypeName} 
 */
function _beforeSend4Msg(_beforeMsg){
	_showProcessMsg(_getPointDivHtmlByStatusMsg(null, _beforeMsg, true));
}

/**
 * ajax停止时恢复button
 * @memberOf {TypeName} 
 */
function _stop(){
	clearTimeout(RcmsAjax.global.timer);
	RcmsAjax.global.timer = setTimeout(_hide(),RcmsAjax.global.showTime);
}

/**
 * ajax请求错误
 * @param {Object} _errorMsg
 */
function _error4Msg(_errorMsg){
	_showMsgByTime(_getPointDivHtmlByStatusMsg(false, _errorMsg));
}

/**
 * ajax请求中
 * @param {Object} _errorMsg
 */
function _start4Msg(_startMsg){
	if(!_startMsg){
		_startMsg = RcmsAjax.msg.start;
	}
	_showMsgByTime(_getPointDivHtmlByStatusMsg(null, _startMsg, true));
}

/**
 * ajax请求成功
 * @param {Object} _errorMsg
 */
function _success4Msg(_successMsg){
	if(!_successMsg){
		_successMsg = RcmsAjax.msg.success;
	}
	_showMsgByTime(_getPointDivHtmlByStatusMsg(true, _successMsg));
}

/**
 * 显示加载或提交过程中的msg(如:数据加载(提交)中)
 * @param {Object} msg
 */
function _showProcessMsg(msg){
	RcmsAjax.global.pointDiv.html(msg);
	var leftPos = (window.top.document.documentElement.clientWidth-RcmsAjax.global.pointDiv.width())/2;
	RcmsAjax.global.pointDiv.css({ "left":leftPos}).slideDown('fast');
}

/**
 * 显示消息
 * @param {Object} msg
 * @param {Object} bgcolor
 */
function _showMsg(msg){
	_showMsgByTime(msg);
}

/**
 * 通过时长、颜色来显示对应的消息(传null 或'' 则表示用全局showTime)
 * @param {Object} _color
 * @param {Object} msg
 * @param {Object} showTime
 */
function _showMsgByTime(msg, _showTime, _speed){
	RcmsAjax.global.pointDiv.html(msg);
	if(!_showTime){
		_showTime = RcmsAjax.global.showTime;
	}
	var leftPos = (window.top.document.documentElement.clientWidth-RcmsAjax.global.pointDiv.width())/2;
	RcmsAjax.global.pointDiv.css({ "left":leftPos}).slideDown('normal');
}


function _hide(speed){
	return function(){
		if(!speed){
			speed = 'normal';
		}
		RcmsAjax.global.pointDiv.slideUp(speed);
	}
}

function _getPointDivHtmlByStatusMsg(_successflag, _message, _isStart){
	var msgDivImage = '';
	if(_isStart){
		if(_message){
			msgDivImage = RcmsAjax.bgImage.start;
		}
		_message = RcmsAjax.msg.start;
	}else{
		if(_successflag){
			msgDivImage = RcmsAjax.bgImage.success;
			if(!_message){
				_message = RcmsAjax.msg.success;
			}
		}else{
			msgDivImage = RcmsAjax.bgImage.error;
			if(!_message){
				_message = RcmsAjax.msg.error;
			}
		}
	}
	
	return RcmsAjax.msgDiv.begin + msgDivImage + RcmsAjax.msgDiv.middle + _message + RcmsAjax.msgDiv.end;
}