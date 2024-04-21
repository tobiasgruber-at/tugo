class User < ApplicationRecord
  PASSWORD_MIN_LENGTH = 6

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, allow_blank: false, length: {minimum: PASSWORD_MIN_LENGTH}

  def password=(password)
    self[:password] = password.length < PASSWORD_MIN_LENGTH ? password : generate_digest(password)
  end

  def authenticate(password)
    self[:password] == generate_digest(password)
  end

  private

  def generate_digest(password)
    Digest::SHA256.hexdigest(password)
  end
end
