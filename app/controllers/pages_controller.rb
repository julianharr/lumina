class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def about
  end

  def feed
    @user = current_user
    @users = User.all

    # @chatroom = Chatroom.new

    @chatroom = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @message = Message.create
    # @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @charities = Charity.all
    @charity = Charity.all.sample
  end

  def dashboard
    @user = current_user
    # authorize @user
  end

  def interests
    @user = current_user
  end

end
