//= require jquery
//= require jquery_ujs
//= require dynawod

describe("selectWod", function(){
  beforeEach(function(){
    sWod = new wodSelector('.recd_workout_tabs');
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
    tab = new Tab('.test');
    sWod.initialize();
    spyOn(sWod, "selectTab");
    sWod.selectTab(tab);
    expect(sWod.selectTab).toHaveBeenCalledWith(tab);
  });
  
  it("should have an addTabs function", function(){
    spyOn(sWod, "addTabs");
    sWod.addTabs();
    expect(sWod.addTabs).toHaveBeenCalled();
  });

  describe("selectTab",function(){
    beforeEach(function(){
      tab_a = new Tab('.tab_a');
      tab_b = new Tab('.tab_b');
      tab_c = new Tab('.tab_c');
      sWod.tabs.push(tab_a);
      sWod.tabs.push(tab_b);
      sWod.tabs.push(tab_c);
    });

    it("should remove the hidden state from selected tab", function(){
      sWod.selectTab(tab_b);
      expect(tab_b.hidden).toBe(false);
    });

    it("should add the hidden state to all other tabs", function(){
      sWod.selectTab(tab_b);
      sWod.selectTab(tab_c);
      expect(tab_b.hidden).toBe(true);
      expect(tab_a.hidden).toBe(true);
    });
  });
});