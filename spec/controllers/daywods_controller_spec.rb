require 'spec_helper'

describe DaywodsController do
  # render_views

  describe "POST 'create'" do
    before(:each) do
      @wod = FactoryGirl.create(:wod)
      @attr = { :performed => "01/01/2013", :wod_id => @wod.id }
    end 

    it "should create a daywod given valid attributes" do
      Daywod.create!(@attr)
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @wod = FactoryGirl.create(:wod)
      @attr = { :performed => "01/01/2013", :wod_id => @wod.id }
      @daywod = Daywod.create!(@attr)
    end 

    it "returns http success" do
      get :edit, :id => @daywod.id
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @wod = FactoryGirl.create(:wod)
      @attr = { :performed => "01/01/2013", :wod_id => @wod.id }
      @daywod = Daywod.create!(@attr)
    end 

    it "should destroy the daywod" do
      lambda do
        delete :destroy, :id => @daywod.id
      end.should change(Daywod, :count).by(-1)
    end
  end

  describe "GET 'show'" do
     before(:each) do
      @wod = FactoryGirl.create(:wod)
      @attr = { :performed => "01/01/2013", :wod_id => @wod.id }
      @daywod = Daywod.create!(@attr)
    end 

    it "returns http success" do
      get :show, :id => @daywod.id
      response.should be_success
    end
  end
end
