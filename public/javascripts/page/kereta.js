$(function() {
      $('#videoPlayer').flashembed({
        src: '/swf/player.swf',
        width: 470,
        height: 360+28
      }, {
        config: {
          videoFile: '/flv/kereta.flv',
          controlBarBackground: 0x000000,
          initialScale: 'orig',
          initialVolumePercentage: 100,
          loop: false,
          menuItems: [true, true, true, true, true, false],
          autoPlay: true,
          autoBuffering: true,
        }
      })
});