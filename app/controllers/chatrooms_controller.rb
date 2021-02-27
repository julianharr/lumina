class ChatroomsController < ApplicationController

  # Show all 'chatrooms' as conversations between users
  def index
    # Specify what users have access to the chatrooms
    @chatrooms = Chatroom.where(user: current_user)
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
  end

  def show
    # @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(user_two: current_user))
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages
    @message = Message.new
  end

  def create
    # @user_two_id = current_user.id
    # 27 Feb ----
    # Sending a new message will create a new chatroom
    @chatroom = Chatroom.new(chatroom_params)
    # @user = current_user.id
    @user_two = User.find(params[:user_two_id])

    @chatroom.user = current_user
    @chatroom.user_two = @user_two
    @chatroom.save!
    redirect_to chatroom_path(@chatroom)

    # ----


    # @booking.bike = Bike.find(params[:bike_id])
    # @booking.user = current_user
    # authorize @booking


    # # raise
    # if @booking.valid?
    #   @booking.save
    #   set_total_price(@booking.id) ## call method
    #   redirect_to dashboard_path
    # else
    #   flash[:alert] = @booking.errors.full_messages.to_sentence
    #   render :new
    # end

  end

  def destroy
    # Can a user delete a chat with another user or just end the session?
  end


  private

  def chatroom_params
    params.permit(:user_two_id)
  end
end
