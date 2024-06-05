# This represents a single keyword for a favorite.
class Keyword < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :favorite
  validates :title, presence: true, allow_blank: false
end
