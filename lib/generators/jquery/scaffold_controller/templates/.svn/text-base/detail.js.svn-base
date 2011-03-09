$.extend({ 
	addEditListeners: function(){
		$('#<%= singular_table_name %>_edit_btn').bind('ajax:loading', function(xhr){
			$(this).hide();
			$("#load_edit").show();
		});
	},
	addFormListeners: function(){
		$('#<%= singular_table_name %>_edit_form').bind('ajax:loading', function(xhr){
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