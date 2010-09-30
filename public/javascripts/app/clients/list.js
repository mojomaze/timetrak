// dom available after page load
$(document).ready(function() {
	
	// select actions
	
	$('#action_select_all').click(function() {
		$('input[name=action_id[]]').attr('checked', true);
	});
	
	$('#action_select_none').click(function() {
		$('input[name=action_id[]]').attr('checked', false);
	});
	
	$('#clients_form').bind('ajax:loading', function(xhr){
		$('#clients_form').mask('Loading...');
	});
	
	$('#clients_form').bind('ajax:complete', function(xhr){
		$('#clients_form').unmask();
	});
	
	$('#action_delete').click(function() {
		var n = $("input:checked").length;
		if(n > 0){
			if(confirm('Delete '+n+' items? This cannot be undone!')){
				$('input[name=action_type]').val('delete');
				$('#clients_form').submit();
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

	$('td.client-edit').live('click', function() {
		var id = $(this).parent().attr('id');
		id = id.replace('client_', '');
		var baseURL = document.domain;
		var basePort = document.location.port;
		baseURL += ':' + basePort;
		document.location = 'http://'+baseURL+'/clients/'+id;
	});
	
});
