$.extend({ 
	addFormControls: function(){ 
		// Auto Complete for action form
		$("#activity_project_number").autocomplete({
			source: "/projects",
			minLength: 0,
			select: function(event, ui) {
				if(ui.item){
					$("#activity_project_id").val(ui.item.id);
				}
			}
		});
		// Date Picker
		$("#activity_date").datepicker({
			dateFormat: 'yy-mm-dd',
			showOn: 'button',
			buttonImage: '/images/calendar.png',
			buttonImageOnly: true
		});

		// Time Entry
		$('#activity_start_time').timeEntry({spinnerImage: '', ampmPrefix: ' '});
		$('#activity_end_time').timeEntry({spinnerImage: '', ampmPrefix: ' '});
	},
	toggleFormControls: function(state){
		// clear form errors since we're changing input state
		$.clearEntryErrors();
		var default_project_id = $("#default_project_id").val();
		
		switch(state){
			case 'hide':
			// adding in-line edit so disable create form
			document.forms['new_activity'].reset();
			$(".ui-datepicker-trigger").hide();
			$(":input").each(function(i) {
			  $(this).attr('disabled', true);
			});
			$("#activity_project_id").attr('disabled', false);
			$("#invoice_id").attr('disabled', false);
			break;
			
			case 'aftercreate':
			document.forms['new_activity'].reset();
			$("#activity_project_id").val(default_project_id);
			break;
			
			default:
			// re-enabling the create form after edit
			$(".ui-datepicker-trigger").show();
			$(":input").each(function(i) {
			  $(this).attr('disabled', false);
			});
			$("#activity_project_id").val(default_project_id);
			
			// Unregister the inline Time Entry fields
			$('#activity_start_time').timeEntry('destroy');
			$('#activity_end_time').timeEntry('destroy');
			$('#activity_edit_link').attr('href', '');
		}
	},
	addEditListeners: function(){
		$('tr.list-record').live('mouseover', function() {
			if(!$.inEditMode()){
				$(this).addClass('over');
			}
		});
		
		$('tr.list-record').live('mouseout', function() {
			if(!$.inEditMode()){
				$(this).removeClass('over');
			}
		});

		$('td.activity-edit').live('click', function() {
			if(!$.inEditMode()){
				// handles remote edit through jquery.rails.js
				// add the href to the hidden remote link and fire the click event
				var id = $(this).parent().attr('id');
				// make sure the row is highlighted
				$(this).addClass('over');
				id = id.replace('activity_', '');
				$('#activity_edit_link').attr('href', '/activities/'+id+'/edit');
				$('#activity_edit_link').click();
			}
		});
		
		$('#close_errors').live('click', function(e){
			$('#errors').html('');
			e.preventDefault();
		});
	},
	handleEntryErrors: function(data){
		if(undefined != data){
			try{
				var response = jQuery.parseJSON(data);
			}catch(e){
				var response = '';
			}
			if(undefined != response.success && response.success == false){
				var errors = response.errors;
				var id = response.id == 'new' ? '#new_activity_entry' : '#activity_'+response.id;
				for(var prop in errors) {
					// find the form input
					var inputs = $(id).find("input[name='activity["+prop+"]']");
					if(inputs.length == 0){
						var inputs = $(id).find("select[name='activity["+prop+"]']");
					}
					// get the input's error-msg sibling
					inputs.each(function(i) {
						var p = $(this).parents('td').first();
						p.find(".error-msg").html(errors[prop]);
						p.addClass('row-error');
					});
				}
				$(id).find(".error-image").show();
			}
		}
	},
	clearEntryErrors: function(){
		$(".error-msg").html('');
		$(".row-error").removeClass('row-error');
	},
	inEditMode: function(){
		if($('#activity_edit_link').attr('href') == ''){
			return(false)
		}
		return(true);
	}
});

$(document).ready(function() {
	
	// Auto Complete for action form
	$("#new_activity_project_number").autocomplete({
		source: "/projects",
		minLength: 0,
		select: function(event, ui) {
			if(ui.item){
				$("#activity_project_id").val(ui.item.id);
			}
		}
	});
	// Date Picker
	$("#new_activity_date").datepicker({
		dateFormat: 'yy-mm-dd',
		showOn: 'button',
		buttonImage: '/images/calendar.png',
		buttonImageOnly: true
	});
	
	// enable create form in case disabled and page refresh doesn't re-enable
	$(":input").each(function(i) {
	  $(this).attr('disabled', false);
	});
	
	var default_project_id = $("#default_project_id").val();
	// set the default project_id
	$("#activity_project_id").val(default_project_id);
	
	// Time Entry
	$('#new_activity_start_time').timeEntry({spinnerImage: '', ampmPrefix: ' '});
	$('#new_activity_end_time').timeEntry({spinnerImage: '', ampmPrefix: ' '});
	
	// editing
	$.addEditListeners();
	
	$('#activity_edit_link').bind('ajax:loading', function(xhr){
		var id = $(this).attr('href').replace('/activities/', '#load_edit_');
		id = id.replace('/edit','');
		// show the loading element for the row
		$(id).show();
		
	});
	
	$('#new_activity').bind('ajax:loading', function(xhr){
		$.clearEntryErrors();
		var el = xhr.target;
		var id = el.id;
		if(id == 'cancel-edit-item'){
			// canceling edit
			$('#action_edit').hide();
			$('#load_cancel').show();
		} else {
			switch($(this).attr('method').toUpperCase()){
				// creating new record
				case 'POST':
				$('#action_create').hide();
				$('#load_create').show();
				break;
				
				// updating existing
				case 'PUT':
				$('#action_edit').hide();
				$('#load_save').show();
				break;				
			}
		}
	});
	
	$('#new_activity').bind('ajax:success', function(e, data, status, xhr){
		$.handleEntryErrors(data);
	});
		
	$('#new_activity').bind('ajax:complete', function(xhr){
		switch($(this).attr('method').toUpperCase()){
			case 'POST':
			$('#load_create').hide();
			$('#action_create').show();
			break;
			
			// updating existing
			case 'PUT':
			$('#load_save').hide();
			$('#action_edit').show();
			break;
		}
	});
	
	$('#activity_search_form').bind('ajax:loading', function(xhr){
		$('#new_activity').mask('Loading...');
	});
		
	$('#activity_search_form').bind('ajax:complete', function(xhr){
		$('#new_activity').unmask();
	});
	
	$('#action_delete').click(function() {
		if(!$.inEditMode()){
			var n = $("input:checked").length;
			if(n > 0){
				if(confirm('Delete '+n+' items? This cannot be undone!')){
					$('input[name=action_type]').val('delete');
	                data = $('#new_activity').serializeArray();
					$.ajax({
	                	url: '/activities/list_action',
	                    data: data,
	                    dataType: 'script',
	                    type: 'POST',
	                    beforeSend: function (xhr) {
	                         $('#new_activity').mask('Loading...');
	                    },
	                    success: function (data, status, xhr) {
							
						},
	                     complete: function (xhr) {
	                         $('#new_activity').unmask();
	                     },
	                     error: function (xhr, status, error) {
                         
	                     }
	            	});
				}
			}else{
				alert('No selection')
			}
		}
	});
	
	// select actions
	
	$('#action_select_all').click(function() {
		$('input[name=action_id[]]').attr('checked', true);
	});
	
	$('#action_select_none').click(function() {
		$('input[name=action_id[]]').attr('checked', false);
	});	
});
