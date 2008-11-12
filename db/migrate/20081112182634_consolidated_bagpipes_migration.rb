class ConsolidatedBagpipesMigration < ActiveRecord::Migration
  def self.up
    add_column :users, :type, :string
    add_column :users, :administrator, :boolean, :default=>false, :null=>false
    
    create_table :messages do |t|
      t.integer  :topic_id
      t.integer  :parent_id
      t.string   :title
      t.text     :content
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end

    add_index :messages, [:topic_id], :name => :index_messages_on_topic_id
    add_index :messages, [:parent_id], :name => :index_messages_on_parent_id

    create_table :topics do |t|
      t.string   :title
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
  
  def self.down
    remove_column :users, :administrator
    remove_column :users, :type
    drop_table :messages
    drop_table :topics
  end
end