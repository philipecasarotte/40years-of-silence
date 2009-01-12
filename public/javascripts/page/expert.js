$(function() { 
	$("#sub_nav td a").click(function() {
		$(".content_cms").empty();
		var permalink = $(this).attr("href").replace("#", "");
		show_video(permalink.replace("-", "_"));
		$.get("/page/body/"+permalink, function(text){
		 $(".content_cms").html(text);
		});
		return false;
	});
	
	$('#videoPlayer').flashembed(
	{
	  src: '/swf/player.swf',
	  width: 648,
	  height: 480
	},
	{
	  config: {
	    videoFile: '/flv/historian_selects2.flv',
	    controlBarBackground: 0x000000,
	    initialScale: 'fill',
	    initialVolumePercentage: 100,
	    loop: false,
	    menuItems: [true, true, true, true, true, false],
	    autoPlay: true,
	    autoBuffering: true
	  }
	});
});

function show_video (name) {
	$('#videoPlayer').flashembed(
	{
	  src: '/swf/player.swf',
	  width: 648,
	  height: 480
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