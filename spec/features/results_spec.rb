require 'spec_helper'
include UserHelper

feature 'Results' do
  describe "Navigation" do
    context "As a member" do
      before(:each) do
        @wod = FactoryGirl.create(:wod)
        @daywod = FactoryGirl.create(:daywod)
      end

      describe "As Admin" do
        before(:each) do
          FactoryGirl.create(:user, :name => "Other User", :email => "other@example.com")
          log_in_admin
          click_link 'WODs'
          click_link 'Fran'
          click_link '2013-01-01'
          click_link 'Add Result'
        end

        describe "With valid attributes" do
          before(:each) do
            fill_in 'result_mins', with: 1
            fill_in 'result_secs', with: 1
          end

          it "creates a result for itself" do
            lambda do
              select 'Michael Hartl', from: 'result_user_id'
              click_button 'Submit Result'
            end.should change(Result, :count).by(1)
          end

          it "creates a result for other members" do
            lambda do
              select 'Other User', from: 'result_user_id'
              click_button 'Submit Result'
            end.should change(Result, :count).by(1)
          end
        end

        describe "with invalid attributes" do
          it "denies result creation" do
            lambda do
              select 'Michael Hartl', from: 'result_user_id'
              fill_in 'result_mins', with: 'k'
              fill_in 'result_secs', with: 'k'
              click_button 'Submit Result'
            end.should_not change(Result, :count)
          end
        end
      end
    end
    
    context "As Member" do
      before(:each) do
        @wod = FactoryGirl.create(:wod)
        @daywod = FactoryGirl.create(:daywod)
        log_in_member
      end

      it "does not see ability to log result" do
        click_link 'WODs'
        click_link 'Fran'
        click_link '2013-01-01'
        page.should_not have_content 'Add Result'
      end
    end
  end
end