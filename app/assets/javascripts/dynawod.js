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

function showWorkoutTab() {
  $('.Select_Workout').removeClass('hidden');
  $('.Select_Daywod').addClass('hidden');
  $('.Select_Results').addClass('hidden');
}

function showDaywodTab() {
  $('.Select_Workout').addClass('hidden');
  $('.Select_Daywod'  ).removeClass('hidden');
  $('.Select_Results').addClass('hidden');
}

function showResultTab() {  
  $('.Select_Workout').addClass('hidden');
  $('.Select_Daywod').addClass('hidden');
  $('.Select_Results').removeClass('hidden');
}

var wodSelector = function(el) {
  this.el = el;
  this.tabs = [];
};

wodSelector.prototype.initialize = function(){
  this.addTabs();
}

wodSelector.prototype.selectTab = function(tab){
  for(var i in this.tabs)
  {
    if(this.tabs[i] === tab)
    {
      this.tabs[i].hidden = false;
      this.tabs[i].el.removeClass('hidden');
    }
    else {
     this.tabs[i].hidden = true;
     this.tabs[i].el.addClass('hidden');
    }
  }
}

wodSelector.prototype.addTabs = function(){
  var self = this;
  $(this.el).find('.tab_header li').each(function(){
    var new_tab = new Tab(this.id);
    self.tabs.push(new_tab);
  });
}

var Tab = function(el) {
  this.el = $(el);
  this.hidden = true;
}

$(document).ready(function() {
  var wSelector = new wodSelector('.recd_workout_tabs');
  wSelector.initialize();

  wodStats($('#wod_wod_id').val());

  $('#wod_wod_id').on('change', function() {
    wodStats(this.value);
  });

  $('#new_wod_button').on('click', function(event) {
    event.preventDefault();
    clrWorkoutForm();
  });

  $('#new_wod').on('submit', function(event){
    event.stopPropagation();
    event.preventDefault();
    showDaywodTab();
  });

  $('#select_tab').on('click', function(){
    event.stopPropagation();
    showWorkoutTab();
  });

  $('#new_daywod').on('submit', function(event){
    event.stopPropagation();
    event.preventDefault();
    showResultTab();
  });

  $('#daywod_tab').on('click', function(){
    event.stopPropagation();
    showDaywodTab();
  });

  $('#results_tab').on('click', function(){
    event.stopPropagation();
    showResultTab();
  });
});
