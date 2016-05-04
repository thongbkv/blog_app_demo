class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry  = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      #@users = current_user.following.paginate(page: params[:page])
    else
      @entry  = Entry.all
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
