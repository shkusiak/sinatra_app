class CreateUser < ActiveRecord::Base
  has_many :shoes

  has_secure_password

end
