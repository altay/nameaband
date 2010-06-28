class NamesController < ApplicationController
  before_filter :require_user, :only=>[:create]

  def list
    @active_sort = (params[:active_sort] || "new")
    @names = Name.all(:order=>Name::SORT_OPTIONS.assoc(@active_sort)[1])
    @liked_nids = (current_user ? current_user.liked_names.map(&:secret_id) : [])
    @disliked_nids = (current_user ? current_user.disliked_names.map(&:secret_id) : [])
    @misc_js << "BN.set_opinions(#{@liked_nids.inspect}, 'like');"
    @misc_js << "BN.set_opinions(#{@disliked_nids.inspect}, 'dislike');"
  end

=begin # toggle_opinion use cases
      - X no opinion, liking
        - create like
      - X no opinion, disliking
        - create dislike
      - X liked, unliking
        - destroy like
      - X disliked, undisliking
        - destroy dislike
      - X liked, disliking
        - destroy like
        - create dislike
      - X disliked, liking
        - destroy dislike
        - create like
=end
  def toggle_opinion
    if current_user.nil?
      render(:json=>{:error=>"First, you need to log in, buddy. Upper right corner."}) and return
    else
      @opinion_type = params[:opinion_type] # 'like' or 'dislike'
      @opposite_opinion_type = (@opinion_type=='like' ? 'dislike' : 'like')
      @name = Name.find_by_secret_id(params[:name_id])
      render(:json=>{:error=>"Yikes! Something went wrong. Try again."}) and return unless @name
      @like = @name.likes.find_by_user_id(current_user.id)
      @dislike = @name.dislikes.find_by_user_id(current_user.id)
      @no_prior_opinion = true if (@like.nil? && @dislike.nil?)
      if @like
        @like.destroy
        @name.likes_count-=1
        if @opinion_type=='dislike'
          Dislike.create(:user_id=>current_user.id, :name_id=>@name.id)
          @name.dislikes_count+=1
        end
      end
      if @dislike
        @dislike.destroy
        @name.dislikes_count-=1
        if @opinion_type=='like'
          Like.create(:user_id=>current_user.id, :name_id=>@name.id)
          @name.likes_count+=1
        end
      end
      if @no_prior_opinion
        if @opinion_type=='like'
          Like.create(:user_id=>current_user.id, :name_id=>@name.id)
          @name.likes_count+=1
        elsif @opinion_type=='dislike'
          Dislike.create(:user_id=>current_user.id, :name_id=>@name.id)
          @name.dislikes_count+=1
        end
      end
      @name.save
      render(:json=>{:ok=>true}) and return 
    end
  end

  def create
    unless params[:name].blank?
      flash[:notice] = "Nice one."
      @name = Name.create(:name=>params[:name], :user_id=>current_user.id)
      TheMailer.deliver_new_name_notification(@name)
    end
    redirect_to('/') and return
  end

end
