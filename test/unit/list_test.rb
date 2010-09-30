require 'test_helper'

class ListTest < ActiveSupport::TestCase
  
  test "invalid with empty attributes" do
    list = List.new
    assert !list.valid?
    assert list.errors[:name].any?
  end
  
  test "name must be unique" do
    list_1 = List.new( :name => "Test List")
    list_2 = List.new( :name => "Test List")
    assert list_1.save
    assert !list_2.valid?
    assert list_2.errors[:name].include?("has already been taken")
  end
end
