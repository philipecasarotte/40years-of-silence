class CreatePages < ActiveRecord::Migration
  extend MigrationHelper
  
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :permalink
      t.timestamps
    end
    create_table :pages_parents, :id => false do |t|
      t.references :page, :parent
    end
    foreign_key :pages_parents, :page_id, :pages
    foreign_key :pages_parents, :parent_id, :pages
  end

  def self.down
    drop_table :pages_parents
    drop_table :pages
  end
end
