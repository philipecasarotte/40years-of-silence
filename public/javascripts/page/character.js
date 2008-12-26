$(function() { 
	$("#sub_nav td a").click(function() {
		$(".content_cms").empty();
		var permalink = $(this).attr("href").replace("#", "")
		show_video(permalink);
		$.get("/page/body/"+permalink, function(text){
		 $(".content_cms").html(text);
		});
		return false;
	});
});

function show_video (name) {
	$('#videoPlayer').flashembed(
	{
	  src: '/swf/player.swf',
	  width: 483,
	  height: 365
	},
	{
	  config: {
	    videoFile: '/flv/' + name + '.flv',
	    controlBarBackground: 0x000000,
	    initialScale: 'fill',
	    initialVolumePercentage: 100,
	    loop: false,
	    menuItems: [true, true, true, true, true, false],
	    autoPlay: true,
	    autoBuffering: true
	  }
	});
}