require 'pry-byebug'

class LikesController < ApplicationController
    before_action :authenticate_user!
  def create
    like = Like.new
    like.user = current_user
    like.post = Post.find(params[:post_id])

    if like.save
        redirect_to request.referrer
    else
        redirect_to request.referrer, notice: 'Something bad happened'
    end
  end

  def destroy
    if current_user.likes.find_by(id: params[:id]).destroy
        redirect_to request.referrer
    else
        redirect_to request.referrer, notice: 'Something bad happened'
    end
  end
end
