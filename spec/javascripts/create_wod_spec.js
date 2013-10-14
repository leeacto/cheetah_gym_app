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
    tab = new Tab('select_workout');
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
});

describe("selectTab",function(){
  beforeEach(function(){
    sWod = new wodSelector('.recd_workout_tabs');
    tab_a = new Tab('workout_tab');
    tab_b = new Tab('daywod_tab');
    tab_c = new Tab('results_tab');
    sWod.tabs.push(tab_a);
    sWod.tabs.push(tab_b);
    sWod.tabs.push(tab_c);
  });

  // it("", function() {
  //   var el = $("#tab-view");

    
  //   var el = $("<div><form><input id='one' val='two'></input></form></div>")
    
  //   var tabView = new TabView(el);
  //   function TabView(el) {
  //     this.el = el;

  //     this.getAttributes() {
  //       this.name = this.el.find("input").val();

  //     }

  //   }

  // })

  it("should remove the hidden state from selected tab", function(){
    sWod.selectTab(tab_b);
    expect(tab_b.hidden).toBe(false);
    expect(tab_b.body.hidden).toBe(false);
  });

  it("should add the hidden state to all other tabs", function(){
    sWod.selectTab(tab_b);
    sWod.selectTab(tab_c);
    expect(tab_b.hidden).toBe(true);
    expect(tab_b.body.hidden).toBe(true);
    expect(tab_a.hidden).toBe(true);
    expect(tab_a.body.hidden).toBe(true);
  });

});

describe("Tab", function(){
  beforeEach(function(){
    sWod = new wodSelector('.recd_workout_tabs');
    tab_a = new Tab('workout_tab');
    sWod.tabs.push(tab_a);
  });

  describe("addBody", function(){
    it("should have as addBody function for each tab", function(){
      spyOn(tab_a, "addBody");
      tab_a.addBody();
      expect(tab_a.addBody).toHaveBeenCalled();
    });
  });
});

describe("Body", function(){
  it("should have the correct selector", function(){
    tab_a = new Tab('workout_tab');
    expect(tab_a.body.el.selector).toBe('.select_workout');
  });

  it("should be initially hidden", function(){
    tab_a = new Tab('workout_tab');
    expect(tab_a.body.hidden).toBe(true);
  });

  it("should call addAttribs function on init", function(){
    spyOn(Body.prototype, "addAttribs");
    tab_a = new Tab('workout_tab');
    expect(Body.prototype.addAttribs).toHaveBeenCalled();
  });
});
