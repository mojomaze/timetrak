// dom available after page load
$(document).ready(function() {
	
	// select actions
	
	$('#action_select_all').click(function() {
		$('input[name=action_id[]]').attr('checked', true);
	});
	
	$('#action_select_none').click(function() {
		$('input[name=action_id[]]').attr('checked', false);
	});
	
	$('#invoices_form').bind('ajax:loading', function(xhr){
		$('#invoices_form').mask('Loading...');
	});
	
	$('#invoices_form').bind('ajax:complete', function(xhr){
		$('#invoices_form').unmask();
	});
	
	$('#action_delete').click(function() {
		var n = $("input:checked").length;
		if(n > 0){
			if(confirm('Delete '+n+' items? This cannot be undone!')){
				$('input[name=action_type]').val('delete');
				$('#invoices_form').submit();
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

	$('td.invoice-edit').live('click', function() {
		var id = $(this).parent().attr('id');
		id = id.replace('invoice_', '');
		var baseURL = document.domain;
		var basePort = document.location.port;
		baseURL += ':' + basePort;
		document.location = 'http://'+baseURL+'/invoices/'+id;
	});
	
});
