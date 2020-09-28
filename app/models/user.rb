class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :password_digest, presence: true
end
