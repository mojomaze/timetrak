class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.date :activity_date
      t.references :project
      t.string :service
      t.string :detail
      t.string :activity_type
      t.time :start_time
      t.time :end_time
      t.decimal :hours, :precision => 8, :scale => 2, :default => 0
      t.string :bill_type

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
