class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos, :force => true do |t|
      t.string :title, 
               :image_file_name, 
               :image_content_type
      t.integer :position, 
                :image_file_size
      t.datetime :image_updated_at
      t.references :album
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
