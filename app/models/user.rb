# This represents a user.
class User < ApplicationRecord
  has_many :favorites, dependent: :delete_all

  PASSWORD_MIN_LENGTH = 6

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, allow_blank: false, length: { minimum: PASSWORD_MIN_LENGTH }

  # Stores the password hash if it is valid
  # @param [String] password the new password
  def password=(password)
    self[:password] = password.length < PASSWORD_MIN_LENGTH ? password : generate_digest(password)
  end

  # Checks if the entered password equals the stored hash
  # @param [String] password the entered password
  def authenticate(password)
    self[:password] == generate_digest(password)
  end

  private

  # Generates a Sha256 digest
  # @param [String] password the password to digest
  def generate_digest(password)
    Digest::SHA256.hexdigest(password)
  end
end
