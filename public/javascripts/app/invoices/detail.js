$.extend({ 
	addEditListeners: function(){
		$('#invoice_edit_btn').bind('ajax:loading', function(xhr){
			$(this).hide();
			$("#load_edit").show();
		});
		
		//Date Pickers
		$("#invoice_start_date").datepicker({
			dateFormat: 'yy-mm-dd',
			showOn: 'button',
			buttonImage: '/images/calendar.png',
			buttonImageOnly: true
		});
	
		$("#invoice_end_date").datepicker({
			dateFormat: 'yy-mm-dd',
			showOn: 'button',
			buttonImage: '/images/calendar.png',
			buttonImageOnly: true
		});
	},
	addFormListeners: function(){
		$('#invoice_edit_form').bind('ajax:loading', function(xhr){
			var el = xhr.target;
			var id = el.id;
			if(id == 'cancel_edit_item'){
				$('#detail_form_actions').hide();
				$('#load_cancel').show();
			} else {
				$('#detail_form_actions').hide();
				$('#load_save').show();
			}
		});
		// Date Pickers
		$("#invoice_start_date").datepicker({
			dateFormat: 'yy-mm-dd',
			showOn: 'button',
			buttonImage: '/images/calendar.png',
			buttonImageOnly: true
		});
		
		$("#invoice_end_date").datepicker({
			dateFormat: 'yy-mm-dd',
			showOn: 'button',
			buttonImage: '/images/calendar.png',
			buttonImageOnly: true
		});
	}
});

// dom available after page load
$(document).ready(function() {
	$('#close_errors').live('click', function(e){
		$('#errors').html('');
		e.preventDefault();
	});
	
	$.addFormListeners();
	$.addEditListeners();
	
});