# This represents a user session
# @!attribute [rw] email
#   @return [String] the user email
# @!attribute [rw] password
#   @return [String] the user password
class Session
  include ActiveModel::API

  attr_accessor :email, :password
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
end
