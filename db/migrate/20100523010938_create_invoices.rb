class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string :number
      t.references :user
      t.date :start
      t.date :end
      t.date :sent

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
