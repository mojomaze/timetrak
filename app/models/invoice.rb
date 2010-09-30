class Invoice < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  
  validates :user_id, :client_id, :start_date, :end_date, :presence => true
  validates :number, :uniqueness => true, :presence => true
  
  validate :date_range_valid?
  
  before_save :update_totals
  
  # sets the default pagination limit
  cattr_reader :per_page
  @@per_page = 40
  
  # setting default values
  def initialize(attributes=nil)
      super(attributes)
      self.number ||= Invoice.next_number 
      self.start_date ||= Date.today
      self.end_date ||= self.start_date + 6 if self.start_date
  end
  
  # search or return all user activities
  def self.search(query, page, user, sort_column, sort_direction)
    if query
      search = "%#{query}%"
      return user.invoices.order(sort_column+" "+sort_direction).where("number LIKE ?", search).paginate(:page => page, :per_page => self.per_page)
   end
   user.invoices.order(sort_column+" "+sort_direction).paginate(:page => page, :per_page => self.per_page)
  end
  
  def self.next_number
    next_number = 1
    invoice = Invoice.order("number DESC").first
    if invoice
      next_number = invoice.number.to_i + 1
    end
    return next_number
  end
   
  # outputs invoice activities in csv formatted iif file
  def to_iif
    csv_content =  CSV.generate(:col_sep => "\t", :row_sep => "\r\n") do |csv|
      csv << ["!TIMERHDR","VER","REL","COMPANYNAME","IMPORTEDBEFORE","FROMTIMER","COMPANYCREATETIME",nil,nil,nil]
      csv << ["TIMERHDR","7",nil,"Solo Group, Inc.","N","Y","893777635",nil,nil,nil]
      csv << ["!TIMEACT","DATE","JOB","EMP","ITEM","PITEM","DURATION","PROJ","NOTE","XFERTOPAYROLL","BILLINGSTATUS"]
      
      # loop through the activities using the instance method and format
      invoice_activities.each do |a|
        csv << [ "TIMEACT", a.activity_date.strftime("%m/%d/%y"), a.project.billing_name,
                  a.user.billing_name, a.service, nil, "%0.2f" % a.hours, a.activity_type, a.detail.upcase!, "N", a.bill_type ]
      end
    end
    return csv_content
  end
  
  def date_range_valid?
    if start_date && end_date
      if new_record?
        invoices = Invoice.where('(? BETWEEN start_date AND end_date) OR (? BETWEEN start_date AND end_date) OR (start_date > ? AND end_date < ?)', start_date, end_date, start_date, end_date)
      else
        invoices = Invoice.where('((? BETWEEN start_date AND end_date) OR (? BETWEEN start_date AND end_date) OR (start_date > ? AND end_date < ?)) AND id != ?', start_date, end_date, start_date, end_date, id)
      end
      if invoices.any?
        errors[:base] << "Dates can't overlap with another invoice"
        return
      end
    end
  end
  
  # uses the many through to find all user activities then finds only activities with invoice dates
  def invoice_activities
    user.activities.where("activity_date >= ? AND activity_date <= ?", start_date, end_date)
  end
  
  # gets the total number of non-billed hours for invoice dates and user
  def total_non_billed_hours
    invoice_activities.non_billed.sum(:hours)
  end
  
  # collection of project numbers and total hours 
  def hours_by_project
    activities = invoice_activities.hours_by_project
  end
  
  def hours_by_project_billed
      activities = invoice_activities.hours_by_project.billed
  end
  
  def hours_by_project_non_billed
      activities = invoice_activities.hours_by_project.non_billed
  end
  
  # collection of activity services and total hours
  def hours_by_service
    activities = invoice_activities.hours_by_service
  end
  
  def hours_by_service_billed
      activities = invoice_activities.hours_by_service.billed
  end
  
  def hours_by_service_non_billed
     activities = invoice_activities.hours_by_service.non_billed
  end
  
    # collection of activity action types and total hours
  def hours_by_activity_type
    activities = invoice_activities.hours_by_activity_type
  end
  
  def hours_by_activity_type_billed
      activities = invoice_activities.hours_by_activity_type.billed
  end
  
  def hours_by_activity_type_non_billed
    activities = invoice_activities.hours_by_activity_type.non_billed
  end
  
  # returns collection of projects with totals
  def find_totals_by_project
    Project.invoice_totals(start_date, end_date, user_id)
  end
  
  # updates invoice total attributes before save
  def update_totals
    hours = 0
    cost_internal = 0
    projects = find_totals_by_project
    projects.each do |project|
      hours += project.total_hours.to_f
      cost_internal += project.cost_internal.to_f
    end
    self.total_hours = hours
    self.total_cost_internal = cost_internal
    self.total_non_billed = total_non_billed_hours
  end
  
  # send invoice and updates the sent attributes
  def send_invoice
    # pass resend into the mailer to add 'REVISED' to subject
    if self.sent
      resend = true
    else
      resend = false
    end
    self.sent = Date.today
    if self.save
      InvoiceMailer.client_invoice(self, resend).deliver
      return true
    end
  end
end
