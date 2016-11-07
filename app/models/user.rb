class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :nullify, inverse_of: :user
end
