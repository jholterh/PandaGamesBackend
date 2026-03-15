class MiniApp < ApplicationRecord
  has_many :user_app_data, class_name: "UserAppData", dependent: :destroy
  has_many :leaderboard_entries, dependent: :destroy

  validates :slug, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :name, presence: true, length: { maximum: 100 }

  scope :published, -> { where(is_published: true) }
end
