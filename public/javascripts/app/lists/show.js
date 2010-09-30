$(document).ready(function() {
	// make the list values sortable
	$('#values-list').sortable({
	  axis: 'y', 
	  dropOnEmpty:false, 
	  handle: '.handle', 
	  cursor: 'crosshair',
	  items: 'tr',
	  opacity: 0.4,
	  scroll: true,
	  update: function(){
	    $.ajax({
	        type: 'post', 
	        data: $('#values-list').sortable('serialize'), 
	        dataType: 'script', 
	        complete: function(request){
	            $('#values-list').effect('highlight');
	          },
	        url: '/list_values/sort'})
	    }
	});
	
	$('#show-add-item').bind('click', function(){
		$(this).hide();
		document.forms['new_list_value'].reset();
		$('#add-item').show('blind');
		return false;
	});
	
	$('#cancel-add-item').bind('click', function(){
		$('#add-item').hide();
		$('#show-add-item').show();
		$('#errors').html("");
		clearFormErrors();
		document.forms['new_list_value'].reset();
		return false;
	});
	
	function clearFormErrors(){
		$('.fieldWithErrors').each(function(i) {
			$(this).children().first().unwrap();
		});
	};
	
	// handle remote form events
	// $('#new_list_value').bind('ajax:sucess', function(event, data, status, xhr){
	// 		alert('succes');
	// 	});
	// 	
	// 	$('#new_list_value').bind('ajax:failure', function(event, data, status, error){
	// 		alert(error);
	// 	});
	
});