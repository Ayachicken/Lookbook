class Post < ApplicationRecord
  belongs_to :user
  belongs_to :scene
  has_many :photos, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # ↓はacts-as-taggable-on用記述
  acts_as_taggable_on :tags

  validates :post_title, presence: true
  validates :posted_text, presence: true
end
