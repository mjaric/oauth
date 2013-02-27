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

  def self.from_omniauth(auth)
    email = auth['info']['email']
    if email
      where(:email => email).first || create_from_omniauth(auth)
    else
      create_from_omniauth(auth)
    end
  end

  def create_from_omniauth(omniauth)
    self.name = omniauth['info']['name']
    self.email = omniauth['info']['email'] if self.email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def apply_omniauth(omniauth)
    email = omniauth['info']['email']
    if email
      User.where(:email => email).first || create_from_omniauth(omniauth)
    else
      create_from_omniauth(omniauth)
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end


  ROLES = %w[admin moderator customer]

end
