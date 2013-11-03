require 'spec_helper' 

describe "Users" do
  describe "signup" do 
    describe "failure" do
      it "should not make a new user" do 
        lambda do 
          visit signup_path
          fill_in "Name",          :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",      :with => ""
          fill_in "Confirmation", :with => ""
          click_button 'Sign up'
        end.should_not change(User, :count)
      end
    end 

    describe "success" do
       it "should make a new user" do
         lambda do
          visit signup_path
          fill_in "Name",          :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",      :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button 'Sign up'
        end.should change(User, :count).by(1)
       end
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in 'session_email', :with => ""
        fill_in 'session_password', :with => ""
        click_button 'Sign in'
        page.should have_content 'Invalid'
      end
    end

    describe "success" do
      context 'case sensitive' do
        it "should sign a user in and out" do
          user = FactoryGirl.create(:user)
          visit signin_path
          fill_in 'session_email', :with => 'mhartl@example.com'
          fill_in 'session_password', :with => 'foobar'
          click_button 'Sign in'
          page.should have_content 'Sign Out'
          click_link "Sign Out"
          page.should have_content 'Sign In'
        end
      end

      context 'case insensitive' do
        it "should sign a user in and out" do
          user = FactoryGirl.create(:user)
          visit signin_path
          fill_in 'session_email', :with => 'MHartl@example.com'
          fill_in 'session_password', :with => 'foobar'
          click_button 'Sign in'
          page.should have_content 'Sign Out'
          click_link "Sign Out"
          page.should have_content 'Sign In'
        end
      end

    end

    describe "sign in routing" do
      it "should route to homepage" do
        user = FactoryGirl.create(:user)
        visit signin_path
        fill_in 'session_email', :with => 'mhartl@example.com'
        fill_in 'session_password', :with => 'foobar'
        click_button 'Sign in'
        page.should have_content 'Create new WOD'
      end
    end
  end
end