/********开启事件计划*************/
set global event_scheduler = 1;

/**
 *description:为市场活动负责人发送信息提醒
 *author:lihua
 *date:2014-07-24
*/
drop procedure if exists proc_marketactivity_sendmsg;
create procedure proc_marketactivity_sendmsg()
begin
		/****************申明临时表*****************/
		create temporary table tmp_msg(id int auto_increment primary key, `ma_id` int(10), `userid` int(10), `title` varchar(100), 
				`content` varchar(500), `creatorid` int(10), `createtime` datetime, `modifierid` int(10));
		
		insert into tmp_msg(ma_id, userid, title, content, creatorid, createtime, modifierid)
		select id, bosshead, '系统提醒信息', concat(`NAME`,'，该市场活动已到举办时间，发送提醒消息！'), '1', sysdate(), '1'  
			from market_activity where begin_date=date_format(sysdate(),'%Y-%m-%d') and is_deleted = 0 and is_send = 0;

		/****************获取当前消息最大主键值*****/
		select @num:=ifnull(max(id),0) from sysmessage;

		/****************新增提示信息***************/
		insert into sysmessage(id, title, content, creator_id, created_time, modifier_id)
		select id+@num, title, content, creatorid, createtime, modifierid
			from tmp_msg;

		/****************发送给负责人***************/
		insert into user_message(message_id, user_id, `status`, type, is_deleted, created_time) 
			select id+@num, userid, '0', '1', '0', sysdate() from tmp_msg;

		/****************更新活动已发消息***********/
		update market_activity set is_send = 1 where id in (select ma_id from tmp_msg);

		drop table tmp_msg;
end;

/*********创建事件****************/
drop event if exists hxtd.msg_task;
create event hxtd.msg_task
on schedule every 60 second
on completion preserve
do call proc_marketactivity_sendmsg();