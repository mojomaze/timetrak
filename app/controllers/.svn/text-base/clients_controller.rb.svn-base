class ClientsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  respond_to :html, :js
  
  def index
    params[:page] ||= 1
    params[:search] ||= params[:term]
    @clients = Client.search(params[:search], params[:page], sort_column, sort_direction)
    respond_with @clients do |format|
      format.js   { render :action => "index", :layout => false }
    end
  end
  
  def show
    @client = Client.find(params[:id])
    @projects = @client.projects.order('number')
    respond_with @client do |format|
      format.js   { render :layout => false }
    end
  end

  def new
    @client = Client.new
    respond_with @client do |format|
      format.html { render :action => "show" }
    end
  end

  def edit
    @client = Client.find(params[:id])
    respond_with @client do |format|
      format.js { render :action => "edit", :layout => false }
    end
  end
  
  def create  
    @client = Client.new(params[:client])
    @client.save
    @projects = @client.projects.order('number')
    respond_with @client do |format|
      if @client.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  def update
    @client = Client.find(params[:id])
    @projects = @client.projects.order('number')
    respond_with @client.update_attributes(params[:client]) do |format|
      if @client.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    respond_with @client
  end
  
  def list_action
    case params[:action_type]
    when 'delete'
      params[:action_id].each do |id|
        @client = Client.find(id)
        @client.destroy
      end
      params[:page] ||= 1
      @clients = Client.search(params[:search], params[:page], sort_column, sort_direction)
      respond_with @clients do |format|
        format.js   { render :action => "destroy", :layout => false }
      end
    end
  end
  
  private
  
  def sort_column
    session[:client_sort_column] ||= 'name'
    session[:client_sort_column] = Client.column_names.include?(params[:sort]) ? params[:sort] : session[:client_sort_column]
  end
  
  def sort_direction
    session[:client_sort_direction] ||= 'asc'
    session[:client_sort_direction] = %w[asc desc].include?(params[:direction]) ? params[:direction] : session[:client_sort_direction]
  end
end
