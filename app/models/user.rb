class User < ActiveRecord::Base
  attr_accessible :password, :session_token, :username
  attr_reader :password_digest

  before_validation :reset_session_token, on: :create
  validates :session_token, :username, :password_digest, :presence => true

  def password=(pass)
    self.password_digest = BCrypt::Password.new(pass)
  end

  def is_password?(pass)
    BCrypt::Password.create(self.password_digest).is_password?(pass)
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    reset_session_token
    self.save!
  end


end
