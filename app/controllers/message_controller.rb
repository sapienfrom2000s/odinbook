class MessageController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_if_user_is_friend?, only: %i[index create]


  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message.creator = current_user
    @message.post_id = params[:post_id]

    respond_to do |format|
      if @message.save
        format.html { redirect_to post_url(Post.find(params[:post_id]).creator.username, params[:post_id]), notice: "Message was successfully made." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { redirect_to post_url(Post.find(params[:post_id]).creator.username, params[:post_id]), notice: "Something went wrong." }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body, :parent_id)
    end
end
