class StaticPagesController < ApplicationController
  #layout  false
  def home
     if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  # Add Test
  def about
  end 
  
  def contract
  end
  
  	

  
end
