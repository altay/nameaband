class NamesController < ApplicationController
  before_filter :require_user, :only=>[:create]

  def list
    @active_sort = (params[:active_sort] || "new")
    @names = Name.all(:order=>Name::SORT_OPTIONS.assoc(@active_sort)[1])
    @liked_nids = (current_user ? current_user.liked_names.map(&:secret_id) : [])
    @misc_js << "BN.set_likes(#{@liked_nids.inspect});"
  end

  def toggle_like
    if current_user.nil?
      render(:json=>{:error=>"First, you need to log in, buddy. Upper right corner."}) and return
    else
      @name = Name.find_by_secret_id(params[:name_id])
      render(:json=>{:error=>"Yikes! Something went wrong. Try again."}) and return unless @name
      @like = @name.likes.find_by_user_id(current_user.id)
      if @like
        @like.destroy
        @name.likes_count-=1
      else
        @like = Like.create(:user_id=>current_user.id, :name_id=>@name.id)
        @name.likes_count+=1
      end
      @name.save
      render(:json=>{:ok=>true}) and return 
    end
  end

  def create
    unless params[:name].blank?
      flash[:notice] = "Nice one."
      Name.create(:name=>params[:name], :user_id=>current_user.id)
    end
    redirect_to('/') and return
  end

end
