class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  validates_presence_of :name, :email
  validates_presence_of :password,:if => :allow_validation
  validates_confirmation_of :password
  validates_length_of :password,:within => 6..20, :if => :allow_validation,:too_long => "pick a shorter password", :too_short => "pick a longer password"

  attr_accessor :password, :password_confirmation
  
  def show_name
    nickname or name
  end

  def authenticate(password)
    self.class.hashed_password(password, salt) == hashed_password
  end

  def allow_validation
    new_record?
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    self.salt = self.class.create_salt
    self.hashed_password = self.class.hashed_password(pwd,salt)
  end

  class << self
    include Authorizable
  end
end
