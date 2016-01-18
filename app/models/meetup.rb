class Meetup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :title, presence: true
  validates :creator, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
