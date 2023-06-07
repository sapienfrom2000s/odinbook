# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_username, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.where('user_id = ?', user.id)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find_by(user_id: user.id, id: params[:id])
    @comments = Comment.where(post_id:@post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @posts = Post.where('user_id = ?', user.id)
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(current_user.username, @post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(current_user.username, @post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_username
    user
    return if @user.username == current_user.username

    redirect_to posts_url(current_user.username),
                notice: 'You cannot access that page'
  end

  def user
    @user = User.where('lower(username) = ?', params[:username].downcase).first
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
