class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

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
    @current_user_status = Status.where(:user_id == @user.id).last if @user.status.count > (0)
    #THE CURRENT USER WHO JUST POSTED STATUS
    @user_for_status = User.where(id: @current_user_status.user_id) if @user.status.count > (0)
    #SELECT RANDOM FRIEND
    @friend_status = current_user.friends

    @chatrooms = Chatroom.where(user: current_user)
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))

    # DONATES STUFF
    @donates_current_user = Donate.all.where(user_id: current_user.id)
    @find_charity = Charity.where(id: @donates_current_user[0].charity_id) if @donates_current_user.exists?
    @find_user = User.where(id: @donates_current_user[0].user_id) if @donates_current_user.exists?
  end

  def dashboard
    @user = current_user
    # authorize @user
  end

  def interests
    @user = current_user
  end

  def ajax
    @user = current_user
    @users = User.all.sample(10)

    if @user.current_user_events.count.positive? && @user.current_user_events.count > 4
      @events = @user.current_user_events.sample(10)
    else
      @events = Event.all.sample(10)
      ##   find events from users interestes || cat or show none
    end

    @chatroom = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    # @message = Message.create
    # @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @charity = Charity.all.sample(10)
    # @charity = Charity.all.sample
    # stautus stuff
    @status = Status.new
    @current_user_status = Status.where(:user_id == @user.id).last if @user.status.count > (0)
    #THE CURRENT USER WHO JUST POSTED STATUS
    @user_for_status = User.where(id: @current_user_status.user_id) if @user.status.count > (0)
    #SELECT RANDOM FRIEND
    @friend_status = current_user.friends

    # @chatrooms = Chatroom.where(user: current_user)
    # @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @feed = [@user, @users, @events, @charity, @status].flatten
    # render json: @feed
    render text: render_to_string(partial: "components/feed_page/feed_randomising")
  end

  # def get_status_params
  #   params.require(:status).permit(:content)
  # end
end
