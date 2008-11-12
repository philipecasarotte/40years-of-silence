class CreatePresses < ActiveRecord::Migration
  def self.up
    create_table :presses, :force => true do |t|
      t.string :title, :pdf_file_name, :pdf_content_type
      t.text :description
      t.integer :pdf_file_size, :position
      t.datetime :pdf_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :presses
  end
end