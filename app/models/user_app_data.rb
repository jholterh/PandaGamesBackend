class UserAppData < ApplicationRecord
  self.table_name = "user_app_data"

  belongs_to :user
  belongs_to :mini_app

  validates :user_id, uniqueness: { scope: :mini_app_id }
end
