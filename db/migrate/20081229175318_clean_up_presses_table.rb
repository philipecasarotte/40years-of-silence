class CleanUpPressesTable < ActiveRecord::Migration
  def self.up
    remove_column :presses, :pdf_file_name
    remove_column :presses, :pdf_content_type
    remove_column :presses, :pdf_file_size
    remove_column :presses, :pdf_updated_at
    remove_column :presses, :pdf_description
    rename_column :presses, :description, :body
  end

  def self.down
    add_column :presses, :pdf_file_name, :string
    add_column :presses, :pdf_content_type, :string
    add_column :presses, :pdf_file_size, :integer
    add_column :presses, :pdf_updated_at, :datetime
    add_column :presses, :pdf_description, :text
    rename_column :presses, :body, :description
  end
end
