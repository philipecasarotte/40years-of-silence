$(function() {
  $('#videoPlayer').flashembed({
    src: '/swf/player.swf',
    width: 594,
    height: 334+28
  }, {
    config: {
      videoFile: '/flv/directors_statements.flv',
      splashImageFile: '/images/directors_statements.jpg',
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