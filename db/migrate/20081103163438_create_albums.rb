class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums, :force => true do |t|
      t.string :title
      t.integer :position, :photos_count
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
