require 'spec_helper'

describe Daywod do
	before(:each) do 
		@wod = FactoryGirl.create(:wod)
		@attr = { :performed => "02/01/2013" }
	end

	it "should create a new instance given valid attributes" do 
		@wod.daywods.create!(@attr)
	end

	describe "WOD Associations" do
		
		before(:each) do
			@daywod = @wod.daywods.create(@attr)
		end

		it "should have a wod attribute" do
			@daywod.should respond_to(:wod)
		end

		it "should have the right associated wod" do
			@daywod.wod_id.should == @wod.id 
			@daywod.wod.should == @wod 
		end
	end
end