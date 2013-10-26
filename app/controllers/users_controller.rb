class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def new
    @title = "Sign up"
    @user = User.new
  end

  def index
    @title = "All users"
    @users = User.by_name.paginate(:page => params[:page])
    @me = current_user
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @results = Result.where("user_id = ?", params[:id]).order("rx DESC, recd ASC")
  end

  def create
    @user = User.new(params[:user])
    @user.name = @user.name.titleize
    @user.email = @user.email.downcase
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Cheetah Crossfit!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def wods
    @user = current_user
    @wods = @user.wods.uniq
  end

  private
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin? 
    end
end
