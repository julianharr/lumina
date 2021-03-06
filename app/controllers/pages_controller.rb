class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def about
  end

  def feed
    @user = current_user
    @users = User.all.sample(10)

    if @user.current_user_events.count.positive? && @user.current_user_events.count > 4
      @events = @user.current_user_events.sample(10)
    else
      @events = Event.all.sample(10)
      ##   find events from users interestes || cat or show none
    end

    @chatroom = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @message = Message.create
    # @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @charity = Charity.all.sample(10)
    # @charity = Charity.all.sample
    # stautus stuff
    @status = Status.new
    @current_user_status = Status.where(:user_id == @user.id).last if Status.present?
    @user_for_status = User.where(id: @current_user_status.user_id)

    @chatrooms = Chatroom.where(user: current_user)
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
  end

  def dashboard
    @user = current_user
    # authorize @user
  end

  def interests
    @user = current_user
  end

  # def get_status_params
  #   params.require(:status).permit(:content)
  # end
end
