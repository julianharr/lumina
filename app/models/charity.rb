class Charity < ApplicationRecord

  include AlgoliaSearch

  algoliasearch do
    attributes :name, :description, :location
  end


  # Search functionality
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true }
    }
  # associations
  has_many :donate
  has_many :users, through: :donate, dependent: :destroy

  # validations
  validates :location, presence: true
  validates :website, presence: true
  # validates :category, presence: true
  validates :name, presence: true
  validates :description, presence: true,
                          length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
