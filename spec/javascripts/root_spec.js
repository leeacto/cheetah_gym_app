//= require jquery
//= require jquery_ujs
//= require root_page

describe("dayWodList", function(){
  beforeEach(function(){
    dwList = new dayWodList(
      "<div class = 'journal'>" +
        "<ul class='journal_entry'>" +
          "<li>2013-10-25</li>" +
          "<li>WOD: Test</li>" +
          "<li>Desc</li>" +
          "<li><a href='/wods/1/daywods/1/results/new'>Enter Result</a>" +
          "<a href='/wods/1/daywods/1/results' id='daywod_1'>View Results</a></li>" +
          "<div id='results_1'></div>" +
        "</ul>" +
      "</div>"
      );
  });

  it("should have an init function", function(){
    spyOn(dwList, "addEntries")
    dwList.init();
    expect(dwList.addEntries).toHaveBeenCalled();
  });

  it("should have entries", function() {
    dwList.init();
    expect(dwList.entries.length).toBe(1);
  });
});

describe("Entry", function() {
  beforeEach(function(){
    entry = new Entry(
      "<ul class='journal_entry'>" +
        "<li>2013-10-25</li>" +
        "<li>WOD: <a href='wods/1/daywods/1'>Test</a></li>" +
        "<li>Desc</li>" +
        "<li><a href='/wods/1/daywods/1/results/new'>Enter Result</a>" +
        "<a href='/wods/1/daywods/1/results' id='daywod_1'>View Results</a></li>" +
        "<div id='results_1'></div>" +
      "</ul>"
      );
  });

  it("should have the correct daywod id", function(){
    expect(entry.dwId.selector).toBe('#daywod_1');
  });

  it("should have a results div", function(){
    expect(entry.resultDiv[0].id).toBe('results_1');
  });
});