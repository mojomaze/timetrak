require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  
  fixtures :clients, :projects, :activities
  
  test "invalid with empty attributes" do
    activity = Activity.new
    assert !activity.valid?
    assert activity.errors[:project_id].any?
    assert activity.errors[:user_id].any?
    assert activity.errors[:activity_date].any?
    assert activity.errors[:service].any?
    assert activity.errors[:detail].any?
    assert activity.errors[:activity_type].any?
    assert activity.errors[:bill_type].any?
    assert activity.errors[:hours].any?
  end
  
  test "invalid with negative hours" do
    activity = activities(:mow_lawn)
    activity.hours = -1
    assert !activity.valid?
    assert activity.errors[:hours].include?("can't be negative - WTF!")
  end
  
  test "invalid with non-numeric hours" do
    activity = activities(:mow_lawn)
    activity.hours = 'abc'
    assert !activity.valid?
    assert activity.errors[:hours].any?
  end
  
  test "invalid without time or hours" do
    activity = activities(:mow_lawn)
    activity.hours = nil
    activity.end_time = nil
    activity.start_time = nil
    assert !activity.valid?
    assert activity.errors[:hours].include?(" or Time is required")
  end
  
  test "invalid if end_time is less then start_time" do
    activity = activities(:mow_lawn)
    activity.hours = 0.5
    activity.start_time = Time.parse("13:00")
    activity.end_time = Time.parse("12:00")
    assert !activity.valid?
    assert activity.errors[:end_time].include?("can't be less than Start time")
  end

  test "invalid if time and hours do not match" do
    activity = activities(:mow_lawn)
    activity.hours = 0.5
    activity.start_time = Time.parse("12:00")
    activity.end_time = Time.parse("13:00")
    assert !activity.valid?
    assert activity.errors[:hours].include?("and Time do not match")
  end
  
  test "hours calculate correctly from time" do
    activity = activities(:mow_lawn)
    activity.hours = 0
    activity.start_time = Time.parse("12:00")
    activity.end_time = Time.parse("13:15")
    assert activity.valid?, "#{activity.errors.count} errors on validation"
    assert activity.save, "activity not saved"
    assert_equal 1.25, activity.hours, "hours did not match time"
  end
  
end
