class User < ActiveRecord::Base

  acts_as_paranoid

#=========
#= DEVISE
#=======

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_for_database_authentication(conditions={})
    self.where(arel_table[:login].eq(conditions[:login])).first or
    self.where(arel_table[:email].eq(conditions[:login])).first
  end

#=============
#= VALIDATION
#===========

  validates :login, uniqueness: {case_sensitive: false}, presence: true
  validates :email, uniqueness: {case_sensitive: false}
end
