$(function() {
	$('#videoPlayer').flashembed(
	{
	  src: '/swf/player.swf',
	  width: 470,
	  height: 384,
		wmode: "transparent"
	},
	{
	  config: {
	    videoFile: '/flv/trailer.flv',
	    splashImageFile: '/images/trailer_splash.jpg',
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