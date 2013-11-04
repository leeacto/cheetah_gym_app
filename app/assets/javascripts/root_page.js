var dayWodList = function(el) {
  this.el = $(el);
  this.entries = [];
}

dayWodList.prototype.init = function() {
  this.addEntries();
}

dayWodList.prototype.addEntries = function() {
  var self = this;
  this.el.find('.journal_entry').each(function(){
    var entry = new Entry(this);
    self.entries.push(entry);
  });
}

var Entry = function(el) {
  this.el = $(el);
  this.dwId = $("#" + this.el.find("a:contains('View Results')")[0].id);
  this.wId = $("#" + this.el.find('a:nth-child(1)')[0].id);
  this.resultDiv = $(el).find('div');

  var daywod_num = this.dwId.selector.replace('#daywod_','');
  var wod_num = this.wId.selector.replace('#wod_','');
  var self = this;
  this.dwId.on('click', function(event){
    event.stopPropagation();
    event.preventDefault();
    self.resultDiv.text('');
    $.ajax({
      url: "/wods/" + wod_num + "/daywods/" + daywod_num + "/results",
      method: 'GET'
    }).done(function(results) {
      self.resultDiv.append(results);
    })
    .error(function(){
      self.resultDiv.append('<li>No Results</li>');
    })
    .always(function(){
      self.resultDiv.toggleClass('hidden');
    });
  });
}

$(document).ready(function(){
  var dwList = new dayWodList('.journal');
  dwList.init();
})