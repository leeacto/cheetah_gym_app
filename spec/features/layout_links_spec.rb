require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do 
    visit '/'
    page.should have_title("Cheetah Crossfit | Home")
  end

  it "should have a Contact page at '/contact'" do
    visit '/contact'
    page.should have_title("Cheetah Crossfit | Contact")
  end

  it "should have an About page at '/about'" do
    visit '/about'
    page.should have_title("Cheetah Crossfit | About")
  end

  it "should have a Help page at '/help'" do
    visit '/help'
    page.should have_title("Cheetah Crossfit | Help")
  end

  it "should have a signup page at '/signup'" do
    visit '/signup'
    page.should have_title("Cheetah Crossfit | Sign up")
  end

  describe "when not signed in" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in 'session_email',    :with => @user.email
      fill_in 'session_password',   :with => @user.password
      click_button 'Sign in'
    end

    it "should have a signout link" do
      visit root_path
      page.should have_selector("a", :text => "Sign Out")
    end

    it "should have a profile link" do 
      visit root_path
      page.should have_selector("a", :text => "Profile")
    end
  end
end
