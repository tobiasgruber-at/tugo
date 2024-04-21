class Session
  include ActiveModel::API

  attr_accessor :email, :password
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
end
