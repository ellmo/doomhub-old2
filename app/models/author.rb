class Author < ActiveRecord::Base

  belongs_to :user
  has_many :maps

#=============
#= VALIDATION
#===========

  validates :name, presence: true, uniqueness: true

#=========
#= SCOPES
#=======

  scope :unregistered, ->{ where user_id: nil }

#==========
#= METHODS
#========

  def login
    self.user_id ? user.login : self.name
  end

end
