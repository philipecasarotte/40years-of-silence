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
	
	show_video("character_selects");
});

function show_video (name) {
	$('#videoPlayer').flashembed(
	{
	  src: '/swf/player.swf',
	  width: 648,
	  height: 460,
		wmode: "transparent"
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