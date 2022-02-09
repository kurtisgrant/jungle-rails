class User < ActiveRecord::Base

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

end
