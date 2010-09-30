require 'acts_as_list'

class ListValue < ActiveRecord::Base
  belongs_to :list
  acts_as_list :scope => :list
  
  before_validation :set_empty_value
  validates_presence_of :name, :list_id
  validates_uniqueness_of :name, :value, :scope => :list_id, :message => "is already in list"
  
  def set_empty_value
      self.value = self.name if self.value.blank?
  end
  
  def label
    label = name
  end 
end
