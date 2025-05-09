class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  # Validate that content is present.
  validates :content, presence: true, length: { maximum: 280 }
end