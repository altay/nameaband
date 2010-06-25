class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Welcome!"
      redirect_back_or_default "/" #account_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = (User.find_by_login(params[:login]) || current_user)
    @suggested_names = @user.names.all(:order=>'created_at DESC')
    @liked_names = @user.liked_names.all(:order=>'likes.created_at DESC')
    @current_user_liked_nids = (current_user ? current_user.liked_names.map(&:secret_id) : [])
    @misc_js << "BN.set_likes(#{@current_user_liked_nids.inspect});"
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end

