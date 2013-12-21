class User < ActiveRecord::Base
  attr_accessible :password, :session_token, :username
  attr_reader :password

  before_validation :reset_session_token,  :on => :create
  validates :session_token, :username, :password_digest, :presence => true
  validates :username, :uniqueness => true

  has_many :goals
  has_many :cheers

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    if user && user.is_password?(password)
      user
    end
  end

  def password=(pass)
    self.password_digest = BCrypt::Password.create(pass)
    @password = pass
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    reset_session_token
    self.save!
  end

  def visible_goals
    Goal.where("is_private = ? OR user_id = ?", false, self.id)
  end

  def cheers_left
    5 - self.cheers.where("created_at > ?", 24.hours.ago).count
  end
end
