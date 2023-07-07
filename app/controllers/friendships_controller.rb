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
    @friendship = Friendship.new(metadata_id: friendship_params[:friendrequest_id])
    @friendship = nil unless FriendRequest.find(friendship_params[:friendrequest_id]).receiver == current_user

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to friendships_url, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @connection = FriendRequest.find(friendship_params[:friendrequest_id])
    destroyed = @connection.destroy if @connection.sender == current_user || @connection.receiver == current_user

    respond_to do |format|
      if destroyed
        format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :index, notice: 'Unable to remove friend' }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
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
