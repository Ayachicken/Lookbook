class Inquiry < ApplicationRecord
  validate :name, presence: true
  validate :message, presence: true
  validate :email, presence: true
end
