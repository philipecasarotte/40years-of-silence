class CreateFileAttributes < ActiveRecord::Migration
  def self.up
    create_table :file_attributes do |t|
      t.string :file_attributable_type
      t.belongs_to :file_attributable
      t.string :file_name, :null => false
      t.string :attribute_name, :null => false
      t.integer :file_size
      t.integer :serial, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :file_attributes
  end
end
