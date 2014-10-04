class User < ActiveRecord::Base

  acts_as_paranoid

#========
#= ASSOC
#======

  has_one :author
  has_many :projects
  has_many :maps, through: :author

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

#============
#= CALLBACKS
#==========

  after_create :add_author

  def add_author
    self.create_author name: self.login
  end

  private :add_author

#==========
#= METHODS
#========

  def admin?
    admin_level > 0
  end

  def superadmin?
    admin_level > 1
  end

end
