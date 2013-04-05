require 'spec_helper'

describe ResultsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @wod = FactoryGirl.create(:wod)
    @attr = { :recd => 1 }
  end

  it "should create a new result based given valid attributes" do
    @daywod = @wod.daywods.create(:performed => "1/1/2013")
    @user.results.build(:daywod_id => @wod.id, :recd => 1)
  end

end
