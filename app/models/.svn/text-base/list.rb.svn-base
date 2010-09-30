class List < ActiveRecord::Base
  has_many :list_values, :order => "position", :dependent => :destroy
  
  validates :name, :presence => true, :uniqueness => true
end
