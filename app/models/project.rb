class Project < ActiveRecord::Base

#========
#= ASSOC
#======

  belongs_to :user

#==============
#= FRIENDLY_ID
#============

  extend FriendlyId
  friendly_id :url_name, use: [:slugged]

#==============
#= VALIDATIONS
#============

  validates :name, presence: true, uniqueness: {case_sensitive: false}

#============
#= CALLBACKS
#==========

  before_save :generate_default_url_name, unless: ->(p) {p.url_name.present?}

  def generate_default_url_name
    self.url_name = name
    self.send :set_slug
  end

end
