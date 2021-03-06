class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def about
  end

  def feed
    # @user = current_user
    @users = User.all.sample(10)
    @user = User.all
    @events = Event.all.sample(10)
    @status = Status.new
    # @chatroom = Chatroom.new
    @current_user_status = Status.all.where(:user_id == current_user.id).last
    @chatroom = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @message = Message.create
    # @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @charity = Charity.all.sample(10)
    # @charity = Charity.all.sample
    @user_for_status = User.where(id: @current_user_status.user_id)
  end

  def dashboard
    @user = current_user
    # authorize @user
  end

  def interests
    @user = current_user
  end

  private

  # def get_status_params
  #   params.require(:status).permit(:content)
  # end

end
