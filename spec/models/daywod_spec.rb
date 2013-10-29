require 'spec_helper'

describe Daywod do
  before(:each) do 
    @wod = FactoryGirl.create(:wod)
    @attr = { :performed => "02/01/2013" }
  end

  describe 'create' do
    it "should create a new instance given valid attributes" do 
      expect{@wod.daywods.create!(@attr)}.to change(Daywod, :count).by(1)
    end

    it "does not create a new daywod given invalid attributes" do
      expect{@wod.daywods.create!()}.to raise_error
    end
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

  describe "Validations" do
    before(:each) do
      @other_wod = FactoryGirl.create(:wod, :name => "Other")
      @wod.daywods.create!(@attr)
    end

    it "creates another daywod for a separate wod" do
      expect{@other_wod.daywods.create!(@attr)}.to change(Daywod, :count).by(1)
    end

    it "does not create a daywod for the same wod on same day" do
      expect{@wod.daywods.create!(@attr)}.to raise_error
    end
  end
end