class Cyclist < ActiveRecord::Base

  has_many :rides

  has_secure_password

  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

end
