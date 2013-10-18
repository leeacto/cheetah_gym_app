require 'spec_helper'

describe ResultsController do
  before(:each) do
    @wod = FactoryGirl.create(:wod)
    @attr = { :performed => "01/01/2013", :wod_id => @wod.id }
    @daywod = Daywod.create!(@attr)
    @user = FactoryGirl.create(:user)
  end

  describe "POST #create" do
    before(:each) do
      controller.stub(:current_user).and_return @user
      controller.stub(:daywod).and_return Daywod.first
    end 

    describe "access control" do
      it "should deny access to create other user result if not admin" do
        @second = FactoryGirl.create(:user, :email => "another@example.com")
        @attrres = { :recd => 1, :rx => 1, :user_id => @second.id, :daywod_id => @daywod.id}
        expect{ post :create, result: @attrres }.not_to change(Result, :count)
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @attrres = { :recd => 1, :rx => 1, :user_id => @user.id, :daywod_id => @daywod.id}
      @result = Result.create!(@attrres)
    end
    
    context "success" do
      it "allows result owner to update result" do
        controller.stub(:current_user).and_return @user
        post :update, :id => @result.id, result: {:recd => 2}
        @result.reload
        @result.recd.should eq 2
      end
    end

    context "failure" do
      it "denies update for non-admin editing other athlete result" do
        @second_user = FactoryGirl.create(:user, :email => "another@example.com")
        controller.stub(:current_user).and_return @second_user
        post :update, :id => @result.id, result: {:recd => 2}
        @result.reload
        @result.recd.should eq 1
        flash[:error].should =~ /own/i
        response.should redirect_to root_path
      end
    end
  end
end
