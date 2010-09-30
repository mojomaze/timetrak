class AddTotalNonBilledToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :total_non_billed, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :invoices, :total_non_billed
  end
end
