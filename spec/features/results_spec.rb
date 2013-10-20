require 'spec_helper'
include UserHelper

feature 'Results' do
  before(:each) do
    @wod = FactoryGirl.create(:wod)
    @daywod = FactoryGirl.create(:daywod)
  end

  describe "Creating New Results" do
    context "As a member" do
      describe "As Admin" do
        before(:each) do
          FactoryGirl.create(:user, :name => "Other User", :email => "other@example.com")
          log_in_admin
          click_on 'WODs |'
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
        log_in_member
      end

      it "has a field with member's name" do
        click_link 'WODs |'
        click_link 'Fran'
        click_link '2013-01-01'
        click_link 'Add Result'
        page.should have_content 'Athlete: Michael Hartl'
      end

      describe "with valid attributes" do
        before(:each) do
          click_link 'WODs |'
          click_link 'Fran'
          click_link '2013-01-01'
          click_link 'Add Result'
        end

        it "creates a new result" do
          lambda do
            fill_in 'result_mins', with: 1
            fill_in 'result_secs', with: 1
            click_button 'Submit Result'
            page.should have_content 'Result Logged'
            page.should have_content '2013-01-01'
          end.should change(Result, :count).by(1)
        end
      end

      describe "with invalid attributes" do
        before(:each) do
          click_link 'WODs |'
          click_link 'Fran'
          click_link '2013-01-01'
          click_link 'Add Result'
        end

        it "does not create a new result" do
          lambda do
            fill_in 'result_mins', with: 0
            fill_in 'result_secs', with: 0
            click_button 'Submit Result'
            page.should have_content 'Result was not saved'
            page.should have_content 'WOD Result'
          end.should_not change(Result, :count)
        end
      end
    end
  end

  describe "Editing Results" do
    before(:each) do
      @results_attribs = {
        :user_id => 1,
        :recd => 1,
        :daywod_id => 1
      }
      @result = Result.create(@results_attribs)
    end

    context "As Admin" do
      before(:each) do
        log_in_admin
        click_on 'WODs |'
        click_link 'Fran'
        click_link '2013-01-01'
        save_and_open_page
        click_link 'Michael Hartl'
      end

      it "navigates to the edit page" do
        page.should have_content 'Edit Result'
      end

      it "updates with valid attributes" do
        fill_in 'result_mins', with: 5
        click_button 'Update Result'
        page.should have_content 'Result updated'
        @result.reload
        @result.recd.should eq 301
      end
    end
  end
end