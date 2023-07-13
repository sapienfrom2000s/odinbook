
class LikesController < ApplicationController
    before_action :authenticate_user!
  def create
    like = Like.new
    like.user = current_user
    like.post = Post.find(params[:post_id])

    like.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("like_button_#{params[:post_id]}",
           partial: 'dislike_button_form', locals: { post_id: params[:post_id],
             like_id: Like.metadata(Post.find(params[:post_id]), current_user).first.id }) 
      end
      format.html { redirect_to request.referrer }
    end
  end

  def destroy
    current_user.likes.find_by(id: params[:id]).destroy
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("unlike_button_#{params[:post_id]}",
           partial: 'like_button_form', locals: { post_id: params[:post_id]}) 
      end
      format.html { redirect_to request.referrer }
    end
  end
end
