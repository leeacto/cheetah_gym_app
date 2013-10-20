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
          log_in_admin
          click_link 'WODs'
          click_link 'Fran'
          click_link '2013-01-01'
          click_link 'Add Result'
        end

        it "creates a result for itself" do
          lambda do
            fill_in 'result_mins', with: 1
            fill_in 'result_secs', with: 1
            click_button 'Submit Result'
          end.should change(Result, :count).by(1)
        end
      end
    end
  end
end