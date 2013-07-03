class AddPlaysToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :plays, :integer, default: 0
  end
end
