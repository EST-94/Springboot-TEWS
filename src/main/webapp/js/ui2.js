
// jquery
$(function(){
	lnb2(); // lnb control
});

var lnb2 = function()
{
	$(".left_navigation > li > a").click(function(){
		$(".left_navigation > li.on > ul").toggle();
		$(".left_navigation > li.on").toggleClass("on");
		
		//$(".left_navigation > li").removeClass("on");
		$(this).parent().toggleClass("on");
		$(".left_navigation > li.on > ul").toggle();
		return false;
	});
};