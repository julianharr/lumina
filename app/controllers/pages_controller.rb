class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :feed ]

  def home
  end

  def feed
    @user = current_user
    # authorize @user

    # Change to users' friends
    @users = User.all
    # @chatroom = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @chatroom = Chatroom.all
    @message = Message.new
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
  end

  def dashboard
    @user = current_user
    # authorize @user
  end
end
