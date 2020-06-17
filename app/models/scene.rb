class Scene < ApplicationRecord
  has_many :posts

  validate :scene_name, presence: true
end
