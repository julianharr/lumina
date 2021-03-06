class FriendsController < ApplicationController
  before_action :authenticate_user!
  def index
    user_signed_in?
    c_user
    @friends = @user.friends
    @requests = @user.requested_friends
    @pending = @user.pending_friends
    # raise
  end

  def create
    c_user
    friend = find_by_user
    @user.friend_request(friend)
    redirect_to friends_path, notice: "Your friend request was sent to #{friend.first_name}"
  end

  def add
    c_user
    friend = find_by_user
    @user.accept_request(friend)
    redirect_to friends_path, notice: "You and #{friend.first_name} are now friends"
  end

  def remove
    c_user
    friend = find_by_user
    @user.decline_request(friend)
    redirect_to friends_path, notice: "You ignored the request from #{friend.first_name}"
  end

  def block
    c_user
    friend = find_by_user
    @user.block_friend(friend)
    redirect_to friends_path, notice: "You have Blocked #{friend.first_name}"
  end

  def delete
    c_user
    friend = find_by_user
    @user.remove_friend(friend)
    redirect_to friends_path, notice: "You and #{friend.first_name} are no longer friends"
  end

  def search
    @search = params[:search].to_s.downcase.gsub(/\s+/, '')
    @results = User.all.select do |user|
      user.first_name.downcase.include?(@search)
    end

    # include PgSearch::Model
    # pg_search_scope :search_by_first_and_last_name,
    # against: [ :first_name, :last_name ],
    # using: {
    #   tsearch: { prefix: true } # <-- now `superman batm` will return something!
    # }
  end

  private

  def find_by_user
    User.find_by(id: params[:format])
  end

  def c_user
    @user = current_user
  end
end
