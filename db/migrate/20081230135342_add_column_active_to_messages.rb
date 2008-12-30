class AddColumnActiveToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :active, :boolean
  end

  def self.down
    remove_column :messages, :active
  end
end
