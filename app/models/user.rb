class User < ActiveRecord::Base
  acts_as_authentic
  #attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username
  attr_accessible :email, :username, :password, :password_confirmation, :phone_number
  has_many :text_messages
end
