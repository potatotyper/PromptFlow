class User < ApplicationRecord
  has_secure_password

  has_many :prompt_session
  validates :email, presence: true
  validates :username, presence: true, uniqueness: true
end
