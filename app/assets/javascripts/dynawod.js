function wodStats(id) {
	$.ajax({
		url: "/wods/"+(id),
		method: 'get',
		dataType: 'json'
	}).done(function(wod_data) {
		$('#wod_name').val(wod_data.name);
		$('#wod_desc').val(wod_data.desc);
		$('#wod_seq').val(wod_data.seq);
		var wod_radio = "#wod_wod_type_" + wod_data.wod_type.toLowerCase();
		$(wod_radio).prop('checked', true);
		$('#wod_baserep').val(wod_data.baserep);
	});
}

function clrWorkoutForm(){
	$('.wod_form').find('#wod_name, #wod_desc, #wod_seq').val('');
	$('#wod_baserep').val(1);
	$('#wod_wod_type_time').prop('checked', true);
}

$(document).ready(function() {
	wodStats($('#wod_wod_id').val());

	$('#wod_wod_id').on('change', function() {
		wodStats(this.value);
	});

	$('#new_wod_button').on('click', function(event) {
		event.preventDefault();
		clrWorkoutForm();
	});

	$('#new_wod').on('submit', function(event){
		event.preventDefault();
		$('.Select_Workout').toggle();
	});

	$('#select_tab').on('click', function(){
		$('.Select_Workout').toggle();
	});

	$('#new_daywod').on('submit', function(event){
		event.preventDefault();
		$('.Select_Daywod').toggle();
	});

	$('#daywod_tab').on('click', function(){
		$('.Select_Daywod').toggle();
	});

	$('#results_tab').on('click', function(){
		$('.Select_Results').toggle();
	});
});
