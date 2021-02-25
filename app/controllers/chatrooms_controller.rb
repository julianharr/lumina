class ChatroomsController < ApplicationController

  # Show all 'chatrooms' as conversations between users
  def index
    @chatrooms = Chatroom.all
  end

  # Show individual chat thread
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    # User will click a button to show chat window. Do we need create method?
  end

  def destroy
    # Can a user delete a chat with another user or just end the session?
  end
end
