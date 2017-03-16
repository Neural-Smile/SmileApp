class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :master_image, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  def self.authenticate_with_vision(b64image)
    if Random.rand < 0.5
      User.first
    end
  end

  def self.decode_image(base64_str)
    Base64.decode64(base64_str)
  end

  def self.encode_image(image)
    Base64.encode64(image)
  end

  def self.image_from_params(image_data)
    s = image_data.split(',')
    return nil if s[0] != 'data:image/png;base64'

    s[1]
  end
end
