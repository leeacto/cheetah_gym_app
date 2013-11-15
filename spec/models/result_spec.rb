require 'spec_helper'

describe Result do
  before(:each) do 
    @wod = FactoryGirl.create(:wod)
    @user = FactoryGirl.create(:user)
    @attr = { :performed => "02/01/2013" }
    @daywod = @wod.daywods.create!(@attr)
    @attrres = { :recd => 1, :rx => 1, :user_id => @user.id, :daywod_id => @daywod.id}
    
  end

  it "should create a new instance given valid attributes" do 
    Result.create!(@attrres)
  end

  describe "Result Associations" do
    before(:each) do
      @result = Result.create!(@attrres)
    end

    it "should have a daywod attribute" do
      @result.should respond_to(:daywod)
    end

    it "should have the right associated daywod" do
      @result.daywod_id.should == @daywod.id 
      @result.daywod.should == @daywod 
    end
    
    it "should have the right associated user" do
      @result.user_id.should == @user.id 
      @result.user.should == @user 
    end
  end

  describe '#formatted' do
    before(:each) do
      @result = Result.create!(@attrres)
      @result.recd = 128
      @result.save
    end
    
    describe 'formats a timed wod' do
      it 'under an hour' do
        expect(@result.formatted).to eq '2:08'
      end

      it 'over an hour' do
        @result.recd = 3601
        @result.save
        expect(@result.formatted).to eq '1:00:01'
      end
    end

    it 'formats a reps wod' do
      @wod.wod_type = 'Reps'
      @wod.baserep = 1
      @wod.save
      expect(@result.formatted).to eq '128'
    end
  end
end
