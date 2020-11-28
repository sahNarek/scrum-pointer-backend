class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: {case_sensitive: true}, length: {minimum: 6}
  has_many :sessions
end