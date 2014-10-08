class Upload < ActiveRecord::Base
  include MimeChecker
  include Upload::Paperclippable

#========
#= ASSOC
#======

  belongs_to :user
  belongs_to :uploadable, polymorphic: true

#==============
#= VALIDATIONS
#============

  validates :user, presence: true

#============
#= CALLBACKS
#==========

  before_save :generate_name, unless: ->(u) {u.name.present?}

  def generate_name
    self.name = archive_file_name.parameterize
  end

end
