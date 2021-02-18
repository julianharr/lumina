class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # Frienship Gem
  has_friendship

  # Taggable Gem
  acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests #You can also configure multiple tag types per mod

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ## active storage
  has_one_attached :avatar
end
