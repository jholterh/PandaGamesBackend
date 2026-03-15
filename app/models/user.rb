class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :user_app_data, class_name: "UserAppData", dependent: :destroy
  has_many :leaderboard_entries, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }

  def generate_jwt
    JwtService.encode(sub: id)
  end
end
