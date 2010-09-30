class ChangeInvoiceDateNames < ActiveRecord::Migration
  def self.up
    rename_column :invoices, :start, :start_date
    rename_column :invoices, :end, :end_date
  end

  def self.down
    rename_column :invoices, :start_date, :start
    rename_column :invoices, :end_date, :end
  end
end
