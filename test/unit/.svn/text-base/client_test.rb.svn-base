require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  
  test "invalid with empty attributes" do
    client = Client.new
    assert !client.valid?
    assert client.errors[:name].any?
    assert client.errors[:short_name].any?
  end
  
  test "name and short_name must be unique" do
    client_1 = Client.new( :name =>"Test Client", :short_name => "TC")
    client_2 = Client.new( :name =>"Test Client", :short_name => "TC")
    assert client_1.save
    assert !client_2.valid?
    assert client_2.errors[:name].include?("has already been taken")
    assert client_2.errors[:short_name].include?("has already been taken")
  end
  
  
end
