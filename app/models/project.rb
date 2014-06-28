class Project < ActiveRecord::Base

#========
#= ASSOC
#======

  belongs_to :user
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

#============
#= CALLBACKS
#==========

  before_save :trim_spaces, if: ->(p) {p.new_record? || p.name_changed?}
  before_save :generate_default_url_name, unless: ->(p) {p.url_name.present?}

  def generate_default_url_name
    self.url_name = name
    self.send :set_slug
  end

  def trim_spaces
    self.name = name.strip.gsub(/\s+/, ' ')
    self.url_name = url_name.strip.gsub(/\s+/, ' ') if url_name
  end

end
