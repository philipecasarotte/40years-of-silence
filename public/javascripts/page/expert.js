$(function() { 
	$("#sub_nav td a").click(function() {
		$(".content_cms").empty();
		$.get("/page/body/"+$(this).attr("href").replace("#", ""), function(text){
		 $(".content_cms").html(text);
		});
		return false;
	});
});