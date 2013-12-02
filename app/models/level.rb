class Level < ActiveRecord::Base
  attr_accessible :enemies, :objects, :tiles, :icon
  has_attached_file :icon
end