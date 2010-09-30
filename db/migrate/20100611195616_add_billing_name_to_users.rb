class AddBillingNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :billing_name, :string
  end

  def self.down
    remove_column :users, :billing_name
  end
end
