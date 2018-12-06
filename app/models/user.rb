class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_many :authentications, dependent: :destroy
  before_create { generate_token(:auth_token) }
  enum role: [:customer, :admin]
  has_secure_password

  # For every new User created, set the default role to :customer account-level
  after_initialize do
    if self.new_record?
      self.role ||= :customer
    end
  end

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

  def self.create_with_omniauth(auth)
    user = find_or_create_by(uid: auth[‘uid’], provider:  auth[‘provider’])
    user.email = "#{auth[‘uid’]}@#{auth[‘provider’]}.com"
    user.password = auth[‘uid’]
    user.name = auth[‘info’][‘name’]
    if User.exists?(user)
      user
    else
      user.save!
      user
    end
  end

end
