class CreateListValues < ActiveRecord::Migration
  def self.up
    create_table :list_values do |t|
      t.references :list
      t.integer :position
      t.string :name
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :list_values
  end
end
