require 'spec_helper'

describe ResultsController do
	render_views
	before(:each) do
    @wod = FactoryGirl.create(:wod)
    @attr = { :performed => "01/01/2013", :wod_id => @wod.id }
    @daywod = Daywod.create!(@attr)
    @user = test_sign_in(FactoryGirl.create(:user))
  end 

	describe "access control" do
		it "should deny access to create other user result if not admin" do
			@second = FactoryGirl.create(:user, :email => "another@example.com")
			@attrres = { :recd => 1, :rx => 1, :user_id => @second.id, :daywod_id => @daywod.id}
			lambda do
				Result.create!(@attrres)
			end.should_not change(Result, :count)
		end
	end
end
