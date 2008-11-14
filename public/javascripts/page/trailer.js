$(function() {
      $('#videoPlayer').flashembed({
        src: '/swf/player.swf',
        width: 482,
        height: 364+28
      }, {
        config: {
          videoFile: '/flv/trailer.flv',
          splashImageFile: '/images/trailer_splash.jpg',
          controlBarBackground: 0x000000,
          initialScale: 'orig',
          initialVolumePercentage: 100,
          loop: false,
          menuItems: [true, true, true, true, true, false],
          autoPlay: false,
          autoBuffering: true,
        }
      })
});