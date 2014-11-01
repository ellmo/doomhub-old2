class Project < ActiveRecord::Base
  include SlugUrlNameChecker

#========
#= ASSOC
#======

  belongs_to :user
  has_many :maps
  has_many :uploads, as: :uploadable
  has_many :images, as: :imageable

#==============
#= FRIENDLY_ID
#============

  extend FriendlyId
  friendly_id :url_name, use: [:slugged]

#==============
#= VALIDATIONS
#============

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :url_name, uniqueness: {case_sensitive: false}

end
