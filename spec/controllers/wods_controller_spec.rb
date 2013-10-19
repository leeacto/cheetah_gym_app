require 'spec_helper'

describe WodsController do
  render_views

  describe "GET 'show'" do
    before(:each) do
      @wod = Wod.create(:name => "Fran", :description => "21-15-9", :seq => "WG", :wod_type => "time", :baserep => 1)
    end

    it "should be successful" do
      get :show, :id => @wod
      response.should be_success
    end

    it "should find the right wod" do
      get :show, :id => @wod
      assigns(:wod).should == @wod
    end

    it "should have the right title" do
      get :show, :id => @wod
      response.should have_selector("title", :content => @wod.name)
    end
  end

end