class AddBillingContactToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :billing_name, :string
    add_column :clients, :billing_email, :string
  end

  def self.down
    remove_column :clients, :billing_email
    remove_column :clients, :billing_name
  end
end
