$(document).ready(function() {
	
	$('#wod_wod_id').on('change', function() {
		$.ajax({
			url: "/wods/"+(this.value),
			method: 'get',
			dataType: 'json'
		}).done(function(wod_data) {
			$('#wod_name').val(wod_data.name);
			$('#wod_desc').val(wod_data.desc);
			$('#wod_seq').val(wod_data.seq);
			var wod_radio = "#wod_wod_type_" + wod_data.wod_type.toLowerCase();
			console.log(wod_radio);
			$(wod_radio).prop('checked', true);
			$('#wod_baserep').val(wod_data.baserep);
		});
	});

	$('#new_wod_button').on('click', function(event) {
		event.preventDefault();
		// clear form
	});
});
