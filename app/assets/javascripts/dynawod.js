var wodSelector = function(el) {
  this.el = $(el);
  this.tabs = [];
};

wodSelector.prototype.initialize = function(){
  this.addTabs();
}

wodSelector.prototype.addTabs = function(){
  var self = this;

  (this.el).find('.tab_header li').each(function(){
    var new_tab = new Tab(this.id, self);
    new_tab.el.on('click',function(){
      self.selectTab(new_tab);
    });
    self.tabs.push(new_tab);
  });

  this.tabs[0].body.wodForm.el.on('submit', function(event){
    event.stopPropagation();
    event.preventDefault();
    if (self.tabs[0].body.wodName.val() === '')
    {
      alert('WOD Must Have a Name');
    }
    else if (self.tabs[0].body.wodDesc.val() === '') {
      alert('WOD Must Have a Description');
    }
    else
    {
      self.selectTab(self.tabs[1]);
    }
  });

  this.tabs[1].body.wodForm.el.on('submit', function(event){
    self.selectTab(self.tabs[2]);
  });
}

wodSelector.prototype.selectTab = function(tab){
  for(var i in this.tabs)
  {
    if(this.tabs[i] === tab)
    {
      this.tabs[i].hidden = false;
      this.tabs[i].el.addClass('selected_tab');
      this.tabs[i].body.hidden = false;
      this.tabs[i].body.el.removeClass('hidden');
    }
    else {
     this.tabs[i].hidden = true;
     this.tabs[i].el.removeClass('selected_tab');
     this.tabs[i].body.hidden = true;
     this.tabs[i].body.el.addClass('hidden');
    }
  }
}

var Tab = function(el, wodSelector) {
  this.wodSelector = wodSelector;
  this.el = $("#"+el);
  this.hidden = true;
  this.addBody();
}

Tab.prototype.addBody = function() {
  this.body = new Body(this.el.selector, this);
};

var Body = function(el, tab) {
  this.tab = tab;
  this.el = $(".select_" + el.substring(1,el.length-4));
  this.hidden = true;
  this.addAttribs();
}

Body.prototype.addAttribs = function() {
  if(this.el.selector === '.select_workout')
  {
    var self = this;
    this.wodDd = { el:$('#wod_wod_id') }
    this.newWod = { el:$('#new_wod') }
    this.wodForm = { el:$('.wod_form') }

    this.wodName = this.wodForm.el.find('#wod_name');
    this.wodDesc = this.wodForm.el.find('#wod_description');

    this.wodStats(this.wodDd.el.val());

    this.wodDd.el.on('change', function() {
      self.wodStats(this.value);
    });
    
    this.el.find('#new_wod_button').on('click', function(event) {
      event.preventDefault();
      self.clrWorkoutForm();
    });
  }
  else if(this.el.selector === '.select_daywod')
  {
    this.wodForm = { el:$('#new_daywod') };
  }
};

Body.prototype.wodStats = function(id) {
  $.ajax({
    url: "/wods/"+(id),
    method: 'get',
    dataType: 'json'
  }).done(function(wod_data) {
    $('#wod_name').val(wod_data.wod.name);
    $('#wod_description').val(wod_data.wod.description);
    $('#wod_seq').val(wod_data.wod.seq);
    var wod_radio = "#wod_wod_type_" + wod_data.wod.wod_type.toLowerCase();
    $(wod_radio).prop('checked', true);
    $('#wod_baserep').val(wod_data.wod.baserep);
  });
}

Body.prototype.clrWorkoutForm = function(){
  $('.wod_form').find('#wod_name, #wod_description, #wod_seq').val('');
  $('#wod_baserep').val(1);
  $('#wod_wod_type_time').prop('checked', true);
}

$(document).ready(function() {
  var wSelector = new wodSelector('.recd_workout_tabs');
  if ($('html')[0].baseURI.substr($('html')[0].baseURI.length-10) === 'newworkout') {
    wSelector.initialize();
  }
});
