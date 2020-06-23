class Inquiry < ApplicationRecord
  validates :name, presence: true
  validates :message, presence: true
  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
end
