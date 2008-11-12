$(function(){
	//Menu Hover
	$('#menuLeft ul li ul').not('.opened').hide();	 
	$('#menuLeft ul li a').click(function() {
		var checkElement = $(this).next();		  
		if((checkElement.is('ul')) && (checkElement.is(':visible'))) {	 			
			return false; 
		}
		if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {	 
			$('#menuLeft ul li ul:visible').hide();	 
			checkElement.show();			 
			return false;
		}
	});
	$('#menuLeft ul li a').dblclick(function(){
		location.href = $(this).attr("href");
	});
});