class Inquiry < ApplicationRecord
  validates :name, presence: true
  validates :message, presence: true
  validates :email, presence: true
end
