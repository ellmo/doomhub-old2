class Upload < ActiveRecord::Base

#========
#= ASSOC
#======

  belongs_to :user
  belongs_to :uploadable, polymorphic: true

#============
#= PAPERCLIP
#==========

  has_attached_file :archive,
                    keep_old_files: true,
                    url: ':path',
                    path: 'tmp'

end
