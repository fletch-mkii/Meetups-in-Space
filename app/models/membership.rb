class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup

  validates :user_id, presence: true
  validates :meetup_id, presence: true
  # validates :user, presence: true
  # validates :meetup, presence: true
end
