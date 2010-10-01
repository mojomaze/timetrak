class Project < ActiveRecord::Base
  belongs_to :client
  has_many :activities, :dependent => :destroy
  
  validates_presence_of :client_id, :name
  validates :number, :presence => true, :uniqueness => true
  
  # sets the default pagination limit
  cattr_reader :per_page
  @@per_page = 40
  
  # search or return all user activities
  def self.search(query, page, sort_column, sort_direction)
    if query
      search = "%#{query}%"
      return order(sort_column+" "+sort_direction).where("name LIKE ? OR number LIKE ?", search, search).paginate(:page => page, :per_page => self.per_page)
   end
   order(sort_column+" "+sort_direction).paginate(:page => page, :per_page => self.per_page)
  end
  
  # called from views/projects/index.js.erb with json encode  
  def label
    label = "#{number}: #{name}"
  end 
  # called from views/projects/index.js.erb with json encode  
  def value
    value = number
  end
  
  def self.invoice_totals(start_date, end_date, user_id)
    select = 'projects.*, SUM(activities.hours) AS total_hours'
    select += ', SUM(activities.hours) * projects.rate_internal AS cost_internal'
    order("projects.number").joins(:activities).select(select).where("activities.activity_date >= ? AND activities.activity_date <= ? AND activities.user_id = ? AND activities.bill_type = ?", start_date, end_date, user_id, "1").group("projects.id, projects.client_id")    
  end
  
end
