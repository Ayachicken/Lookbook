class Photo < ApplicationRecord
  belongs_to :post
  attachment :photo
end
