class Photo < ApplicationRecord
  belongs_to :post
  attachment :post_image
  validates :post_image, presence: true
end
