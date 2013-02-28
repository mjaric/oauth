class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

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
      user.email = omniauth['info']['email']
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
    user
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end


  ROLES = %w[admin moderator customer]

end
