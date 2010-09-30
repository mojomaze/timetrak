class InvoicesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  respond_to :html, :js
 
  def index
    params[:page] ||= 1
    @invoices = Invoice.search(params[:search], params[:page], current_user, sort_column, sort_direction)
  end
  
  def show
    @invoice = Invoice.find(params[:id])
    @projects = @invoice.find_totals_by_project
    # add in total_non_billed
    @projects_nonbilled = @invoice.hours_by_project_non_billed
    @projects.each do |project|
      tmp = @projects_nonbilled.detect{|p| p.number == project.number }
      project[:total_non_billed] = tmp ? tmp.total_hours : 0 
    end
    respond_with @invoice, @projects do |format|
      format.js   { render :layout => false }
    end
  end

  def new
    @invoice = Invoice.new(:client_id => current_user.preferences[:invoice_client_id], :user_id => current_user.id)
    respond_with @invoice do |format|
      format.html { render :action => "show" }
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
    respond_with @invoice do |format|
      format.js { render :action => "edit", :layout => false }
    end
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    @invoice.save
    respond_with @invoice do |format|
      if @invoice.invalid?
        format.js   { render :action => "error", :layout => false }
      else
        @projects = @invoice.find_totals_by_project
        # add in total_non_billed
        @projects_nonbilled = @invoice.hours_by_project_non_billed
        @projects.each do |project|
          tmp = @projects_nonbilled.detect{|p| p.number == project.number }
          project[:total_non_billed] = tmp ? tmp.total_hours : 0 
        end
        format.js  { render :action => "update", :layout => false }
      end
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    respond_with @invoice.update_attributes(params[:invoice]) do |format|
      if @invoice.invalid?
        format.js   { render :action => "error", :layout => false }
      else
        @projects = @invoice.find_totals_by_project
        # add in total_non_billed
        @projects_nonbilled = @invoice.hours_by_project_non_billed
        @projects.each do |project|
          tmp = @projects_nonbilled.detect{|p| p.number == project.number }
          project[:total_non_billed] = tmp ? tmp.total_hours : 0 
        end
        format.js  { render :action => "update", :layout => false }
      end
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    respond_with @invoice
  end
  
  def send_invoice
    @invoice = Invoice.find(params[:id])
    if @invoice.send_invoice
      flash[:notice] = "Invoice successfully sent"
    end
    redirect_to @invoice
  end
  
  def list_action
    case params[:action_type]
    when 'delete'
      params[:action_id].each do |id|
        @invoice = Invoice.find(id)
        @invoice.destroy
      end
      params[:page] ||= 1
      @invoices = Invoice.search(params[:search], params[:page], current_user, sort_column, sort_direction)
      respond_with @activities do |format|
        format.js   { render :action => "destroy", :layout => false }
      end
    end
  end
  
  private
  
  def sort_column
    session[:invoice_sort_column] ||= 'number'
    session[:invoice_sort_column] = Invoice.column_names.include?(params[:sort]) ? params[:sort] : session[:invoice_sort_column]
  end
  
  def sort_direction
    session[:invoice_sort_direction] ||= 'desc'
    session[:invoice_sort_direction] = %w[asc desc].include?(params[:direction]) ? params[:direction] : session[:invoice_sort_direction]
  end
end
