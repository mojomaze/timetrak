class UserPreference
  
  attr_accessor :invoice_client_id, :activity_project_id, :activity_service, :activity_type, :date_format
  
  def initialize
    @invoice_client_id = nil
    @activity_service = nil
    @activity_type = nil
    @activity_project_id = nil
    @date_format = nil
    
  end
  
end