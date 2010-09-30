require 'test_helper'

class ListValueTest < ActiveSupport::TestCase
  
  fixtures :lists
  
  test "invalid with empty attributes" do
    item = ListValue.new
    assert !item.valid?
    assert item.errors[:list_id].any?
    assert item.errors[:name].any?
  end
  
  test "blank value populates with name" do
    item = ListValue.new( :list_id => 1, :name => "Test Name")
    assert item.valid?
    assert_equal "Test Name", item.value
  end
  
  test "position number populates correctly" do
    item = ListValue.new( :list_id => 1, :name => "Test Name")
    assert item.save
    assert_equal 2, item.position
  end
  
  test "invalid when not unique to parent" do
    item_1 = ListValue.new( :list_id => 1, :name => "Test Name", :value => "TN")
    item_2 = ListValue.new( :list_id => 2, :name => "Test Name", :value => "TN")
    item_3 = ListValue.new( :list_id => 1, :name => "Test Name", :value => "TN")
    
    assert item_1.save
    assert item_2.valid?
    assert !item_3.valid?
    assert item_3.errors[:name].include?("is already in list")
    assert item_3.errors[:value].include?("is already in list")
  end
  
end
