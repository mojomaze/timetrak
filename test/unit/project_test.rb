require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  test "invalid with empty attributes" do
    project = Project.new
    assert !project.valid?
    assert project.errors[:client_id].any?
    assert project.errors[:name].any?
    assert project.errors[:number].any?
  end
  
  test "label and value virtual attributes populate correctly" do
    project = Project.new( :client_id => 1, :name => "Test Project", :number => "9999")
    assert_equal "9999", project.value
    assert_equal "9999: Test Project", project.label
  end
  
  test "project number must be unique" do
    project_1 = Project.new( :client_id => 1, :name => "Test Project", :number => "9999")
    project_2 = Project.new( :client_id => 1, :name => "Another Test Project", :number => "9999")
    assert project_1.save
    assert !project_2.valid?
    assert !project_2.errors[:number].include?("has already taken")
  end
  
  test "project search returns selection" do
    projects = Project.search("1001")
    assert_equal 1, projects.size
    projects = Project.search("grounds")
    assert_equal 1, projects.size
  end
end
