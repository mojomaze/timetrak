// dom available after page load
$(document).ready(function() {
	
	// select actions
	
	$('#action_select_all').click(function() {
		$('input[name=action_id[]]').attr('checked', true);
	});
	
	$('#action_select_none').click(function() {
		$('input[name=action_id[]]').attr('checked', false);
	});
	
	$('#<%= plural_table_name %>_form').bind('ajax:loading', function(xhr){
		$('#<%= plural_table_name %>_form').mask('Loading...');
	});
	
	$('#<%= plural_table_name %>_form').bind('ajax:complete', function(xhr){
		$('#<%= plural_table_name %>_form').unmask();
	});
	
	$('#action_delete').click(function() {
		var n = $("input:checked").length;
		if(n > 0){
			if(confirm('Delete '+n+' items? This cannot be undone!')){
				$('input[name=action_type]').val('delete');
				$('#<%= plural_table_name %>_form').submit();
			}
		}else{
			alert('No selection')
		}
	});
	
	$('tr.list-record').live('mouseover', function() {
		$(this).addClass('over');
	});
	
	$('tr.list-record').live('mouseout', function() {
		$(this).removeClass('over');
	});

	$('td.<%= singular_table_name %>-edit').live('click', function() {
		var id = $(this).parent().attr('id');
		id = id.replace('<%= singular_table_name %>_', '');
		var baseURL = document.domain;
		var basePort = document.location.port;
		baseURL += ':' + basePort;
		document.location = 'http://'+baseURL+'/<%= plural_table_name %>/'+id;
	});
	
});
