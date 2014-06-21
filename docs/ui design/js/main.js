
$(function(){
	$("#side_switch").click(function(){
		$(".left").hide();
		$(".right").css('width','100%');
		$(this).hide();
		$("#side_switchl").show();
	})
})
$(function(){
	$("#side_switchl").click(function(){
		$(".left").show();
		$(".right").css('width','82%');
		$(this).hide();
		$("#side_switch").show();
	})
})