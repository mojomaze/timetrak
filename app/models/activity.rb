class Activity < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  def before_validation
    self.hours = 0 if hours.blank?
  end
  
  validates :project_id, :user_id, :activity_date, :service, :detail, :activity_type, :bill_type, :presence => true
  validates :hours, :numericality => true
  validate :time_or_hours?, :within_invoice?
  
  before_save :verify_hours
  after_save :update_invoice_totals
  
  # sets the default pagination limit
  cattr_reader :per_page
  @@per_page = 40
  
  # search or return all user activities
  def self.search(query, page, user, sort_column, sort_direction)
    if query
      search = "%#{query}%"
      return user.activities.order(sort_column+" "+sort_direction).joins(:project).where("projects.number LIKE ? OR detail LIKE ?", search, search).paginate(:page => page, :per_page => self.per_page)
   end
   user.activities.order(sort_column+" "+sort_direction).paginate(:page => page, :per_page => self.per_page)
  end
  
  # finds activities based on dates, project, user
  # todo: change find_by_date_range to take a hash so params are clearer
  def self.find_by_date_range(start_date, end_date, project_id = nil, user_id = nil)
    case
    when project_id && user_id
      order("activity_date").where("project_id = ? AND activity_date >= ? AND activity_date <= ? AND user_id = ?", project_id, start_date, end_date, user_id)
    when project_id
      order("activity_date").where("project_id = ? AND activity_date >= ? AND activity_date <= ?", project_id, start_date, end_date)
    when user_id
      order("activity_date").where("user_id = ? AND activity_date >= ? AND activity_date <= ?", user_id, start_date, end_date)
    else
      order("activity_date").where("activity_date >= ? AND activity_date <= ?", start_date, end_date)  
    end
  end
  
  # names scoped defined as class methods
  def self.billed
    where("bill_type = ?", "1")
  end
  
  def self.non_billed
    where("bill_type = ?", "0")
  end
  
  def self.hours_by_user
    select = 'users.id, users.username, SUM(activities.hours) AS total_hours'
    order("users.username").joins(:user).select(select).group("users.id")
  end
  
  def self.hours_by_service
    select = 'activities.service, SUM(activities.hours) AS total_hours'
    order("activities.service").select(select).group("activities.service")
  end
  
  def self.hours_by_activity_type
    select = 'activities.activity_type, SUM(activities.hours) AS total_hours'
    order("activities.activity_type").select(select).group("activities.activity_type")
  end
  
  def self.hours_by_project
    select = 'projects.number, SUM(activities.hours) AS total_hours'
    order("projects.number").joins(:project).select(select).group("projects.number")
  end
  
  # virtual attibute to hold invoice_id during validation when saving from invoice entry
  def invoice_id
    @invoice_id if @invoice_id
  end
  
  def invoice_id=(value)
    @invoice_id = value
  end
  
  def billed?
    true if self.bill_type == "1"
  end
  
  def time_or_hours?
    if hours
      # validate end time not less than start
      if end_time && start_time    
        if end_time < start_time
          errors.add(:end_time, "can't be less than Start time")
          return
        end
      end
    
      # validate time or hours submitted
      case
      # hours set to 0 in before_validate if blank submitted
      when hours == 0
        unless end_time && start_time
          errors.add(:hours, " or Time is required")
        end
      when hours < 0
        errors.add(:hours, "can't be negative - WTF!")  
      else
        # hours submitted - verify time
        case
        when end_time && start_time
          errors.add(:hours, "and Time do not match") if calc_hours != hours
        when end_time
          errors.add(:start_time, "is required if end time is sent")
        when start_time
          errors.add(:end_time, "is required if start time is sent")
        end
      end
    end
  end
  
  def within_invoice?
    if self.invoice_id
      invoice = Invoice.find_by_id(self.invoice_id)
      if invoice
        unless invoice.start_date <= activity_date && invoice.end_date >= activity_date
          errors.add(:activity_date, "is not within invoice dates")
        end
      end
    end
  end
  
  def verify_hours
      self.hours = calc_hours if hours == 0
  end
  
  def update_invoice_totals
    invoice = Invoice.where("start_date <= ? AND end_date >= ?", activity_date, activity_date).first
    if invoice
      # updates the totals via the before_save callback
      invoice.save
    end
  end
  
  private
  
  def calc_hours
    calc_hours = ((end_time.to_f - start_time.to_f)/60)/60
    calc_hours.round(2)
  end
  
end
