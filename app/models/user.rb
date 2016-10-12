class User < ActiveRecord::Base

	has_many :animals
	has_secure_password

end