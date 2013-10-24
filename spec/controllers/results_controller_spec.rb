require 'spec_helper'

describe ResultsController do
  before(:each) do
    @wod = FactoryGirl.create(:wod)
    @attr = { :performed => "01/01/2013", :wod_id => @wod.id }
    @daywod = Daywod.create!(@attr)
    @user = FactoryGirl.create(:user)
  end

  describe "GET #new" do
    before(:each) do
      get :new, :wod_id => @wod.id, :daywod_id => @daywod.id
    end

    it "finds the correct wod/daywod" do
      assigns(:wod).should eq @wod
      assigns(:daywod).should eq @daywod
    end

    it "has the correct title" do
      assigns(:title).should eq "WOD Result"
    end
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
    
    describe "As Member" do
      context "success" do
        before(:each) do
          controller.stub(:current_user).and_return @user
          post :update, :id => @result.id, result: {:secs => 2}
          @result.reload
        end

        it "allows result owner to update result" do
          @result.recd.should eq 2
        end

        it "flashes success" do
          flash.now[:success].should =~ /updated/i
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

  describe "POST #destroy" do
    before(:each) do
      @attrres = { :recd => 1, :rx => 1, :user_id => @user.id, :daywod_id => @daywod.id}
      @result = Result.create!(@attrres)
    end

    describe "As Admin" do
      before(:each) do
        @user = double(:user, :admin => true, :id => 2)
        controller.stub(:current_user).and_return @user
      end

      describe "Assignments" do
        before(:each) do
          post :destroy, :id => @result.id
        end
        
        it "finds the correct result" do
          expect(assigns(:result)).to eq @result
        end

        it "finds the correct daywod" do
          expect(assigns(:daywod)).to eq @daywod
        end

        it "finds the correct wod" do
          expect(assigns(:wod)).to eq @wod
        end
      end

      it "can delete other results" do
        expect{post :destroy, :id => @result.id}.to change(Result, :count).by(-1)
      end

      it 'redirects to daywod page' do
        post :destroy, :id => @result.id
        response.should redirect_to wod_daywod_path(@wod, @daywod)
      end
    end

    describe "As Athlete" do
      before(:each) do
        @user = double(:user, :admin => false, :id => 1)
        @other_result = Result.create({:recd => 1, :rx => 1, :user_id => 2, :daywod_id => @daywod.id})
        controller.stub(:current_user).and_return User.find(1)
        controller.stub(:signed_in?).and_return true
        @session_helper = Object.new.extend(SessionsHelper)
        @session_helper.stub(:user).and_return true
      end

      context "Own Result" do
        describe "Assignments" do
          before(:each) do
            post :destroy, :id => @result.id
          end
          
          it "finds the correct result" do
            expect(assigns(:result)).to eq @result
          end

          it "finds the correct daywod" do
            expect(assigns(:daywod)).to eq @daywod
          end

          it "finds the correct wod" do
            expect(assigns(:wod)).to eq @wod
          end
        end

        describe "Actions" do
          it "deletes its result" do
            expect{post :destroy, :id => @result.id}.to change(Result, :count).by(-1)
          end

          it 'redirects to daywod page' do
            post :destroy, :id => @result.id
            response.should redirect_to wod_daywod_path(@wod, @daywod)
          end
        end
      end

      context "Other Results" do
        describe "Reactions" do
          before(:each) do
            post :destroy, :id => @other_result.id
          end

          it "flashes an error" do
            flash.now[:error].should =~ /own/i
          end
          
          it 'redirects to daywod page' do
            response.should redirect_to wod_daywod_path(@wod, @daywod)
          end
        end

        it "does not delete result" do
          expect{post :destroy, :id => @other_result.id}.to_not change(Result, :count)
        end
      end
    end

    describe "As Visitor" do
      before(:each) do
        controller.stub(:current_user).and_return nil
      end
      
      it "should not delete the record" do
        expect{post :destroy, :id => @result.id}.to_not change(Result,:count)
      end

      it "flashes an error" do
        post :destroy, :id => @result.id
        flash.now[:error].should =~ /own result/i
      end
    end
  end
end
