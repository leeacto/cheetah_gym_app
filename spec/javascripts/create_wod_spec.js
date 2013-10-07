//= require jquery
//= require jquery_ujs
//= require dynawod

describe("selectWod", function(){
  beforeEach(function(){
    sWod = new wodSelector('.recd_workout_tabs');
    $tabHeads = affix
  });

  it("should have the correct el", function(){
    expect(sWod.el).toBe('.recd_workout_tabs');
  });

  it("should have an initialize function", function(){
    spyOn(sWod, "addTabs");
    sWod.initialize();
    expect(sWod.addTabs).toHaveBeenCalled();
  });

  it("should have a selectTab function", function(){
    sWod.initialize();
    var tab = sWod.tabs[0];
    spyOn(sWod.tabs[0].el, "addClass");
    sWod.selectTab(tab);
    expect(sWod.tabs[0].el.addClass).toHaveBeenCalled();
  });
  
  describe("Initialization", function(){
    beforeEach(function(){
      spyOn(sWod.tabs, "push");
      sWod.initialize();
    });

    it("should have an addTabs function", function(){
      expect(sWod.tabs.push).toHaveBeenCalled();
    });
  });

  describe("selectTab", function(){
    beforeEach(function(){
    });

  });
});