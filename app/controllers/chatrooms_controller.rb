class ChatroomsController < ApplicationController

  # Show all 'chatrooms' as conversations between users
  def index
    # Specify what users have access to the chatrooms
    @chatrooms = Chatroom.where(user: current_user)
  end

  def show
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @chatroom = Chatroom.find(params[:id])
    @messages = Message.where(user: current_user).or(Message.where(user_two: current_user))
    @message = Message.new
  end

  def create
    @user = current_user.id
    @user_two = current_user.id
    @chatroom = Chatroom.new
    @message = Message.new
  end

  def destroy
    # Can a user delete a chat with another user or just end the session?
  end
end
