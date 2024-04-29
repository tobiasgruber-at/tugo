class Favorite < ApplicationRecord
  belongs_to :user

  enum favorite_type: { course: 0, person: 1, thesis: 2, project: 3 }
end
