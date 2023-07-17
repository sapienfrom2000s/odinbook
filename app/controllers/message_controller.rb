
class MessageController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_user_is_friend?, only: %i[index create]


  # GET /messages or /messages.json
  def index
    @messages = Message.chats_between(current_user, params[:username])
    @message = Message.new
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.receiver = User.find_by(username: params[:username])
    @last_message = Message.last

    respond_to do |format|
      if @message.save
        format.html { redirect_to request.referrer }
        format.turbo_stream
      end
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end

    def check_if_user_is_friend?
      redirect_to message_friends_path unless User.friends(current_user).include?(User.find_by(username: params[:username]))
    end
end
