# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  # GET /friendships or /friendships.json
  def index
    @connections = Friendship.connections(current_user)
    @friend_requests = Friendship.requests(current_user)
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # POST /friendships or /friendships.json
  def create
    @friendrequest_id = friendship_params[:friendrequest_id]
    @friendship = Friendship.new(metadata_id: @friendrequest_id)
    @friendship = nil unless FriendRequest.find(@friendrequest_id).receiver == current_user

    respond_to do |format|
      if @friendship.save
        format.turbo_stream{ flash.now[:notice] = "Friend Request successfully accepted" }
        format.html { redirect_to friendships_url, notice: 'FriendRequest successfully accepted' }
      end
    end
  end

  def destroy
    @connection = FriendRequest.find(friendship_params[:friendrequest_id])
    destroyed = @connection.destroy if @connection.sender == current_user || @connection.receiver == current_user

    respond_to do |format|
      format.turbo_stream{ flash.now[:notice] = "Friend successfully unfriended" }
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
    end
  end

  def list_friends
    @friends = User.friends(current_user)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friendrequest_id)
  end
end
