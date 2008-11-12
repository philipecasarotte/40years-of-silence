$(document).ready(function(){
	// Change Image
	$("#galleryMenu ul li").find("a").click(function(){
		var loader = $(".loading");
		var newImage = $(this).attr('href');
		var bigImage = $('#big');
		$.ajax({
		  type:"GET",
		  url: '/photos/'+$(this).attr('class'),
		  success:function(data){
		  	loader.hide();
				bigImage.attr('src', data);
		  },
		  complete: function(){
		  	loader.hide();
		  },
		  beforeSend: function(){
			loader.show();
		  }
		});
		return false;
	});
});