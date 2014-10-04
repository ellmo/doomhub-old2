class Author < ActiveRecord::Base

  belongs_to :user

#=============
#= VALIDATION
#===========

  validates :name, presence: true, uniqueness: true

  def login
    self.user_id ? user.login : self.name
  end

end
