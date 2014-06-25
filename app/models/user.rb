class User < ActiveRecord::Base

#=========
#= DEVISE
#=======

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

#=============
#= VALIDATION
#===========

  validates :login, uniqueness: {case_sensitive: false}, presence: true
  validates :email, uniqueness: {case_sensitive: false}
end
