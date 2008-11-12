class AddCoverToPresses < ActiveRecord::Migration
  def self.up
    add_column :presses, :cover_file_name, :string
    add_column :presses, :cover_content_type, :string
    add_column :presses, :cover_file_size, :integer
    add_column :presses, :cover_updated_at, :datetime
  end

  def self.down
    remove_column :presses, :cover_updated_at
    remove_column :presses, :cover_file_size
    remove_column :presses, :cover_content_type
    remove_column :presses, :cover_file_name
  end
end
