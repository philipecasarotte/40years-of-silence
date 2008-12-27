$(function(){
	// PNG
	$('img').ifixpng();

	// Flash
	$('#flash').flash({
	    src: '/swf/flame.swf',
	    width: 100,
	    height: 165,
	    wmode: "transparent"
	});
	
	// menu
	$("#menu li").hover(function() {
		$(this).addClass("hover").find("ul").show();
	}, function() {
		$(this).removeClass("hover").find("ul").hide();
	});
});

function set_menu (permalink) {
	$("#menu_"+permalink).parent().addClass("selected");
}