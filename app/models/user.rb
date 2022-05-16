class User < ApplicationRecord
  has_secure_password
  validates :login_id, presence: { message: 'を入力してください' }
  validates :password, presence: { message: 'を入力してください' }
end
