class Relationship < ApplicationRecord
  belongs_to :follow, class_name: "user"
  belongs_to :follower, class_name: "user"
end
