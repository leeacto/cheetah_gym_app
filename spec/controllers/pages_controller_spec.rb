require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get :home
      response.should be_success
    end

    it "should render the home template" do
      get :home
      response.should render_template 'home'
   end
  end

  describe "GET 'contact'" do
    before(:each) do
      get :contact
    end
    
    it "should be successful" do
      response.should be_success
    end

    it "should render the contact template" do
      response.should render_template 'contact'
   end
  end

  describe "GET 'about'" do
    before(:each) do
      get :about
    end
    
    it "should be successful" do
      response.should be_success
    end

    it "should render the about template" do
      response.should render_template 'about'
   end
  end
end
