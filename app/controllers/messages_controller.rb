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

      # send to the channel
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )

      redirect_to chatrooms_path(chatroom: @chatroom.id, anchor: "message-#{@message.id}")
    else
      render "chatrooms/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
