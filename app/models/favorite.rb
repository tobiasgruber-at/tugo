# This represents a favorite
class Favorite < ApplicationRecord
  belongs_to :user
  has_many :keywords, dependent: :delete_all

  enum favorite_type: { course: 0, person: 1, thesis: 2, project: 3 }
end
