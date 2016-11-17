class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy, inverse_of: :user
  validates :email, :first_name, presence: true
  validates :email, uniqueness: {message: "%{value} is already registered."}
end
