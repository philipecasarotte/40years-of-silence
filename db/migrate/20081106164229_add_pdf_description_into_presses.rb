class AddPdfDescriptionIntoPresses < ActiveRecord::Migration
  def self.up
    add_column :presses, :pdf_description, :text
  end

  def self.down
    remove_column :presses, :pdf_description
  end
end
