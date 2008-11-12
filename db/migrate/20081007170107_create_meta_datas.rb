class CreateMetaDatas < ActiveRecord::Migration
  def self.up
    create_table :meta_datas do |t|
      t.string :title
      t.text :keywords
      t.text :description
      t.integer :meta_id
      t.string :meta_type

      t.timestamps
    end
  end

  def self.down
    drop_table :meta_datas
  end
end
