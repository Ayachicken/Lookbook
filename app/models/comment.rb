class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :comment, presence: true
end
