$(document).ready(function(){
	// carousel
	$("#sub_nav .list").jCarouselLite({
		btnNext: ".next",
		btnPrev: ".prev",
		vertical: true,
		visible: 4,
		circular: true,
		scroll: 4,
		speed: 500
	});	
});