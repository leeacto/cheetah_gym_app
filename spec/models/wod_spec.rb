require 'spec_helper'

describe Wod do

  before(:each) do
  	@attr = { 	:name => "Fran",
  				:desc => "21-15-9 Thrusters, Pull Ups",
  				:seq => "WG",
  				:wod_type => "time",
  				:baserep => 1
  	}
  end

	it "should create a new instance given valid attributes" do
  	Wod.create!(@attr)
  end

  it "should require a name" do
  	no_name_wod = Wod.new(@attr.merge(:name => ""))
  	no_name_wod.should_not be_valid
  end

  it "should have a restricted name length" do
  	long_name = "a" * 11
  	long_name_wod = Wod.new(@attr.merge(:name => long_name))
  	long_name_wod.should_not be_valid
  end

  it "should reject duplicate Wods" do
  	Wod.create!(@attr)
  	Wod_with_duplicate_name = Wod.new(@attr)
  	Wod_with_duplicate_name.should_not be_valid
  end

	it "should require a description" do
  	no_desc_wod = Wod.new(@attr.merge(:desc => ""))
  	no_desc_wod.should_not be_valid
  end

  it "should require a sequence" do
  	no_seq_wod = Wod.new(@attr.merge(:seq => ""))
  	no_seq_wod.should_not be_valid
  end

  it "should require a type" do
  	no_type_wod = Wod.new(@attr.merge(:wod_type => ""))
  	no_type_wod.should_not be_valid
  end

  it "should require a baserep" do
  	no_brep_wod = Wod.new(@attr.merge(:baserep => ""))
  	no_brep_wod.should_not be_valid
  end
end
