class InvoiceActivitiesController < ApplicationController
  
  respond_to :html, :xml, :json, :js
 
  def index
    if params.include?( :search )
      search = params[:search]
      case 
      when search.include?( :invoice_id )
        @invoice = Invoice.find_by_id( search[:invoice_id] )
      end
    end
    @invoice ||= Invoice.find_by_id( params[:invoice_id] )
    @invoice ||= current_user.invoices.last
    if @invoice
      build_split_totals
      @activities = @invoice.invoice_activities
    else
      redirect_to new_invoice_path and return
    end
    default_project = Project.find_by_id(current_user.preferences[:activity_project_id].to_i) if !current_user.preferences[:activity_project_id].blank?
    @activity = Activity.new(:activity_date => Date.today, 
                              :start_time => nil, 
                              :end_time => nil, 
                              :project => default_project,
                              :service => current_user.preferences[:activity_service],
                              :activity_type => current_user.preferences[:activity_type] )
    @invoices = User.find_by_id(current_user.id).invoices
    respond_with @activities, @invoice do |format|
      format.js   { render :layout => false}
    end
  end

  def show
    @invoice = Invoice.find_by_id(params[:invoice_id]) if params[:invoice_id]
    build_split_totals if @invoice
    respond_with @activity = Activity.find(params[:id]) do |format|
      format.js   { render :layout => false }
    end
  end

  def new
    @activity = Activity.new(:activity_date => Date.today, :start_time => Time.parse("00:00"), :end_time => Time.parse("00:00"))
    respond_with @activity 
  end

  def edit
    @activity = Activity.find(params[:id])
    respond_with @activity do |format|
      format.js { render :action => "edit", :layout => false }
    end
  end

  def create
    @activity = Activity.new(params[:activity])
    @activity.invoice_id = params[:invoice_id]
    respond_with @activity.save do |format|
      if @activity.invalid?
        # format.js   { render :action => "error", :layout => false }
        return_data = Hash.new()
        return_data[:success] = false
        return_data[:id] = "new"
        return_data[:errors] = @activity.errors
        format.js   { render :layout => false, :json => return_data.to_json }
      else
        @invoice = Invoice.find_by_id(@activity.invoice_id) if @activity.invoice_id
        build_split_totals if @invoice
        format.js   { render :action => "create", :layout => false }
      end 
    end
  end

  def update
    @activity = Activity.find(params[:id])
    @activity.invoice_id = params[:invoice_id]
    respond_with @activity.update_attributes(params[:activity]) do |format|
      if @activity.invalid?
        # format.js   { render :action => "error", :layout => false }
        return_data = Hash.new()
        return_data[:success] = false
        return_data[:id] = @activity.id
        return_data[:errors] = @activity.errors
        format.js   { render :layout => false, :json => return_data.to_json }
      else
        @invoice = Invoice.find_by_id(@activity.invoice_id) if @activity.invoice_id
        build_split_totals if @invoice
        format.js  { render :action => "show", :layout => false }
      end
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    respond_with @activity do |format|
      format.js   { render :action => "destroy", :layout => false }
    end
  end
  
  def list_action
    case params[:action_type]
    when 'delete'
      params[:action_id].each do |id|
        @activity = Activity.find(id)
        @activity.destroy
      end
      @invoice = Invoice.find_by_id( params[:invoice_id] )
      build_split_totals
      @activities = @invoice.invoice_activities
      respond_with @activities do |format|
        format.js   { render :action => "destroy", :layout => false }
      end
    end
  end
  
  private
  
  def build_split_totals
    @projects_total = @invoice.hours_by_project
    @projects_billed = @invoice.hours_by_project_billed
    @projects_nonbilled = @invoice.hours_by_project_non_billed
    @services_total = @invoice.hours_by_service
    @services_billed = @invoice.hours_by_service_billed
    @services_nonbilled = @invoice.hours_by_service_non_billed
    @types_total = @invoice.hours_by_activity_type
    @types_billed = @invoice.hours_by_activity_type_billed
    @types_nonbilled = @invoice.hours_by_activity_type_non_billed
  end
  
end
