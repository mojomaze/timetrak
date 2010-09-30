class User < ActiveRecord::Base
  
  serialize :prefs
  
  has_many :activities, :dependent => :destroy
  has_many :invoices, :dependent => :destroy
  has_many :projects, :through => :activities
  
  validates :username, :uniqueness => true, :presence => true
  validates :full_name, :presence => true
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :confirmable, :timeoutable and :activatable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :full_name, :billing_name, :email, :password, :password_confirmation
  
  def preferences
    return self.prefs if self.prefs.kind_of? Hash
    build_prefs
  end
  
  # prefs changed to hash instead of model
  # rails 3.0.0 throws an exception when serializing UserPreference
  # and the hash is a little simpler anyway
  
  #   
  #   # setup user prefences and default to nil if not populated
  #   def prefs
  #     # make sure we always return a UserPreference instance
  #     if read_attribute(:prefs).nil?
  #       write_attribute :prefs, UserPreference.new
  #       read_attribute :prefs
  #     else
  #       read_attribute :prefs
  #     end
  #   end
  # 
  #   def prefs=(val)
  #     write_attribute :prefs, val
  #   end
  
  # def update_preferences(prefs = {})
  #     prefs.each do |name, value|
  #       self.prefs.send(name.to_s + '=', value)
  #       save(false)
  #     end
  #   end
  
  private
  
  def build_prefs
    prefs = {
      :invoice_client_id => nil,
      :activity_service => nil,
      :activity_type => nil,
      :activity_project_id => nil,
      :date_format => nil
    }
  
  end
  
end
