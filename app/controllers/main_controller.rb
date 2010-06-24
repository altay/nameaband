class MainController < ApplicationController
  def index
    @names = Name.all(:order=>"created_at DESC")
  end

  def create
    if params[:name]
      Name.create(:name=>params[:name])
    end
    redirect_to(:controller=>"main", :action=>"index")
  end
end
