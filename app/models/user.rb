class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # associations
  has_one :wishlist, dependent: :destroy
  has_many :items, through: :wishlist, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  # Frienship Gem
  has_friendship

  # Taggable Gem
  acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests # You can also configure multiple tag types per mod

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## active storage
  has_one_attached :avatar

  INTERESTS = %w[arts music outdoors tech photography learning food family health wellness sports fitness writing language LGBTQ film sci-fi games books dance animals pets crafts fashion beauty business environment
                 dogs cats wildlife education]

  # friendship_stuff
  def strangers
    users = []
    User.all.each do |user|
      users << user if friends_with?(user) != true && self != user && friends.include?(user) != true && pending_friends.include?(user) != true && requested_friends.include?(user) != true
    end
    users
  end

  def users_friends
    friends
  end

  # def friend_request(user)
  #   FriendRequest.create(requester: self, requested: user)
  # end

  # def accept_request(user)
  #   FriendRequest.find_by(requester: self, requested: user).destroy
  #   Friendship.create(friender: self, friended: user)
  # end
end
