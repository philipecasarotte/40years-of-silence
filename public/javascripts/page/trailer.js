$(function() {
      $('#videoPlayer').flashembed({
        src: '/swf/player.swf',
        //width: 482,
        //height: 364+28
        width: 610,
        height: 460+28
      }, {
        config: {
          videoFile: '/flv/trailer.flv',
          splashImageFile: '/images/trailer_splash.jpg',
          controlBarBackground: 0x000000,
          initialScale: 'fill',
          initialVolumePercentage: 100,
          loop: false,
          menuItems: [true, true, true, true, true, false],
          autoPlay: true,
          autoBuffering: true,
        }
      })
});