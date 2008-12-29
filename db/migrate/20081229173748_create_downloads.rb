class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads, :force => true do |t|
      t.string :title
      t.text :body
      t.string :pdf_file_name
      t.string :pdf_content_type
      t.integer :pdf_file_size
      t.datetime :pdf_updated_at
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end
