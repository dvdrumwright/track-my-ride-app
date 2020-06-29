class User < ActiveRecord::Base
    has_secure_password



    validates :username, uniqueness: { case_sensitive: false }
    has_many :rides
end
