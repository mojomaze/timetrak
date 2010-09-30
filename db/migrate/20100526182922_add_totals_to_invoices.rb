class AddTotalsToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :total_hours, :decimal, :precision => 8, :scale => 2, :default => 0
    add_column :invoices, :total_cost_internal, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :invoices, :total_hours
    remove_column :invoices, :total_cost_internal
  end
end
