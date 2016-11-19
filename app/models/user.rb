class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy, inverse_of: :user
  validates :email, :first_name, presence: true
  validates :email, uniqueness: {message: "%{value} is already registered."}

  def to_s
    "#{first_name} #{last_name}"
  end
end
