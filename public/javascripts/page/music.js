$(function() {
  	$('#player').flash({
		src: '/swf/music.swf',
		height: 20, 
		width: 250,
		flashvars: {
			file: '/mp3/movietrack.mp3',
			displayheight:20,
			autostart:'false',
			smoothing:'true',
		}
	},
		{version: '7.0.19.0'}
	);
});