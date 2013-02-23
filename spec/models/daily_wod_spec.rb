require 'spec_helper'

describe DailyWod do
	before(:each) do 
		@wod = FactoryGirl.create(:wod)
		@attr = { :performed => "02/01/2013" }
	end

	it "should create a new instance given valid attributes" do 
		@wod.daily_wods.create!(@attr)
	end

	describe "WOD Associations" do
		
		before(:each) do
			@dailywod = @wod.daily_wods.create(@attr)
		end

		it "should have a wod attribute" do
			@dailywod.should respond_to(:wod)
		end

		it "should have the right associated wod" do
			@dailywod.wod_id.should == @wod.id 
			@dailywod.wod.should == @wod 
		end
	end
end