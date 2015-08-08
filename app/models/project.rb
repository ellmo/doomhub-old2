class Project < ActiveRecord::Base
  include SlugUrlNameChecker

  acts_as_paranoid
  # attr_accessible :name, :user_id, :url_name, :description

#========
#= ASSOC
#======

  belongs_to :user
  belongs_to :item_access
  belongs_to :game
  belongs_to :source_port

  has_many :maps
  has_many :uploads, as: :uploadable
  has_many :images, as: :imageable

#==============
#= FRIENDLY_ID
#============

  extend FriendlyId
  friendly_id :url_name, use: [:slugged, :history]

#==============
#= VALIDATIONS
#============

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :url_name, uniqueness: { case_sensitive: false }

#=========
#= SCOPES
#=======

  scope :public_view,  where{ public_view == true }
  scope :private_view, where{ public_view == false }
  scope :public_join,  where{ public_join == true }
  scope :private_join, where{ public_join == false }

end
