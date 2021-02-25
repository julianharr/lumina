class ChatroomsController < ApplicationController

  # Show all 'chatrooms' as conversations between users
  def index
    # @chatrooms = Chatroom.all
    # Specify what users have access to the chatrooms
    @chatrooms = Chatroom.where(user: current_user)
  end

  # Show individual chat thread
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @messages = Message.where(user: current_user).or(Message.where(user_two: current_user))
  end

  def create
    @user = current_user.id
    @chatroom = Chatroom.new

    if @chatroom.valid?
      @chatroom.save
      redirect_to chatrooms_path
    end
  end

  def destroy
    # Can a user delete a chat with another user or just end the session?
  end
end
