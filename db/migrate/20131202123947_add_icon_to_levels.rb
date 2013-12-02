class AddIconToLevels < ActiveRecord::Migration
  def self.up
  	add_attachment :levels, :icon
  end

  def self.down
    remove_attachment :levels, :icon
  end
end
