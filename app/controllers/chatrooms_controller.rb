class ChatroomsController < ApplicationController

  def index
    @chatrooms = Chatroom.where(user: current_user)
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages
    @message = Message.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    @user_two = User.find(params[:user_two_id])

    @chatroom.user = current_user
    @chatroom.user_two = @user_two
    @chatroom.save!
    redirect_to chatroom_path(@chatroom)
  end

  def destroy
    # Can a user delete a chat with another user or just end the session?
  end


  private

  def chatroom_params
    params.permit(:user_two_id)
  end
end
