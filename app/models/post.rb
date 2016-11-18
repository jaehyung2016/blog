class Post < ApplicationRecord
  belongs_to :user, inverse_of: :posts
  validates :content, presence: true
end
