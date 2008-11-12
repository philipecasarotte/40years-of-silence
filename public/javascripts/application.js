$(function(){
	// PNG
	$('img').ifixpng();
	//Menu Hover
	$("#menu li, #menuLeft li").find("img:first").each(function(){
		var _loader = new Image();
		$(_loader).attr("src", $(this).attr("src").replace(".gif", "_on.gif"));
	});
	$("#menu li, #menuLeft li").find("img:first").hover(
		function(){$(this).attr("src", $(this).attr("src").replace(".gif", "_on.gif"));},
		function(){$(this).attr("src", $(this).attr("src").replace("_on", ""));}
	);
	// Flash
	$('#flash').flash({
	    src: '/swf/flame.swf',
	    width: 100,
	    height: 165,
	    wmode: "transparent"
	});
});