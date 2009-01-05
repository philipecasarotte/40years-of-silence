class CreateStaffs < ActiveRecord::Migration
  def self.up
    create_table :staffs, :force => true do |t|
      t.string :name
      t.string :title
      t.text :body
      t.integer :position
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :staffs
  end
end
