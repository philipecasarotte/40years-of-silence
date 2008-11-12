class AddPermalinkIntoAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :permalink, :string
    
    Album.all.each do |album|
      album.update_attribute(:updated_at, Time.now)
    end
  end

  def self.down
    remove_column :albums, :permalink
  end
end
