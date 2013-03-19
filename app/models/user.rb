class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :orders
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  attr_accessible :role

  def admin?
    self.role == 'admin'
  end

  def self.from_omniauth(omniauth)
    email = omniauth['info']['email']
    if email
      user = User.user_from_database(email, omniauth)
      user ||= create_from_omniauth(omniauth)
    else
      user = create_from_omniauth(omniauth)
    end
    user
  end

  def self.user_from_database(email, omniauth)
    user = User.where(:email => email).first
    if user
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
    user
  end

  def self.create_from_omniauth(omniauth)
    user = User.new
    if omniauth['info']
      user.name = omniauth['info']['name']
      user.email = omniauth['info']['email'] if user.email.blank?
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
    user
  end

  def apply_omniauth(omniauth)
    if omniauth['user_info']
      self.email = omniauth['user_info']['email'] if email.blank?
      authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
  end

  def needs_password?
    #logger.debug(authentications.empty?)
    #logger.debug(!encrypted_password.blank?)
    authentications.empty?
  end


  ROLES = %w[admin moderator customer]

end
