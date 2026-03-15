class LeaderboardEntry < ApplicationRecord
  belongs_to :mini_app
  belongs_to :user

  validates :score, presence: true, numericality: { only_integer: true }
  validates :achieved_at, presence: true
end
