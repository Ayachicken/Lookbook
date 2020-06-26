class Scene < ApplicationRecord
  has_many :posts

  validates :scene_name, presence: true
  enum validity:['Invalid','Valid']
end
