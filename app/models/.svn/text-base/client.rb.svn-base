class Client < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :invoices
  
  validates :name, :short_name, :presence => true, :uniqueness => true
  
  # sets the default pagination limit
  cattr_reader :per_page
  @@per_page = 40
  
  # search or return all user activities
  def self.search(query, page, sort_column, sort_direction)
    if query
      search = "%#{query}%"
      return order(sort_column+" "+sort_direction).where("name LIKE ? OR short_name LIKE ?", search, search).paginate(:page => page, :per_page => self.per_page)
   end
   order(sort_column+" "+sort_direction).paginate(:page => page, :per_page => self.per_page)
  end
end
