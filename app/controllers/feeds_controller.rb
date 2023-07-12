class FeedsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Feed.posts(current_user)
  end
  
end
