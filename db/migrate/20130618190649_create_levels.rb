class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :tiles
      t.string :objects
      t.string :enemies

      t.timestamps
    end
  end
end
