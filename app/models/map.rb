class Map < ActiveRecord::Base

#========
#= ASSOC
#======

  belongs_to :author
  belongs_to :project

#==============
#= FRIENDLY_ID
#============

  extend FriendlyId
  friendly_id :url_name, use: [:slugged]

#==============
#= VALIDATIONS
#============

  validates :author, presence: true
  validates :project, presence: true
  validates :name, uniqueness: {case_sensitive: false, scope: :project_id}
  validates :url_name, uniqueness: {case_sensitive: false, scope: :project_id}

#============
#= CALLBACKS
#==========

  before_save :trim_spaces, if: ->(m) {m.new_record? || m.name_changed?}
  before_save :generate_default_url_name, unless: ->(m) {m.url_name.present?}
  before_save :default_lump, unless: ->(m) {m.lump.present?}

  def generate_default_url_name
    self.url_name = name
    self.send :set_slug
  end

  def trim_spaces
    self.name = name.strip.gsub(/\s+/, ' ')
    self.url_name = url_name.strip.gsub(/\s+/, ' ') if url_name
  end

  def default_lump
    self.lump = 'E1M1'
  end

end
