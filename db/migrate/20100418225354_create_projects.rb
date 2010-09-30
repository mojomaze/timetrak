class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :client
      t.string :name
      t.string :number
      t.decimal :rate_internal, :precision => 8, :scale => 2, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
