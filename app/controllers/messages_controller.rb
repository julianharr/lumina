class MessagesController < ApplicationController
  def new
  end

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    # @chatroom.user = current_user

    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user

    if @message.save

      redirect_to chatrooms_path
    else
      render "chatrooms/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
