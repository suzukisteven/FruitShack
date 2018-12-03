class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_many :authentications, dependent: :destroy
  has_secure_password
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      firstname: auth_hash["info"]["firstname"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication
    return user
  end

  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end

end
